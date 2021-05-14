#!/bin/bash

# generate data
./data.sh ${1}

# load data
for table in customer lineitem nation orders part partsupp region supplier; do
    hdfs dfs -rm -r "/tpch/${table}"
    hdfs dfs -mkdir -p "/tpch/${table}"
    hdfs dfs -copyFromLocal data_${1}/${table}.tbl /tpch/${table}/
done

output="runtime.csv"
for trial in {1..3}; do
    logdir="hive-${size}GB-${trial}"
    if ! test -d ${logdir}; then
        mkdir -p ${logdir}
    fi

    # run queries
    for i in {1..22}; do
        begin=$(date +%s%N)
        /usr/bin/time -v hive -f db_hive/queries/${i}.sql 2> ${logdir}/${i}.err 1> ${logdir}/${i}.txt
        end=$(date +%s%N)
        runtime=$(echo "scale=2; $end - $begin" | bc -l)
        echo $i,$begin,$end,$runtime >> ${logdir}/${output}
    done
done
