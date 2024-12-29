#!/usr/bin/env -S bash -eEu -o pipefail

if [ $# -ne 2 ]; then
    echo "$0: expects 2 args: namespace to delete, and name of cronjob that spawned this" 1>&2
    exit 1
fi

ns="$1"

echo "Deleting namespace $ns"
kubectl delete namespace "$1"

cron="$2"

echo "Removing the cronjob that spawned this ($2)"
kubectl delete cronjob "$2"

