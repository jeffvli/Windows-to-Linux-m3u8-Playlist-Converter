$ImportDirectory = 'H:\Playlist'
$WindowsDirectory = 'H:\\Songs\\'
$SubsonicDirectory = '/data/Music/Songs/'
$Date = (Get-Date).ToString("yyyy-MM-dd")

$PlaylistFiles = (Get-ChildItem $ImportDirectory -Filter *.m3u8)
New-Item -Path "H:\Playlist\Backup\$Date" -ItemType Directory

foreach ($Playlist in $PlaylistFiles) {
    if ((Get-Content -Path $Playlist.Fullname -First 1) -ne '#EXTM3U') {  
        $PlaylistTemp = Get-Content -Path $Playlist.FullName -Encoding UTF8
        
        Set-Content -Path $Playlist.FullName -Value '#EXTM3U' -Encoding UTF8 # Add first line #EXTM3U
        Add-Content -Path $Playlist.FullName -Value $PlaylistTemp -Encoding UTF8 # Add rest of the lines
    }

    $PlaylistTemp = (Get-Content -Path $Playlist.FullName -Encoding UTF8) | ForEach-Object {
    $_ -replace $WindowsDirectory, $SubsonicDirectory `
       -replace '\\', '/'
    }

    $FileName = $Playlist.BaseName
    $PlaylistTemp | Out-File -FilePath "H:\Playlist\$FileName.m3u8" -Force -Encoding UTF8
    $PlaylistTemp | Out-File -FilePath "H:\Playlist\Backup\$Date\$Filename.m3u8" -Force -Encoding UTF8
}
