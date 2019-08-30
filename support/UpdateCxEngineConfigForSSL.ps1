param(
    [Parameter(Mandatory=$true,
    HelpMessage="The path to a config file for the Checkmarx Engine WCF config file.")]
    [string]$FilePath
)

$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format FileDateTimeUniversal

$backupFile = $FilePath + "." + $stamp

Copy-Item -Path $FilePath -Destination $backupFile -Force

$xmlDoc = New-Object System.Xml.XmlDocument
$xmlDoc.Load($backupFile)

$securityAttribute = $xmlDoc.SelectSingleNode("//bindings/basicHttpBinding/binding/security/@mode")

if ($securityAttribute -eq $null)
{
    $bindingNode = $xmlDoc.SelectSingleNode("//bindings/basicHttpBinding/binding")
    $securityElement = $xmlDoc.CreateElement("security")
    $securityElement.SetAttribute("mode","Transport")
    $bindingNode.AppendChild($securityElement)
}
else
{
    $securityAttribute.Value = "Transport"
}


$mexBindingAttribute = $xmlDoc.SelectSingleNode("//services/service/endpoint[@address='mex']/@binding")
$mexBindingAttribute.Value = "mexHttpsBinding"

$localHostName = hostname 
$baseAddressAttribute = $xmlDoc.SelectSingleNode("//services/service/host/baseAddresses/add/@baseAddress")
$baseAddressAttribute.Value = "https://" + $localHostName + ":443/CxSourceAnalyzerEngineWCF/CxEngineWebServices.svc"

$serviceMetadataNode = $xmlDoc.SelectSingleNode("//behaviors/serviceBehaviors/behavior[@name='EngineServiceBehavior']/serviceMetadata")
$serviceMetadataNode.SetAttribute("httpsGetEnabled","true")
$serviceMetadataNode.RemoveAttribute("httpGetEnabled")


$outSettings = New-Object System.Xml.XmlWriterSettings
$outSettings.Indent = $true
$outWriter = [System.Xml.XmlWriter]::Create($FilePath, $outSettings)
$xmlDoc.WriteTo($outWriter)
$outWriter.flush()
$outWriter.close()
