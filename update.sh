#!/bin/sh

set -e

if [ ! -f "./node_modules/.bin/marked" ]; then
    npm install marked
fi

rm -rf tmp
mkdir tmp
wget https://github.com/pjincz/nginx-cgi/raw/refs/heads/main/README.md -O tmp/README.md

cat index.html | sed -n '1,/-- doc_start --/{p}' > tmp/index.html
./node_modules/.bin/marked tmp/README.md >> tmp/index.html
cat index.html | sed -n '/-- doc_end --/,${p}' >> tmp/index.html

cat tmp/index.html | sed -n '1,/-- ver_start --/{p}' > tmp/index.html.2
curl -s https://api.github.com/repos/pjincz/nginx-cgi/releases/latest | jq -r .tag_name >> tmp/index.html.2
cat tmp/index.html | sed -n '/-- ver_end --/,${p}' >> tmp/index.html.2

cp tmp/index.html.2 index.html
