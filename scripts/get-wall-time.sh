#!/bin/bash

logdir=$1

for query in {1..22};do
    for meta in $(grep Elapsed ${logdir}/${query}.err | cut -d ':' -f5- | sed 's/ //g') ;do
        min=$(echo $meta | cut -d ":" -f1)
        sec=$(echo $meta | cut -d ":" -f2)
        echo  $(echo "scale=2; ($min * 60) + $sec" | bc -l)
    done
done
