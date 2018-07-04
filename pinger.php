<?php
#echo "ok\n";
#print_r($_GET);
$dir = '/var/cache/munin/vmss';


$host = sanitize($_GET['me']);
if (strlen($host) <1) exit("incorrect hostname '$host'\n");

$subj =  sanitize($_GET['subject']);
if (strlen($subj) <1) exit("incorrect subject '$subj'\n");

$status = intval($_GET['status']);

echo "$host\t$subj\t$status\n";

if (is_dir("$dir/$subj") === false){
        if (mkdir("$dir/$subj", 0777, true) !== true) exit("cannot create $dir/$subj\n");       #create dire
}

if (file_put_contents("$dir/$subj/$host", "$host $status\n") <3 ) exit("cannot write to $dir/$subj/$host\n"); #overwrite old file
echo "OK\n";

//==================================================
function sanitize($in){
        $out = preg_replace ("/[^a-zA-Z0-9._-]/", '', $in);
        $out = preg_replace("/^[\.-_]/", '', $out);   # those elements are nit allowed in the first place
        $out = preg_replace("/[\.-_]$/", '', $out);   # those elements are nit allowed in the last place
        return $out;
}


