#!/usr/bin/env bash
set -euo pipefail

if ! command -v clang-format >/dev/null 2>&1; then
  echo "clang-format not found. Please install clang-format to commit." >&2
  exit 1
fi

formatted_any=0

while IFS= read -r -d '' file; do
  case "$file" in
    *.c|*.cc|*.cpp|*.cxx|*.h|*.hh|*.hpp|*.hxx)
      clang-format -i -- "$file"
      git add -- "$file"
      formatted_any=1
      ;;
  esac
done < <(git diff --cached --name-only --diff-filter=ACM -z)

if [ "$formatted_any" -eq 1 ]; then
  echo "clang-format applied to staged files."
fi
