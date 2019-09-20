# Author: Abhishek Roy
# Created on: 21.08.2019
# Install MSI app in windows

#Create new folder
$installpath= "c:\install"
New-Item -Path $installpath -ItemType directory
Write-Host "Created folder successfully."

#Set Permission
$Acl = Get-Acl $installpath
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("everyone", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl $installpath $Acl
Write-Host "Added permission successfully."

#Copy files from download folder to Install folder
Copy-Item "C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\1.9.5\Downloads\0\*" -Destination "C:\install" -Recurse -Force -Verbose
Write-Host "Copied all binaries successfully."

#Create new folder
$installpathCB= "c:\install\CB"
New-Item -Path $installpathCB -ItemType directory
Write-Host "Created folder successfully."

#Set Permission
$Acl = Get-Acl $installpathCB
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("everyone", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl $installpathCB $Acl
Write-Host "Added permission successfully."

Expand-Archive -Path "c:\install\<SomeMSI>.zip" -DestinationPath $installpathCB -Force
Write-Host "Extracted binaries from zip file successfully."

# Sleep for 1 minutes until other installations are finished
[System.Threading.Thread]::Sleep(1 * 60 * 1000)

#Install Carbon Black
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression -Command $installpathCB + 'c:\install\CB\<someappsetup>.msi ADDLOCAL=All ALLUSERS=1 REBOOT=ReallySuppress /qb /l*v "c:\install\appdeploy.log"'

$msifile="c:\install\CB\<someappsetup>.msi"
$logfile="c:\install\appdeploy.log"
Start-Process -FilePath "$env:systemroot\system32\msiexec.exe" -ArgumentList "/i `"$msifile`" /qn /passive ADDLOCAL=All ALLUSERS=1 REBOOT=ReallySuppress /qb /l*v `"$logfile`"  " -Wait -NoNewWindow
Write-Host "Installed New MSI App successfully."
