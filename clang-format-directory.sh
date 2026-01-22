#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configure as necessary if script is not in {WORKDIR}/{SCRIPT_FOLDER}
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

EXCLUDE_FILE=""
EXCLUDE_PATTERNS=(
  "soup/**"
  "build_*/**"
  "build/**"
)
CLANG_FORMAT_BIN="${CLANG_FORMAT_BIN:-clang-format}"

usage() {
  cat <<'USAGE'
Run clang-format on all C/C++ source and header files in the working directory.

Usage:
  scripts/clang_format_all.sh [-e exclude_file] [-x pattern]

Options:
  -e  File containing exclusion patterns (one per line, globs allowed).
  -x  Additional exclusion pattern (can be repeated).

Notes:
  - Patterns are matched against working-directory-relative paths.
  - Empty lines and lines starting with # in the exclude file are ignored.
USAGE
}

die() {
  echo "ERROR: $*" >&2
  exit 1
}

load_excludes() {
  if [ -n "$EXCLUDE_FILE" ]; then
    [ -f "$EXCLUDE_FILE" ] || die "Exclude file not found: $EXCLUDE_FILE"
    while IFS= read -r line || [ -n "$line" ]; do
      line="$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
      [ -z "$line" ] && continue
      [[ "$line" == \#* ]] && continue
      EXCLUDE_PATTERNS+=("$line")
    done < "$EXCLUDE_FILE"
  fi
}

is_excluded() {
  local rel="$1"
  local pat
  for pat in "${EXCLUDE_PATTERNS[@]}"; do
    if [[ "$rel" == $pat ]]; then
      return 0
    fi
  done
  return 1
}

while getopts ":e:x:h" opt; do
  case "$opt" in
    e) EXCLUDE_FILE="$OPTARG" ;;
    x) EXCLUDE_PATTERNS+=("$OPTARG") ;;
    h) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

shift $((OPTIND - 1))

command -v "$CLANG_FORMAT_BIN" >/dev/null 2>&1 || die "clang-format not found: $CLANG_FORMAT_BIN"

shopt -s globstar

load_excludes

retval=0

while IFS= read -r -d '' file; do
  rel="${file#"$ROOT_DIR"/}"
  if is_excluded "$rel"; then
    continue
  fi
  echo "--> Run clang-format on file $rel"
  if ! "$CLANG_FORMAT_BIN" -i -style=file "$file"; then
    retval=$((retval + 1))
  fi
done < <(
  find "$ROOT_DIR" -type f \( \
    -name "*.c" -o -name "*.cc" -o -name "*.cxx" -o -name "*.cpp" -o \
    -name "*.h" -o -name "*.hh" -o -name "*.hxx" -o -name "*.hpp" -o -name "*.ipp" \
  \) -print0
)

if [ "$retval" -ne 0 ]; then
  echo "$retval files contained errors."
fi

exit "$retval"
