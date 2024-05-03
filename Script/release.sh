#!/bin/bash

# NPM
# VERSION="x" ; clean_dependencies ; bump_dependencies ; dum install ; dum prepublishOnly ; dum Document ; git add . ; git commit -m $VERSION ; git sync ; git tag -d "v${VERSION}" ; git push --delete origin "v${VERSION}" ; git tag -s -m "v${VERSION}" -a "v${VERSION}" ; git push --tags ; gh release delete "v${VERSION}" -y ; gh release create "v${VERSION}" --generate-notes

# Cargo
# VERSION="x" ; clean_dependencies ; bump_dependencies ; cargo build --release ; git add . ; git commit -m $VERSION ; git sync ; git tag -d "v${VERSION}" ; git push --delete origin "v${VERSION}" ; git tag -s -m "v${VERSION}" -a "v${VERSION}" ; git push --tags ; gh release delete "v${VERSION}" -y ; gh release create "v${VERSION}" --generate-notes ; cargo publish ;

VERSION="x"
clean_dependencies
bump_dependencies
dum install
dum prepublishOnly
dum Document
git add .
git commit -m $VERSION
git sync
git tag -d "v${VERSION}"
git push --delete origin "v${VERSION}"
git tag -s -m "v${VERSION}" -a "v${VERSION}"
git push --tags
gh release delete "v${VERSION}" -y
gh release create "v${VERSION}" --generate-notes
