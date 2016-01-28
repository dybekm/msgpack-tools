#!/bin/bash
# Requires md2man-roff: https://github.com/sunaku/md2man
# or install golang-blackfriday-dev
MD2MAN=`which md2man`
if [ -x "$MD2MAN" ] ; then
    echo "Using md2man-roff"
    cd "`dirname $0`/.."
    md2man-roff docs/json2msgpack.md > docs/json2msgpack.1 || exit $?
    md2man-roff docs/msgpack2json.md > docs/msgpack2json.1 || exit $?
elif [ -f /usr/share/gocode/src/github.com/cpuguy83/go-md2man/md2man.go ] ; then
    echo "Using md2man.go"
    cd "`dirname $0`/.."
    go run /usr/share/gocode/src/github.com/cpuguy83/go-md2man/md2man.go --in docs/json2msgpack.md --out docs/json2msgpack.1 || exit $?
    go run /usr/share/gocode/src/github.com/cpuguy83/go-md2man/md2man.go --in docs/msgpack2json.md --out docs/msgpack2json.1 || exit $?
else
    echo "Neither md2man-roff nor md2man.go are available"
    exit 1
fi
