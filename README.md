# Foobar2000-to-Subsonic-Playlist-conversion
Connvert Windows m3u8 playlist to alternative Linux mount subdirectories. 

## Usage
The music files in subdirectories must be under the same root directory in both Windows and Linux instances.

Windows instance: `H:\Songs\...`

Linux instance: `/data/Songs/...`

**Example**
```
Convert-WindowsPlaylist -PlaylistPath 'H:\Playlist\' -OriginalPath 'H:\\Songs\\' -NewPath '/data/Music/Songs/' -BackupPath 'H:\Playlist\Backup\'
```
