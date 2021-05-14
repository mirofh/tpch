
#!/bin/bash

help () {
    echo "Usage: $0 
    -H|--hive <scale-factor>     Run Hive
    -p|--postgres <scale-factor> Run PostgreSQL
    -h                           This message
    "
    exit 1
}

options=$(getopt --long "hive:,postgres:,help" -o "H:p:h" -a -- "$@")

eval set -- "$options"

while true; do
    case "${1}" in
        -H|--hive)
            shift
            scalefactor=${1}
            cmd="./db_hive/run.sh"
            break ;;
        -p|--postgres)
            shift
            scalefactor=${1}
            cmd="./db_postgres/run.sh"
            break ;;
        *|-h)
            help
            break ;;
    esac
done
shift $((OPTIND-1))

. ${cmd} ${scalefactor}

