https://www.creationkit.com/index.php?title=Quest_Alias_Tab
http://www.gamesas.com/trying-make-mcm-configeration-menu-t409508.html - MCM states

map:

autotravel locations:
DawnstarWesternMineExterior
MarkarthOriginExt
SolitudeExterior01
FalkreathExterior05
MorthalExterior01
RiftenCityNorthGateExterior
WhiterunExterior04
WhiterunExterior01
WinterholdExterior05

Parsing esm/esp files:
https://github.com/uesp/tes5lib
https://github.com/uesp/skyedit
https://en.uesp.net/wiki/Skyrim_Mod:SkyEdit/Getting_Started
https://github.com/TES5Edit/TES5Edit - TES5Dump to dump esm data
https://github.com/ThreeTen22/skyrim-plugin-decoding-project - research?
https://github.com/Ortham/esplugin/blob/master/src/subrecord.rs

test with save: 140

Todo:
- disable dragons
- x disable idle camera
- Fix thieves
- Look in direction of walking
- how to fix being stuck? go back to last moving position and repath?

# Wanderlust
Supports: Skyrim LE

## Set up

Recommended mods:
- [One With Nature](https://www.nexusmods.com/skyrim/mods/54090): change all animals to not be aggressive
- [Skyrim Unbound](https://www.nexusmods.com/skyrim/mods/71465/): disable all dragon spawn
- Disable idle camera: add this to Skyrim.ini in Documents/My Games/Skyrim
  ```
  [Camera]
  fAutoVanityModeDelay=1000000
  ```

Recommended changes to game settings:
- Disable crosshair

## Dev set up

https://github.com/joelday/papyrus-lang/wiki/Papyrus-Project
https://srmap.uesp.net/
