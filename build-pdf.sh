#!/bin/bash
# Build the Testat PDF from README.md (Mermaid blocks are rendered to PNG first).
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly OUTPUT_PDF="${1:-$SCRIPT_DIR/Rusch_Stadler_Manser_Audioverwaltung.pdf}"
readonly PDF_ENGINE="${PDF_ENGINE:-xelatex}"

for cmd in npx pandoc "$PDF_ENGINE"; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: $cmd not found" >&2
        exit 1
    fi
done

work_dir=$(mktemp -d)
trap 'rm -rf "$work_dir"' EXIT

# Replaces each mermaid block with an image reference: README-out.md + README-out-N.png
npx --yes -p @mermaid-js/mermaid-cli mmdc \
    -i "$SCRIPT_DIR/README.md" -o "$work_dir/README-out.md" -e png -s 2

pandoc "$work_dir/README-out.md" -o "$OUTPUT_PDF" \
    --resource-path="$work_dir" --pdf-engine="$PDF_ENGINE" -V geometry:margin=2cm

echo "Created $OUTPUT_PDF"
