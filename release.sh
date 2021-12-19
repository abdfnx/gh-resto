#!/bin/bash

set -e

tag="${1}"
versionDate="${2}"

./build.sh "${tag}" "${versionDate}"
gh release create $tag ./dist/* --title="Resto ${tag}" --notes "${tag}"
