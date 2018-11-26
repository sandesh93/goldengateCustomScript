##Note: If change in field location (RBA) in original config file will not give desired output.
##Script developed in 26th November-2018
#### Purpose of the script: Get the RBA count from config file and everytime check if RBA count is changing . if yes , calculate the difference by which it got changed. 
#### further it should compare it with updated value.

$BASE_DIR="D:\\goldengateCustomScript"
###Original File path from where data to be extracted.
$ORIGINAL_FILE="D:\\goldengateCustomScript\\goldengate.txt"
 
###### Old data will be moved to below file for new comparision.
$TEMP_FILE="D:\\goldengateCustomScript\\comparefile.txt"

#Extract required field value and post it into tempfile if temp file is empty.

##Check if tmp file exists if not then create.

if (!(Test-Path $TEMP_FILE))
{
   New-Item -path $BASE_DIR -name comparefile.txt -type "file" -value ""
   Write-Host "temp file not present hence created."

}

## CHeck if File is empty . if yes then write content from Original file for comparision
If ((Get-Content $tempfile ) -eq $Null) {
    ((Get-Content $ORIGINAL_FILE)[15].Trim()).Split(" ")[3] | out-file -FilePath $TEMP_FILE
    write-host "File was blank. Resetting Difference value to Zero."
    $diference = 0
    
  }

$compare=((Get-Content $ORIGINAL_FILE)[15].Trim()).Split(" ")[3]
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
((Get-Content $ORIGINAL_FILE)[15].Trim()).Split(" ")[3] | out-file -FilePath $TEMP_FILE
echo "----------------------"

}

exit

