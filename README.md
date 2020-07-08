# rockwell-hmi-backup
 Script to automate the backing up compression, and storage of a Rockwell HMI Application.

## Example

Download [hmi-backup.ps1](hmi-backup.ps1)

Ran in powershell

```powershell
.\hmi-backup.ps1 -servername hmi-server-name.domain.com -hmi_project HMI_Proj_Name -folder \\network-server\d$\backups\
```

This will backup the HMI server named 'HMI_Proj_Name', zip the backup folder, and move it to the specified folder.
Tested on Rockwell FTView SE v10.

You can create a schedule task to backup your application automatically at a specified frequency.