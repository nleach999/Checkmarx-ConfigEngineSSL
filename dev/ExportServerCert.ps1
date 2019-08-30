param(
    [Parameter(Mandatory=$true)][string]$CertPath,
    [Parameter(Mandatory=$true)][string]$CertSubjectName,
    [string]$ExportPrefix="exported_cert",
    [Parameter(Mandatory=$true)][string]$PrivateKeyPassword
)


$securePrivateKeyPassword = ConvertTo-SecureString -String $PrivateKeyPassword -AsPlainText -Force

$cert = Get-ChildItem -Path $CertPath -recurse | 
where-object {$_.Subject -like ("CN=" + $CertSubjectName)}

Write-Host ("Exporting public/private key for certificate with thumbprint " + $cert.Thumbprint)

Export-PfxCertificate -Cert ($CertPath + "\\" + $cert.Thumbprint) -FilePath ($ExportPrefix + "_server.pfx") `
-Password $securePrivateKeyPassword

