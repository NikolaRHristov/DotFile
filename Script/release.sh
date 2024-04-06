#!/bin/bash

# Cargo

# VERSION="Name/v0.0.0" ; clean_dependencies ; bump_dependencies ; cargo build --release ; Maintan Workflow ; git add . ; git commit -m "$VERSION" ; git sync ; git tag -d "${VERSION}" ; git push --delete origin "${VERSION}" ; git tag -s -m "${VERSION}" -a "${VERSION}" ; git push --tags ; gh release delete "${VERSION}" -y ; gh release create "${VERSION}" --generate-notes ; cargo publish ;

# NPM

# VERSION="Name/v0.0.0" ; clean_dependencies ; bump_dependencies ; dum install ; dum prepublishOnly ; dum Document ; Maintain Workflow ; git add . ; git commit -m "${VERSION}" ; git sync ; git tag -d "${VERSION}" ; git push --delete origin "${VERSION}" ; git tag -s -m "${VERSION}" -a "${VERSION}" ; git push --tags ; gh release delete "${VERSION}" -y ; gh release create "${VERSION}" --generate-notes

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
