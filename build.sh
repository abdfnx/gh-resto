#!/bin/bash

set -e

tag="${1}"
versionDate="${2}"

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

GOOS=darwin  GOARCH=amd64 go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/darwin-x86_64-${tag}" 
GOOS=linux   GOARCH=386   go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/linux-i386-${tag}"
GOOS=linux   GOARCH=amd64 go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/linux-x86_64-${tag}"
GOOS=windows GOARCH=386   go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/windows-i386-${tag}"
GOOS=windows GOARCH=amd64 go build -ldflags "-X main.version=${tag} -X main.versionDate=${versionDate}" -o "dist/windows-x86_64-${tag}"

mv dist ../
