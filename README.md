# net-rmxp
Online multiplayer support for RPG Maker XP using Ruby-based server

## Prerequisite
- Latest stable version of Ruby
- RPG Maker XP

## Client

### Usage
Extract `client/Data/Scripts.rxdata` to `client/Scripts/`
```bash
rake extract_script
```
Compress `client/Scripts/` to `client/Data/Scripts.rxdata`
```bash
rake compress_script
```

### info.txt
1. filename
2. "Script title" -> "filename"
example
```txt
Scene_Gameover
Scene_Debug
"" -> "Untitled_89"
Main
```

## Server
[README.md](server/README.md)