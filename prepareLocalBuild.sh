#!/bin/bash

#   Prepare sources directory
if [ -d "./src" ]; then
    # Clear directory before downloading current version
    rm ./src/* -r
else
    # Create new directory for smartVISU sources.
    mkdir ./src
fi

#   Download current smartVISU master branch (latest stable)
curl -L https://github.com/Martin-Gleiss/smartvisu/tarball/master | tar -xz --strip-components=1 -C ./src
