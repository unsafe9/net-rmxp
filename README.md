# net-rmxp
Online multiplayer support for RPG Maker XP using Ruby-based server

## Client

### Usage
Extract `client/Data/Scripts.rxdata` to `client/Scripts/`
```bash
ruby tools/rxscript.rb extract
```
Compress `client/Scripts/` to `client/Data/Scripts.rxdata`
```bash
ruby tools/rxscript.rb compress
```

### info.txt
1. filename
2. "Script title" -> "filename"
