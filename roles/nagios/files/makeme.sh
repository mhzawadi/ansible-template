#!/bin/bash
script_dir=$(dirname $0)
cd "$script_dir"

cd nagios-$1
make all &&
make install &&
make install-init &&
make install-config &&
make install-commandmode
