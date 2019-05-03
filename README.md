# Windows-to-Linux-m3u8-Playlist-Converter
Automated conversion of a batch of Windows m3u8 playlists to work on Linux subdirectories.
![demo](https://github.com/jeffvli/Windows-to-Linux-m3u8-Playlist-Converter/blob/master/convert-demo.gif?raw=true)

## How to use
The script works under the assumption that music files are under the same root directory in both Windows and Linux instances. Open PowerShell in a **non-elevated** prompt and run the function `Convert-WindowsPlaylist`.

**Recommended**: Pass your command at the end of the script and save. Convert the .ps1 to an EXE using a [PS2EXE converter](https://gallery.technet.microsoft.com/scriptcenter/PS2EXE-GUI-Convert-e7cb69d5).

### Example

Windows instance: `H:\Songs\...` (You will need to use `H:\\Songs\\`)

Linux instance: `/data/Music/Songs/...`

```
Convert-WindowsPlaylist -PlaylistPath 'H:\Playlist\' -MusicPath 'H:\\Songs\\' -NewMusicPath '/data/Music/Songs/' -BackupPath 'H:\Playlist\Backup\ -Verbose'
```

## To do
- [x] Convert m3u8 playlists
- [x] Allow backup playlist directory
- [ ] Add error checking
- [ ] Detect when new playlists have been added to directory and automatically run conversion
