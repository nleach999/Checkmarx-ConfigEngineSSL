param(
    [Parameter(Mandatory=$true)][string]$CertPath,
    [Parameter(Mandatory=$true)][string]$CertSubjectName,
    [string]$ExportPrefix="exported_cert"
)


$cert = Get-ChildItem -Path $CertPath -recurse | 
where-object {$_.Subject -like ("CN=" + $CertSubjectName)}

Write-Host ("Exporting public key for certificate with thumbprint " + $cert.Thumbprint)

Export-Certificate -Type CERT -FilePath ($ExportPrefix + "_CA.cer") -Cert ($CertPath + "\\" + $cert.Thumbprint)
