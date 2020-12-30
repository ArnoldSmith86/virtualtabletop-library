#!/usr/bin/env bash

utildir=$(dirname "$0")

SRC_DIR=src

function usage() {
  exit_code=$1

  script_name=$(basename "$0")
  cat <<EOF
Usage:$script_name

Builds the files in $SRC_DIR dir into vtt files
EOF
  exit "$exit_code"
}

cd "$utildir" || (echo "Unable to traverse project." && usage 2)
while ! test -f package.json; do
  cd .. || (echo "Could not find root of project." && usage 3)
done

projdir=$(pwd)

failed=""

cd "$SRC_DIR"

for f in */*.json */*/*.json; do
  subdir=$(dirname "$f")
  vtt_file="$projdir/${subdir}.vtt"

  #todo: filter out duplicates to prevent needlessly re-zip ones with multiple json files

  echo "$vtt_file <= $subdir"
  (rm -f "$vtt_file" && cd "$subdir" && zip "$vtt_file" -r *) || failed="$failed $file"
  echo ""
done

if [[ ! -z "$failed" ]]; then
  echo ""
  echo "Failures encountered building the following:"
  echo "$failed"
  exit 1
fi
