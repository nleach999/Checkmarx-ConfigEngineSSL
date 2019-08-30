param(
    [string]$Subject = "MyRoot"
)


Set-Variable certRoot "cert:\\CurrentUser"
Set-Variable certPath ($certRoot + "\\My")

$cert = New-SelfSignedCertificate -DnsName $Subject  -FriendlyName "A Test Self-Signed Cert" `
-KeyExportPolicy Exportable -KeyFriendlyName "A Test Self-Signed Cert private key" -KeyLength 2048 `
-KeyProtection None -CertStoreLocation $certPath -KeyUsage None

Write-Host "Created certificate with Thumbprint" $cert.Thumbprint

& "$PSScriptRoot\ExportCACert.ps1" -CertPath $CertPath -CertSubjectName $Subject
& "$PSScriptRoot\ExportServerCert.ps1" -CertPath $CertPath -CertSubjectName $Subject -PrivateKeyPassword "test"

Get-ChildItem ($certPath + "\\" + $cert.Thumbprint) | Remove-Item
Get-ChildItem ($certRoot + "\\CA\\" + $cert.Thumbprint) | Remove-Item
