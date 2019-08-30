param(
    [Parameter(Mandatory=$true,
    HelpMessage="The path to a config file for a Checkmarx service that runs on the manager (e.g. Job, Scan, System managers).")]
    [string]$FilePath
)

$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format FileDateTimeUniversal

$backupFile = $FilePath + "." + $stamp

Copy-Item -Path $FilePath -Destination $backupFile -Force



$xmlDoc = New-Object System.Xml.XmlDocument
$xmlDoc.Load($backupFile)

$securityAttribute = $xmlDoc.SelectSingleNode("//bindings/basicHttpBinding/binding/security/@mode")
$securityAttribute.Value = "Transport"

$outSettings = New-Object System.Xml.XmlWriterSettings
$outSettings.Indent = $true
$outWriter = [System.Xml.XmlWriter]::Create($FilePath, $outSettings)
$xmlDoc.WriteTo($outWriter)
$outWriter.flush()
$outWriter.close()

