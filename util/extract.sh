#!/usr/bin/env bash

utildir=$(dirname "$0")

SRC_DIR=src

function usage() {
  exit_code=$1

  script_name=$(basename "$0")
  cat <<EOF
Usage:$script_name

Extracts all *.vtt files into a $SRC_DIR dir
EOF
  exit "$exit_code"
}

cd "$utildir" || (echo "Unable to traverse project." && usage 2)
while ! test -f package.json; do
  cd .. || (echo "Could not find root of project." && usage 3)
done

projdir=$(pwd)

failed=""

for f in *.vtt */*.vtt; do
  dir="$SRC_DIR/${f%.*}"
  file=$(basename -- "$f")
  mkdir -p "$dir"
  if which jar; then
    (cd "$dir" && jar xvf "$projdir/$f") || failed="$failed $file"
  else
    unzip -o "$projdir/$f" -d "$dir" # can't detect failures -- may exit with 1 due to absolute path of /assets; no mechanism to suppress warning to get a clean exit value
  fi
  #echo "exit: $?"
done

if [[ ! -z "$failed" ]]; then
  echo ""
  echo "Failures encountered extacting the following:"
  echo "$failed"
  exit 1
fi
