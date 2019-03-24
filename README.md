# Windows-to-Linux-m3u8-Playlist-Converter
Automated conversion of a batch of Windows m3u8 playlists to Linux mount subdirectories.

## How to use
The script works under the assumption that music files in are under the same root directory in both Windows and Linux instances. Run the PowerShell script in a **non-elevated** prompt and run the function `Convert-WindowsPlaylist`.

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
