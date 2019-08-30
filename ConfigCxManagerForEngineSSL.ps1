<#
.SYNOPSIS
A script used for configuring Checkmarx Manager servers to use SSL for communications with the Checkmarx Engines.

.DESCRIPTION
This script is run on Checkmarx manager servers to configure the communication with all engine instances to
use SSL.  This script assumes the engines have been configured to accept SSL communication. This script also 
assumes that the engine URI has already been entered into the engine manager screen on the Checkmarx web client.

.PARAMETER CxInstallRoot
The path to the folder where the Checkmarx software has been installed.  Defaults to C:\Program Files\Checkmarx

.PARAMETER CerPaths
Paths to one or more CER files containing the signature validation chain for the server certificate.
Wildcards are accepted.

.PARAMETER EngineServiceAccount
The service account identity which is running the CxEngine service.  Defaults to NT AUTHORITY\NETWORK SERVICE

#>

param(
    [string]$CxInstallRoot = "C:\Program Files\Checkmarx",
    [string[]]$CerPaths,
    [string]$EngineServiceAccount = "NT AUTHORITY\NETWORK SERVICE"
)

$ErrorActionPreference = 'Stop'
& "$PSScriptRoot\support\BulkImportCACerts.ps1" -CerPaths $CerPaths


$jobsManagerCfg = [System.IO.Path]::Combine($CxInstallRoot, "Checkmarx Jobs Manager", "bin", "CxJobsManagerWinService.exe.config")
$scansManagerCfg = [System.IO.Path]::Combine($CxInstallRoot, "Checkmarx Scan Manager", "bin", "CxScansManagerWinService.exe.config")
$systemManagerCfg = [System.IO.Path]::Combine($CxInstallRoot, "Checkmarx System Manager", "bin", "CxSystemManagerService.exe.config")

& "$PSScriptRoot\support\UpdateCxManagerToUseEngineOverSSL.ps1" -FilePath $jobsManagerCfg
& "$PSScriptRoot\support\UpdateCxManagerToUseEngineOverSSL.ps1" -FilePath $scansManagerCfg
& "$PSScriptRoot\support\UpdateCxManagerToUseEngineOverSSL.ps1" -FilePath $systemManagerCfg

Restart-Service -Name CxJobsManager
Restart-Service -Name CxScansManager
Restart-Service -Name CxSystemManager
