#!/usr/bin/env bash -e

username=$1

if ! test "$username"; then
    echo usage: $0 username
    exit 1
fi

cd $(dirname "$0")

. ../virtualenv.sh

mkdir -p work

filename=$(date +followers-%a.txt)
path=work/$filename
lastpath=work/last.txt
histfile=work/history.txt

python ./followers.py $username > $path

test -f $lastpath || cp $path $lastpath

if ! cmp $lastpath $path &>/dev/null; then
    timestamp=$(date)

    for username in $(grep -v -f $lastpath $path); do
        echo "$timestamp - new follower: $username"
    done
    for username in $(grep -v -f $path $lastpath); do
        echo "$timestamp - old follower: $username"
    done

    cp $path $lastpath
fi | tee -a $histfile
