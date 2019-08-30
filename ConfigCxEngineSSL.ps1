<#
.SYNOPSIS
A script used for configuring Checkmarx Engine servers to use SSL for communications.

.DESCRIPTION


.PARAMETER CxInstallRoot
The path to the folder where the Checkmarx software has been installed.  Defaults to C:\Program Files\Checkmarx

.PARAMETER PfxPath
The path to a PFX file containing the server certificate and the private key.

.PARAMETER PfxPassword
The password to the private key stored in the PFX file.

.PARAMETER CerPaths
Paths to one or more CER files containing the signature validation chain for the server certificate.
Wildcards are accepted.

.PARAMETER EngineServiceAccount
The service account identity which is running the CxEngine service.  Defaults to NT AUTHORITY\NETWORK SERVICE

#>

param(
    [string]$CxInstallRoot = "C:\Program Files\Checkmarx",
    [Parameter(Mandatory=$true)]
    [string]$PfxPath,
    [Parameter(Mandatory=$true)]
    [string]$PfxPassword,
    [string[]]$CerPaths,
    [string]$EngineServiceAccount = "NT AUTHORITY\NETWORK SERVICE"
)

$ErrorActionPreference = 'Stop'

$engineWCFConfig = [System.IO.Path]::Combine($CxInstallRoot, "Checkmarx Engine Server", 
    "CxSourceAnalyzerEngine.WinService.exe.config")

& "$PSScriptRoot\support\UpdateCxEngineConfigForSSL.ps1" -FilePath $engineWCFConfig

foreach($CerPath in $CerPaths)
{
    if ([System.IO.Directory]::Exists($CerPath) )
    {
        $importFiles = [System.IO.Directory]::GetFiles($CerPath)
    }
    else
    {
        $searchSpec = [System.IO.Path]::GetFileName($CerPath)
        $searchDir = [System.IO.Path]::GetDirectoryName($CerPath)
        $importFiles = [System.IO.Directory]::GetFiles($searchDir, $searchSpec)
    }
    foreach ($filePath in $importFiles)
    {
      & "$PSScriptRoot\support\ImportCACert.ps1" -FilePath $filePath
    }
}

$certThumbprint = (& "$PSScriptRoot\support\ImportServerCert.ps1" -FilePath $PfxPath -PrivateKeyPassword $PfxPassword).Thumbprint
$netshCertGuid = "{" + [System.Guid]::NewGuid().ToString() + "}"

netsh http add sslcert ipport=0.0.0.0:443 certhash=$certThumbprint appid=$netshCertGuid
netsh http add urlacl url=https://+:443/CxSourceAnalyzerEngineWCF/CxEngineWebServices.svc user=$EngineServiceAccount

Restart-Service -Name CxScanEngine
