param($folder, $servername, $hmi_project)

Write-Host $folder
Write-Host $servername
Write-Host $hmi_project

$date_string = Get-Date -Format "yyyyMMddHHmmss"
$filename = "$folder$hmi_project-$date_string.zip"

$hmi_backup_cfg = "[HMIServerParameters]

HMIServerName=C:\Users\Public\Documents\RSView Enterprise\SE\HMI projects\$hmi_project\$hmi_project.sed

DestinationPath=C:\34pWZ82fLVxQWP2qwj

ShowOverwriteWarning=N

ExcludeDatalog=Y"

If (-not (Invoke-Command -ComputerName $servername -ScriptBlock {Test-Path C:\34pWZ82fLVxQWP2qwj})){
    Invoke-Command -ComputerName $servername -ScriptBlock {New-Item -ItemType Directory -Path C:\34pWZ82fLVxQWP2qwj}
}

Invoke-Command -ComputerName $servername -ScriptBlock {$($args[0]) | Out-File C:\34pWZ82fLVxQWP2qwj\HMIBackup.cfg} -ArgumentList $hmi_backup_cfg
Invoke-Command -ComputerName $servername -ScriptBlock {& "C:\Program Files (x86)\Rockwell Software\RSView Enterprise\HMIBackupRestore.exe" /b C:\34pWZ82fLVxQWP2qwj\HMIBackup.cfg}
Write-Host "Compressing..."
Invoke-Command -ComputerName $servername -ScriptBlock {Compress-Archive -Path "C:\34pWZ82fLVxQWP2qwj\$($args[0])" -DestinationPath "C:\34pWZ82fLVxQWP2qwj\$($args[0]).zip"} -ArgumentList $hmi_project
Copy-Item -Path "\\$servername\c$\34pWZ82fLVxQWP2qwj\$hmi_project.zip" -Destination $filename
Invoke-Command -ComputerName $servername -ScriptBlock {Remove-Item -Path "C:\34pWZ82fLVxQWP2qwj\" –Recurse -Force}
