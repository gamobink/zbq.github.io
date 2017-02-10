#/bin/bash

if [ x"$1" = x ]; then
    echo "Usage: find-missing-so.sh <lib/bin file>"
    exit 1
fi

find_missing() {
    LIB=$1
    #if find missing, print lib name
    ldd $LIB | grep " => not found" | awk '{print $1}'
    #recursively test other libs
    ldd $LIB | grep -v " => not found" | awk 'NF==4 {print $3}' | while read -r file; do
        find_missing $file
    done
}

find_missing $1 | uniq

