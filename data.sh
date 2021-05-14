#!/bin/bash

export DSS_PATH="." # Directory in which to build flat files
export DSS_CONFIG="." # Directory in which to find configuration files
export DSS_DIST="dists.dss" # Name of distribution definition file
export DSS_QUERY="postgres" # Directory in which to find query templates

if test -z $1; then
    echo "./data.sh <scale-factor>"
    exit -1
fi
size=$1
data_dir="data_${size}"

if test -d ${data_dir}; then
    exit 0
fi

cd dbgen/
make -j$(nproc --all)
./dbgen -f -s $size
cd -
mkdir -p ${data_dir}
mv dbgen/*.tbl "${data_dir}/"
