Scriptname WanderlustQuestScript Extends Quest
{Main logic for Wanderlust mod.}

WanderlustTravelTrigger[] Property Route Auto
Quest Property PlayerPackageQuest Auto

int _currentIndex = -1


; Event OnUpdate()
;   If Input.GetNumKeysPressed() > 0
;     StopWander()
;   Else
;     RegisterForSingleUpdate(0.2)
;   Endif
; EndEvent


; Called by WanderlustMenu
Function StartWander()
  _currentIndex = 0

  ; Disable all the points except for the current
  int i = 0
  while i < Route.Length
    _SetWaypointEnabled(i, i == _currentIndex)
    i += 1
  endWhile

  ; Enable AI player package
  PlayerPackageQuest.Start()

  ; Enable AI
  Game.SetPlayerAIDriven()
  Game.DisablePlayerControls(false, false, false, false, false, false, false)
EndFunction

Function StopWander()
  Game.SetPlayerAIDriven(false)
  Game.EnablePlayerControls()
  PlayerPackageQuest.Stop()

  _currentIndex = -1
EndFunction

Function OnTravelTriggerEnter(ObjectReference travelTrigger)
  if _currentIndex < 0 || travelTrigger != Route[_currentIndex]
    return
  endIf

  PlayerPackageQuest.Stop()
  _SetWaypointEnabled(_currentIndex, false)

  ; Increment index and loop
  _currentIndex += 1
  if _currentIndex >= Route.Length
    _currentIndex = 0
  endIf

  ; Enable the next point and start again
  _SetWaypointEnabled(_currentIndex, true)
  PlayerPackageQuest.Start()

  Game.SetPlayerAIDriven()
  Game.DisablePlayerControls(false, false, false, false, false, false, false)
EndFunction

Function _SetWaypointEnabled(int index, bool isEnabled)
  if isEnabled
    Route[index].Enable()
  else
    Route[index].Disable()
  endIf
EndFunction
