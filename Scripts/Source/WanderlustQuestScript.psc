scriptname WanderlustQuestScript extends Quest
{Main logic for Wanderlust mod.}

Activator property BaseWaypoint Auto
WanderlustWaypoint[] property Route Auto
Quest property PlayerPackageQuest Auto

int _currentIndex = -1

; Called by WanderlustMenu
function StartWander()
  _currentIndex = _GetClosestIndex()

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
  Game.ForceFirstPerson()
endFunction

function StopWander()
  Game.SetPlayerAIDriven(false)
  Game.EnablePlayerControls()
  PlayerPackageQuest.Stop()

  _currentIndex = -1
endFunction

function OnWaypointTriggerEnter(WanderlustWaypoint waypoint)
  if _currentIndex < 0 || waypoint != Route[_currentIndex]
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
endFunction

function _SetWaypointEnabled(int index, bool isEnabled)
  if isEnabled
    Route[index].Enable()
  else
    Route[index].Disable()
  endIf
endFunction

int function _GetClosestIndex()
  ObjectReference closestWaypoint = Game.FindClosestReferenceOfTypeFromRef(BaseWaypoint, Game.GetPlayer(), 1000000)

  int index = Route.Find(closestWaypoint as WanderlustWaypoint)
  if index < 0
    return 0
  endIf
  return index
endFunction
