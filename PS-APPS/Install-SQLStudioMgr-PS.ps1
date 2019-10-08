#Install studio manager on windows machine in silent/quiet mode
#Copy exe from Microsoft to target machine

# Set file and folder path for SSMS installer .exe
$folderpath="c:\install"
$filepath="$folderpath\SSMS-Setup-ENU.exe"

# start the SSMS installer
write-host "Beginning SSMS 2019 install..." -nonewline
$Parms = " /Install /Quiet /Norestart /Logs log.txt"
$Prms = $Parms.Split(" ")
& "$filepath" $Prms | Out-Null
Write-Host "SSMS installation complete" -ForegroundColor Green
