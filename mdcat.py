import argparse
from rich.markdown import Markdown
from rich.console import Console

# Parse the command-line arguments
parser = argparse.ArgumentParser(description="Render and display Markdown file.")
parser.add_argument("filename", type=str, help="Path to the Markdown file")
args = parser.parse_args()

console = Console()

# Read the Markdown content from the file
with open(args.filename, "r") as file:
    markdown_content = file.read()

markdown = Markdown(markdown_content)

console.print(markdown)
