param(
    [string[]]$CerPaths
)

$ErrorActionPreference = 'Stop'

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
      & "$PSScriptRoot\ImportCACert.ps1" -FilePath $filePath
    }
}
