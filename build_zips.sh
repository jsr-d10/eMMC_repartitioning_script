#!/bin/sh
E_GPTMD5MISMATCH=3
E_NOTEMPLATE=4
templates_dir="GPTs"
rm ./*.zip
for dir in "$templates_dir"/*; do
  template="$(basename "$dir")"
  echo "Processing $template"
  zip -r "$template.zip" META-INF fstab
  ZIP="$(readlink -f "$template.zip")"
  (
    cd "$dir" || exit "$E_NOTEMPLATE"
    if md5sum --check < new.gpt.md5sum; then
      zip "$ZIP" ./*
    else
      rm "$ZIP"
      echo "$template: GPT MD5 mismatch!"
      exit "$E_GPTMD5MISMATCH"
    fi
  ) || exit "$?"
  echo "\n"
done
