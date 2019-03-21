# Windows-to-Linux-m3u8-Playlist-Converter
Automated conversion of a batch of Windows m3u8 playlists to Linux mount subdirectories.

## How to use
The script works under the assumption that music files in are under the same root directory in both Windows and Linux instances.

**Example**

Windows instance: `H:\Songs\...`

Linux instance: `/data/Music/Songs/...`

```
Convert-WindowsPlaylist -PlaylistPath 'H:\Playlist\' -OriginalPath 'H:\\Songs\\' -NewPath '/data/Music/Songs/' -BackupPath 'H:\Playlist\Backup\'
```
