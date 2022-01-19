## Copyright 2020-2022 Josh Grancell. All rights reserved.
## Use of this source code is governed by an MIT License
## that can be found in the LICENSE file.
TEST?=$$(go list ./... | grep -v vendor)
WORKDIR=$$(pwd)
BINARY=$$(pwd | xargs basename)
VERSION=$$(grep version main.go | head -n1 | cut -d\" -f2)
GOBIN=${GOPATH}/bin

default: build

build:
	sassc scss/app.scss css/app.css --style compressed
	cp *.html deploy/src/
	cp keybase.txt deploy/src/
	cp css/*.css deploy/src/css/
	cp img/* deploy/src/img/
