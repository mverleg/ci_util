#!/usr/bin/env -S bash -eEu -o pipefail

if [ $# -ne 2 ]; then
    panic-in "$0" 'expects 2 args: namespace to delete, and name of cronjob that spawned this'
fi

ns="$1"

echo "Deleting namespace $ns"
kubectl delete namespace "$1"

cron="$2"

echo "Removing the cronjob that spawned this ($2)"
kubectl delete cronjob "$2"

