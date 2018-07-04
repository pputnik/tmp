#!/bin/bash

cd /var/cache/munin/vmss;
errs=$(ls | while read subj; do cnt=$(grep " 0" $subj -r); echo $cnt; done);

if [ "x$errs" = "x" ] ; then
        # no errors
        exit 0
fi
date '+%Y-%m-%d %H:%M:%S'
echo The following errors found:
echo $errs


