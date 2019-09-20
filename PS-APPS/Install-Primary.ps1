# Author: Abhishek Roy
# Created on: 21.08.2019

Param([string]$arg1)

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

#Update DB password from Azure Keyvault in XML file
$installpath= "c:\Install"
cd $installpath
$con=Get-Content Mywebapp1_Primary_NPMwNTA.xml
$con|% { $_.Replace("DBPassword",$arg1) }|Set-Content Mywebapp1_Primary_123.xml
Write-Host "Updated password from vault to argument file."

#Pause for 15 seconds
#Start-Sleep -Second 15

#Install Mywebapp1 silent
CMD.EXE /C " START `"`" /WAIT `"Mywebapp1-8.6-OfflineInstaller`" /s /ConfigFile=`"c:\install\Mywebapp1_Primary_123.xml`""
Write-Host "Installed Mywebapp1 successfully."

#Delete XML files from install directory
Remove-Item 'c:\install\*.xml' -Force
Write-Host "Deleted XML files from Mywebapp1 Primary successfully."
