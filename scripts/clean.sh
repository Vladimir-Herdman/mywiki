#!/usr/bin/env bash
#Clean up everything from this library setup, back to the git clone pretty
#much. Get rid of build artifacts and anything in between.

SCRIPTPATH="$(dirname "$0")"

main() {
    cd "$SCRIPTPATH/../" || return 1

    rm -rf libs/*
    mkdir -p libs

    return 0
}

main
