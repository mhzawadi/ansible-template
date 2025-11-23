#!/bin/bash
script_dir=$(dirname $0)
cd "$script_dir"

cd nagios-plugins-$1
make && make install
