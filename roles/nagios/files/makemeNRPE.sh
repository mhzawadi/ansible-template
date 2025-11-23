#!/bin/bash
script_dir=$(dirname $0)
cd "$script_dir"

cd nrpe-$1
make all && make install-plugin
