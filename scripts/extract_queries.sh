#!/usr/bin/env bash

for f in Worksheet.*.json; do
    sql=${f/.*.json/.sql}
    echo $sql
    jq -r '.Query' $f > $sql
done
