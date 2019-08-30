param (
[string]$CertPath="cert:\LocalMachine\My",
[Parameter(Mandatory=$true)][string]$FilePath,
[Parameter(Mandatory=$true)][string]$PrivateKeyPassword
)


$securePrivateKeyPassword = ConvertTo-SecureString -String $PrivateKeyPassword -AsPlainText -Force

Import-PfxCertificate -CertStoreLocation $CertPath -FilePath $FilePath -Password $securePrivateKeyPassword

