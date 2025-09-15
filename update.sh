#!/bin/sh

if [ ! -f "./node_modules/.bin/marked" ]; then
    npm install marked
fi

rm -rf tmp
mkdir tmp
wget https://github.com/pjincz/nginx-cgi/raw/refs/heads/main/README.md -O tmp/README.md

cat index.html | sed -n '1,/-- doc_start --/{p}' > tmp/index.html
./node_modules/.bin/marked tmp/README.md >> tmp/index.html
cat index.html | sed -n '/-- doc_end --/,${p}' >> tmp/index.html

cp tmp/index.html index.html
