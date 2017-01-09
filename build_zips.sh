#!/bin/sh
templates_dir="GPTs"
rm ./*.zip
for dir in "$templates_dir"/*; do
  template="$(basename "$dir")"
  echo "Processing $template"
  zip -r "$template.zip" META-INF fstab
  ZIP="$(readlink -f "$template.zip")"
  (cd "$dir" || exit 2; zip "$ZIP" ./*)
done