<#
.SYNOPSIS
A script used for configuring Checkmarx Manager servers to use SSL for communications with the Checkmarx Engines.

.DESCRIPTION


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
