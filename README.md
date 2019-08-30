# Checkmarx Engine Communication over SSL

These scripts assist in the configuring of the Checkmarx SAST manager and engines to communicate over SSL.  The two scripts in the root (**ConfigCxEngineSSL.ps1** and **ConfigCxManagerForEngineSSL.ps1**) of this folder are the primary entrypoint scripts.  Each script should be run on a server running the appropriate Checkmarx services.


# Engine Configuration (ConfigCxEngineSSL.ps1)

Any server running the CxEngine service should execute the **ConfigCxEngineSSL.ps1** script.  The script should use the following parameters:

Parameter: **-CxInstallRoot**

Defaults to "C:\Program Files\Checkmarx".  Provide the root of the install location of the Checkmarx services if they have not been installed at the default location.


Parameter: **-PfxPath**

The path to the .pfx file containing the server's public/private key pair.

Parameter: **-PfxPassword**

The password needed for accessing the private key in the .pfx file.

Parameter: **-CerPaths**

A comma-delimited array of paths where public keys used for signature validation of the server's certificate may be imported.  Surround each path by quotes.  Wildcards and directories are acceptable inputs.

Parameter: **-EngineServiceAccount**

Defaults to "NT AUTHORITY\NETWORK SERVICE".  If a custom domain service account is being used to execute the CxEngine service, provide the custom account in this parameter.


# Manager Configuration (ConfigCxManagerForEngineSSL.ps1)

Any server running the Checkmarx SAST management services should execute the **ConfigCxManagerForEngineSSL.ps1** script.  The script should use the following parameters:


Parameter: **-CxInstallRoot**

Defaults to "C:\Program Files\Checkmarx".  Provide the root of the install location of the Checkmarx services if they have not been installed at the default location.

Parameter: **-CerPaths**

A comma-delimited array of paths where public keys used for signature validation of the server's certificate may be imported.  Surround each path by quotes.  Wildcards and directories are acceptable inputs.

Parameter: **-EngineServiceAccount**

Defaults to "NT AUTHORITY\NETWORK SERVICE".  If a custom domain service account is being used to execute the SAST services, provide the custom account in this parameter.


# Installing on the Server
The scripts in the root of this folder along with the **support** folder are required for execution.