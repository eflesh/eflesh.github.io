#!/usr/bin/env bash
set -euo pipefail

# Compress all .mov files in the current directory to .mp4
# Usage: ./compress_mov_to_mp4.sh

for file in *.mov; do
  [ -e "$file" ] || continue  # skip if no .mov files found
  base="${file%.*}"
  out="${base}.mp4"

  echo "Compressing $file → $out"

  ffmpeg -hide_banner -loglevel warning -y -i "$file" \
    -c:v libx264 -preset slow -crf 18 \
    -c:a aac -b:a 192k \
    -movflags +faststart "$out"

  echo "Done: $out"
done
