##Note: If change in field location in original file this script will not genrate desired output.
##Script developed in 26th November-2018 

###Original File path from where data to be extracted.
$File="D:\\temp\\OriginalFile.txt"
 
###### Old data will be moved to below file for new comparision.
$tempfile="D:\\temp\\comparefile.txt"

#Extract required field value and post it into tempfile if temp file is empty.

If ((Get-Content $tempfile ) -eq $Null) {
    (Get-Content $File)[3].Split(" ")[5] | out-file -FilePath $tempfile
    write-host "File was blank... Resetting Difference value to Zero."
    $diference = 0
    exit
  }

$compare=(Get-Content $File)[3].Split(" ")[5]
write-host "Latest Value= " $compare 
$oldvalue=(Get-Content $tempfile)
write-host "Old Value in File= " $oldvalue 

if ($compare -eq $oldvalue)
{

echo "----------------------"
write-host "Values are Same"
$diference= $compare - $oldvalue
write-host "Difference in values:" ($compare - $oldvalue)
echo "----------------------"

}
else
{

echo "----------------------"
write-host "Values Changed."
$diference= $compare - $oldvalue
write-host "Difference in values:" ($compare - $oldvalue)
write-host "Updated to temp file for next comparision."
(Get-Content $File)[3].Split(" ")[5] | out-file -FilePath $tempfile
echo "----------------------"

}

exit

