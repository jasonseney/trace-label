# TRACE Badge Generator (U0–U5) with dy="0.1em"
# Creates/overwrites 6 SVG files in the current directory.

for i in {0..5}; do
  filename="TRACE_U${i}.svg"
  width=156   # width for default badges
  height=28
  text="[TRACE U${i}]"

  cat > "$filename" <<EOF
<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height" viewBox="0 0 $width $height" role="img" aria-label="$text">
  <rect width="$width" height="$height" rx="8" fill="#5C3A5B"/>
  <text x="50%" y="50%" text-anchor="middle" dominant-baseline="middle" dy="0.1em"
        font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace"
        font-size="14" font-weight="700" fill="#FFFFFF">$text</text>
</svg>
EOF

  echo "Created $filename"
done
