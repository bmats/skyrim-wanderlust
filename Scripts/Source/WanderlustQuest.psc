Scriptname WanderlustQuest Extends Quest
{Main logic for Wanderlust mod.}

; int _kPointCount = 2

; int _currentIndex


; Event OnUpdate()
;   If Input.GetNumKeysPressed() > 0
;     StopWander()
;   Else
;     RegisterForSingleUpdate(0.2)
;   Endif
; EndEvent


; Called by WanderlustMenu
Function StartWander()
  ; Wait until the menu closes
  Debug.MessageBox("start wander")
  ; Utility.Wait(0.1)
  ; Debug.MessageBox("start wander 22")
  ; _currentIndex = 0

  ; Debug.MessageBox("start wander 2")
  ; ; Disable all the points except for the current
  ; int i = 0
  ; while i < _kPointCount
  ; Debug.MessageBox("start wander 25,")
  ;   _SetPointEnabled(i, i == _currentIndex)
  ;   i += 1
  ; endWhile
  ; Debug.MessageBox("start wander 3")

  ; Enable AI player package
  ; Start()

  ; Enable AI
  ; Game.SetPlayerAIDriven()
  ; Game.DisablePlayerControls(false, false, false, false, false, false, false)
EndFunction

; Function StopWander()
;   Game.SetPlayerAIDriven(false)
;   Game.EnablePlayerControls()
;   Stop()
; EndFunction

; Function OnTravelTriggerEnter()
;   Debug.MessageBox("Next trigger")
;   Stop()
;   _SetPointEnabled(_currentIndex, false)

;   ; Increment index and loop
;   _currentIndex += 1
;   if _currentIndex >= _kPointCount
;     _currentIndex = 0
;   endIf

;   ; Enable the next point and go again
;   _SetPointEnabled(_currentIndex, true)
;   Start()
; EndFunction

; Function _SetPointEnabled(int index, bool isEnabled)
;   Debug.MessageBox("Setting point " + index + " to " + isEnabled)
;   if isEnabled
;     _GetPointAtIndex(index).Enable()
;   else
;     _GetPointAtIndex(index).Disable()
;   endIf
; EndFunction

; ObjectReference Function _GetPointAtIndex(int index)
;   ; Point refs start at index 1 - index 0 is always the player
;   return (GetNthAlias(index + 1) as ReferenceAlias).GetReference()
; EndFunction
