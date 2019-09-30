# Install NuGet and Powershell module for Azure
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
Install-Module -Name Az -Force -Scope CurrentUser -AllowClobber -Verbose
