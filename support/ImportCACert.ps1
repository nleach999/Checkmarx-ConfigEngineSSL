param (
[string]$CertPath="cert:\LocalMachine\Root",
[Parameter(Mandatory=$true)][string]$FilePath
)


Import-Certificate -CertStoreLocation $CertPath -FilePath $FilePath

