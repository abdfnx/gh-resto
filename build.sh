#!/bin/bash

set -e

tag="${1}"
versionDate="${2}"
release="${3}"

if [ "${tag}" == "" ]; then
  echo "tag argument required"
  exit 1
fi

if [ "${versionDate}" == "" ]; then
  echo "versionDate argument required"
  exit 1
fi

rm -rf rs
rm -rf dist

git clone https://github.com/abdfnx/resto rs
cd rs
go mod tidy

GOOS=darwin  GOARCH=amd64 go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/darwin-x86_64" 
GOOS=linux   GOARCH=386   go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/linux-i386"
GOOS=linux   GOARCH=amd64 go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/linux-x86_64"
GOOS=windows GOARCH=386   go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/windows-i386"
GOOS=windows GOARCH=amd64 go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/windows-x86_64"

mv dist ../
