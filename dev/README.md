# Developer Scripts

These scripts are mainly provided for developer testing purposes.

# GenerateTestSelfSignedCA.ps1
This script generates a self-signed CA ".cer" file as well as a public/private key in a ".pfx" container. This can be used when testing the scripts.

Parameter: **-Subject**

Defaults to MyRoot.  Use a FQDN hostname to use as a self-signed server cert.


# ExportCACert.ps1
Exports the public key portion of a certificate installed on the machine.

Parameter: **-CertPath**

The path to the certificate container.  See the documentation for the PowerShell command [New-SelfSignedCertificate](https://docs.microsoft.com/en-us/powershell/module/pkiclient/new-selfsignedcertificate?view=win10-ps) for examples of specifying the cert container path.


Parameter: **-CertSubjectName**

The subject name of the certificate to export.  The certificate container is searched for the cert that matches the subject name.


Parameter: **-ExportPrefix**

Defaults to "exported_cert".  This is the prefix of the file that will contain the exported cert.


# ExportServerCert.ps1

Exports the public and private key of a certificate installed on the machine.


Parameter: **-CertPath**

The path to the certificate container.  See the documentation for the PowerShell command [New-SelfSignedCertificate](https://docs.microsoft.com/en-us/powershell/module/pkiclient/new-selfsignedcertificate?view=win10-ps) for examples of specifying the cert container path.

Parameter: **-CertSubjectName**

The subject name of the certificate to export.  The certificate container is searched for the cert that matches the subject name.


Parameter: **-ExportPrefix**

Defaults to "exported_cert".  This is the prefix of the file that will contain the exported cert.

Parameter: **-PrivateKeyPassword**

The password used to encrypt the private key.  Anyone attempting to import the certificate from the PFX container will be prompted for this passord.