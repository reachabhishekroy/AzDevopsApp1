# Author: Abhishek Roy
# Created on: 21.08.2019
# Install IIS and dotnet silent

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

#Install IIS
Install-WindowsFeature -name Web-Server -IncludeAllSubFeature -IncludeManagementTools
Write-Host "Installed IIS successfully."

#Install DOTNET 4.8

$installpath= "c:\install"
cd $installpath
CMD.exe /C "ndp48-x86-x64-allos-enu.exe /q /norestart"
Write-Host "Installed DOTNET successfully."
