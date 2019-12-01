#!/bin/sh -ex

SCRIPT_DIR=$(cd $(dirname $0); pwd)

[ -z "$GOPATH" ] && exit 1

go get -d github.com/kahing/goofys
GOOFYS=$GOPATH/src/github.com/kahing/goofys
FUSE=$GOOFYS/vendor/github.com/jacobsa/fuse

cp *.patch $GOOFYS/.
cp vendor/github.com/jacobsa/fuse/*.patch $FUSE/.

cd $GOOFYS
git am *patch
cd $FUSE
git am *patch
cd $SCRIPT_DIR

ARC=`arch`
go build -ldflags "-s -w" -o /tmp/goofys.$ARC github.com/kahing/goofys


