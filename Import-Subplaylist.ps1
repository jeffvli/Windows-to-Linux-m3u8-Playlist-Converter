function Import-SubsonicPlaylist {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$PlaylistPath,

        [Parameter(Mandatory=$true, Position=1)]
        [string]$OriginalPath,

        [Parameter(Mandatory=$true, Position=2)]
        [string]$SubsonicPath,

        [Parameter(Mandatory=$false, Position=3)]
        [string]$BackupPath
    )

    begin {
        $Date = (Get-Date).ToString("yyyy-MM-dd")
        $PlaylistFiles = (Get-ChildItem $PlaylistPath -Filter *.m3u8)
    }

    process {
        foreach ($Playlist in $PlaylistFiles) {
            if ((Get-Content -Path $Playlist.Fullname -First 1) -ne '#EXTM3U') {  
                $PlaylistTemp = Get-Content -Path $Playlist.FullName -Encoding UTF8
                Set-Content -Path $Playlist.FullName -Value '#EXTM3U' -Encoding UTF8 # Add first line #EXTM3U
                Add-Content -Path $Playlist.FullName -Value $PlaylistTemp -Encoding UTF8 # Add rest of the lines
            }

            $PlaylistTemp = (Get-Content -Path $Playlist.FullName -Encoding UTF8) | ForEach-Object {
            $_ -replace $OriginalPath, $SubsonicPath `
            -replace '\\', '/'
            }

            $FileNameTemp = $Playlist.Name
            $FileName = Join-Path -Path $PlaylistPath -ChildPath $FileNameTemp
            $PlaylistTemp | Out-File -FilePath $FileName -Force -Encoding UTF8
            if ($BackupPath) {
                if (!(Join-Path -Path $BackupPath -ChildPath $Date)) {
                    New-Item -Path (Join-Path -Path $BackupPath -ChildPath $Date) -ItemType Directory -ErrorAction SilentlyContinue
                }
                $PlaylistTemp | Out-File -FilePath "H:\Playlist\Backup\$Date\$FileNameTemp.m3u8" -Force -Encoding UTF8
            }
            
        }
    }
}

# EXAMPLE
# Import-SubsonicPlaylist -PlaylistPath 'H:\Playlist\' -OriginalPath 'H:\\Songs\\' -SubsonicPath '/data/Music/Songs/'