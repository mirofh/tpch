#!/bin/bash

export TPCH_HOME="/home/ramiro/git/tpch/" # TPC-H location
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

###########################################
# Compile DBGen and generate TPC-H queries
###########################################

cd dbgen/
make -j$(nproc --all) # compile
# generate queries
for i in {1..22};do
    ./qgen -d -a -c ${i} > ${i}.sql
    # TODO: make qgen generate queries with Linux \n
    dos2unix ${i}.sql
done
cd -

###########################################
# Generate data and run queries for every trial
###########################################

output="runtime.txt"
for trial in {1..5}; do

    cd dbgen/
    rm *.tbl # remove old tables
    ./dbgen -s $size # generate data
    cd -

    # create tables and load data
    # XXX: you must have access to a database tpch without password
    #createdb tpch
    psql -d tpch -f tables_drop.sql
    psql -d tpch -f tables_create.sql
    psql -d tpch -f tables_load.sql

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
    mkdir deterministic-${size}GB-${trial}
    mv -v *.err *.txt deterministic-${size}GB-${trial}
done
