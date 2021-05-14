#!/bin/bash

export DSS_PATH="." # Directory in which to build flat files
export DSS_CONFIG="." # Directory in which to find configuration files
export DSS_DIST="dists.dss" # Name of distribution definition file
export DSS_QUERY="postgres" # Directory in which to find query templates

# set the TPC-H Scale Factor
if test -z $1; then
    echo "./run.sh <ScaleFactor>"
    exit -1
fi
size=$1

cd dbgen/
rm *.tbl # remove old tables
make -j$(nproc --all)

# generate data
./dbgen -s $size

# generate queries
for i in {1..22};do
    ./qgen -d -a -c ${i} > ${i}.sql
    # TODO: make qgen generate queries with Linux \n
    dos2unix ${i}.sql
done
cd -

# create tables and load data
echo "SELECT 'CREATE DATABASE tpch' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'tpch')\gexec" | psql
psql -d tpch -f tables_drop.sql
psql -d tpch -f tables_create.sql
psql -d tpch -f tables_load.sql

output="runtime.txt"

for trial in {1..3}; do
    # run queries
    for i in {1..22}; do
        begin=$(date +%s%N)
        /usr/bin/time -v psql -d tpch -f dbgen/${i}.sql 2> ${i}.err 1> ${i}.txt
        end=$(date +%s%N)
        runtime=$(echo "scale=2; $end - $begin" | bc -l)
        echo $i,$begin,$end,$runtime >> ${output}
    done

    # results
    cat ${output}
    mkdir results-${size}GB-${trial}
    mv -v *.err *.txt results-${size}GB-${trial}
done
