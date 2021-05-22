Scriptname WanderlustQuestScript Extends Quest
{Main logic for Wanderlust mod.}

WanderlustTravelTrigger[] Property Route Auto

bool _isWandering
int _currentIndex


; Event OnUpdate()
;   If Input.GetNumKeysPressed() > 0
;     StopWander()
;   Else
;     RegisterForSingleUpdate(0.2)
;   Endif
; EndEvent


; Called by WanderlustMenu
Function StartWander()
  _isWandering = true
  _currentIndex = 0

  ; Disable all the points except for the current
  int i = 0
  while i < Route.Length
    _SetPointEnabled(i, i == _currentIndex)
    i += 1
  endWhile

  ; Enable AI player package
  Start()

  ; Enable AI
  Game.SetPlayerAIDriven()
  Game.DisablePlayerControls(false, false, false, false, false, false, false)
EndFunction

Function StopWander()
  Game.SetPlayerAIDriven(false)
  Game.EnablePlayerControls()
  Stop()

  _isWandering = false;
EndFunction

Function OnTravelTriggerEnter(ObjectReference travelTrigger)
  Debug.MessageBox("OnTravelTriggerEnter")
  if !_isWandering
    return
  endIf
  Debug.MessageBox("next trigger" + travelTrigger + "/" + _GetPointAtIndex(_currentIndex))
  if !_isWandering || travelTrigger != _GetPointAtIndex(_currentIndex)
    return
  endIf

  Debug.MessageBox("hi22")
  Stop()
  Debug.MessageBox("hi")
  _SetPointEnabled(_currentIndex, false)

  ; Increment index and loop
  _currentIndex += 1
  if _currentIndex >= Route.Length
    _currentIndex = 0
  endIf

  Utility.Wait(0.5)

  ; Enable the next point and go again
  _SetPointEnabled(_currentIndex, true)
  Start()

  Game.SetPlayerAIDriven()
  Game.DisablePlayerControls(false, false, false, false, false, false, false)
EndFunction

Function _SetPointEnabled(int index, bool isEnabled)
  Debug.MessageBox("Setting point " + _GetPointAtIndex(index) + " to " + isEnabled)
  if isEnabled
    _GetPointAtIndex(index).Enable()
  else
    _GetPointAtIndex(index).Disable()
  endIf
EndFunction

ObjectReference Function _GetPointAtIndex(int index)
  ; Point refs start at index 1 - index 0 is always the player
  ; Debug.MessageBox("Get alias2 " + (GetAlias(index + 1) as ReferenceAlias).GetName())
  Debug.MessageBox("Get alias11 " + Route[index])
  ; Debug.MessageBox("Get alias3 " + ((GetAlias(index + 1) as Alias) as ReferenceAlias).GetReference())
  ; return (GetAlias(index + 1) as ReferenceAlias).GetReference()
  return Route[index]
EndFunction
