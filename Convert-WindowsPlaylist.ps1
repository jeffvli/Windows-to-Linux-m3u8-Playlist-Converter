function Convert-WindowsPlaylist {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$PlaylistPath,

        [Parameter(Mandatory=$true, Position=1)]
        [string]$MusicPath,

        [Parameter(Mandatory=$true, Position=2)]
        [string]$NewMusicPath,

        [Parameter(Mandatory=$false, Position=3)]
        [string]$BackupPath
    )

    BEGIN {
        $Date = (Get-Date).ToString("yyyy-MM-dd")
        $PlaylistFiles = (Get-ChildItem $PlaylistPath -Filter *.m3u8)
    }

    PROCESS {
        foreach ($Playlist in $PlaylistFiles) {
            $PlaylistTemp = Get-Content -Path $Playlist.FullName -Encoding UTF8
            if ((Get-Content -Path $Playlist.Fullname -First 1) -ne '#EXTM3U') {       
                Set-Content -Path $Playlist.FullName -Value '#EXTM3U' -Encoding UTF8 # Add first line #EXTM3U
            }

            Add-Content -Path $Playlist.FullName -Value $PlaylistTemp -Encoding UTF8 # Add rest of the lines
            $PlaylistTemp = (Get-Content -Path $Playlist.FullName -Encoding UTF8) | ForEach-Object {
                $_ -replace $MusicPath, $NewMusicPath `
                   -replace '\\', '/'
            }

            $FileNameTemp = $Playlist.Name
            $FileName = Join-Path -Path $PlaylistPath -ChildPath $FileNameTemp
            $PlaylistTemp | Out-File -FilePath $FileName -Force -Encoding UTF8
            Write-Verbose "Wrote file $FileNameTemp to $PlaylistPath"
        }

        if ($BackupPath) {
            $BackupFolder = Join-Path -Path $BackupPath -ChildPath $Date
            if (!(Test-Path $BackupFolder)) {
                New-Item -Path $BackupFolder -ItemType Directory -ErrorAction SilentlyContinue
            }

            foreach ($Playlist in $PlaylistFiles) {
                Copy-Item -Path $Playlist.FullName -Destination $BackupFolder -Force
                Write-Verbose "Copying $Playlist to $BackupFolder"
            }
        }
    }
}
