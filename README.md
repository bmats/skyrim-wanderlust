https://www.creationkit.com/index.php?title=Quest_Alias_Tab
http://www.gamesas.com/trying-make-mcm-configeration-menu-t409508.html - MCM states

Parsing esm/esp files:
https://github.com/uesp/tes5lib
https://github.com/uesp/skyedit
https://en.uesp.net/wiki/Skyrim_Mod:SkyEdit/Getting_Started
https://github.com/TES5Edit/TES5Edit - TES5Dump to dump esm data
https://github.com/ThreeTen22/skyrim-plugin-decoding-project - research?
https://github.com/Ortham/esplugin/blob/master/src/subrecord.rs

Todo:
- increase FOV
- fix horses blocking the way
- [05/25/2021 - 11:29:49PM] Error: Property Adjacent on script WanderlustWaypoint attached to  (0B006E88) cannot be initialized because the value is the incorrect type
- Fix thieves
- Look in direction of walking

# Wanderlust
Supports: Skyrim LE

## Set up

Recommended mods:
- [One With Nature](https://www.nexusmods.com/skyrim/mods/54090): change all animals to not be aggressive
- [Skyrim Unbound](https://www.nexusmods.com/skyrim/mods/71465/): disable all dragon spawn

Recommended Skyrim.ini changes (in Documents/My Games/Skyrim):
```
[General]
bAlwaysActive=1
[Camera]
fAutoVanityModeDelay=1000000
```

Recommended changes to game settings:
- Disable crosshair

## Dev set up

https://github.com/joelday/papyrus-lang/wiki/Papyrus-Project
https://srmap.uesp.net/
