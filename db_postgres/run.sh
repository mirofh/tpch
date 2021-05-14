#!/bin/bash

# generate data
./data.sh ${1}

# create tables and load data
dropdb tpch
createdb tpch
psql -d tpch -f db_postgres/tables_drop.sql
psql -d tpch -f db_postgres/tables_create.sql
psql -d tpch -v "datapath=${PWD}/data_${1}/" -f db_postgres/tables_load.sql

# run 
output="runtime.csv"
for trial in {1..3}; do
    logdir="postgres-${size}GB-${trial}" 
    if ! test -d ${logdir}; then
        mkdir -p ${logdir}
    fi

    # run queries
    for i in {1..22}; do
        echo -ne "running db_postgres/queries/${i}.sql ... " 
        begin=$(date +%s%N)
        /usr/bin/time -v psql -d tpch -f db_postgres/queries/${i}.sql 2> ${logdir}/${i}.err 1> ${logdir}/${i}.txt
        end=$(date +%s%N)
        runtime=$(echo "scale=2; $end - $begin" | bc -l)
        echo "$runtime"
        echo $i,$begin,$end,$runtime >> ${logdir}/${output}
    done
done
