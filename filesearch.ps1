﻿Set-StrictMode -Version latest
$path = "C:\"
$files = Get-Childitem $path -Include *.docx,*.doc -Recurse | Where-Object { !($_.psiscontainer) }
$application = New-Object -comobject word.application
$application.visible = $False
$findtext = "word"
$count = 0
"Location:"| Add-Content -path "wordFindings.csv"

Function getStringMatch
{
    # Loop through all *.doc files in the $path directory
    Foreach ($file In $files)
    {
        $document = $application.documents.open($file.fullname,$false,$true)
        $range = $document.content
        $wordFound = $range.find.execute($findText)
        $count++
        if($wordFound) 
        { 
            $file.fullname | Add-Content -path "wordFindings.csv"
        }
	Write-Output $count
	Write-Output $file.fullname
	$document.close()
    }
    $application.quit()
}

getStringMatch
