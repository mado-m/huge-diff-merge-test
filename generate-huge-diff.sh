#!/bin/bash
set -e

usage() {
    echo "USAGE: `basename $0` [Options]"
    echo ""
    echo "Required:"
    echo ""
    echo "Options:"
    echo "  -h, --help          show this help."
    echo "  -c, --count         changed file count per dir."
    echo "  --dry               dry run mode."
    exit 1;
}

main() {
    script_dir=$(cd $(dirname $0); pwd)
    declare -a argv=()
    while (( $# > 0 )); do
        case $1 in
            -h|--help) usage;;
            -c|--count) count=$2; shift;;
            -*) fatal "Unkown option: $1"; usage;;
            *) argv=("${argv[@]}" "$1");;
        esac
        shift
    done
    set -- "${argv[@]}"

    # implement here. #
    body="$(cat /dev/urandom | base64 | fold -w 100 | head -n 10 )"

    for str in $(echo {a..z})
    do
      mkdir -p $str

      for num in `seq 1 ${count:-100}`
      do
        echo "$body" >> $script_dir/$str/$(printf '%03d' $num)
      done
    done
}

# call main.
main "$@"

