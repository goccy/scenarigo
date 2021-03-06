#!/bin/sh

set -eu

BASEDIR=`dirname $0`/..

if [ "$(git symbolic-ref --short HEAD)" != "master" ]; then
    echo "branch is not master"
    exit 1
fi

git diff --quiet || (echo "diff exists"; exit 1)

VERSION=$(gobump show -r ${BASEDIR}/version)
echo "current version: ${VERSION}"
read -p "input next version: " NEXT_VERSION
gobump set ${NEXT_VERSION} -w ${BASEDIR}/version

git-chglog --next-tag v${NEXT_VERSION} -o ${BASEDIR}/CHANGELOG.md

git commit -am "release v${NEXT_VERSION}"
git tag v${NEXT_VERSION}
git push && git push --tags
