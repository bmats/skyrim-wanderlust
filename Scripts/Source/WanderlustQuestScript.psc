scriptname WanderlustQuestScript extends Quest
{Main logic for Wanderlust mod.}

Activator property BaseWaypoint Auto
WanderlustWaypoint[] property Route Auto
Quest property PlayerPackageQuest Auto

WanderlustWaypoint _lastWaypoint
WanderlustWaypoint _currentWaypoint
; int _currentIndex

; Called by WanderlustMenu
function StartWander()
  _currentWaypoint = _GetClosestWaypoint()
  Debug.MessageBox("Closest " + _currentWaypoint)

  ; Disable all the points except for the current
  int i = 0
  while i < Route.Length
    _SetWaypointEnabled(Route[i], Route[i] == _currentWaypoint)
    i += 1
  endWhile

  ; Enable AI player package
  PlayerPackageQuest.Start()

  ; Drive player controls using AI
  Game.SetPlayerAIDriven()
  Game.DisablePlayerControls(false, false, false, false, false, false, false)
  Game.ForceFirstPerson()
  ; Game.ShowFirstPersonGeometry(false)
endFunction

function StopWander()
  Game.SetPlayerAIDriven(false)
  Game.EnablePlayerControls()
  PlayerPackageQuest.Stop()

  _lastWaypoint = None
  _currentWaypoint = None
endFunction

function OnWaypointTriggerEnter(WanderlustWaypoint waypoint)
  if waypoint != _currentWaypoint
    return
  endIf

  Debug.Notification("Reached waypoint")

  ; Disable AI while we swap waypoints
  PlayerPackageQuest.Stop()

  ; Find the next waypoint, avoiding the last one if possible
  WanderlustWaypoint nextWaypoint = _currentWaypoint.GetRandomAdjacentWaypoint(_lastWaypoint)

  _lastWaypoint = _currentWaypoint
  _currentWaypoint = nextWaypoint

  ; Enable the next waypoint and start again
  _SetWaypointEnabled(_lastWaypoint, false)
  _SetWaypointEnabled(_currentWaypoint, true)
  PlayerPackageQuest.Start()
endFunction

function _SetWaypointEnabled(WanderlustWaypoint waypoint, bool isEnabled)
  if isEnabled
    waypoint.Enable()
  else
    waypoint.Disable()
  endIf
endFunction

WanderlustWaypoint function _GetClosestWaypoint()
  ObjectReference closest = Game.FindClosestReferenceOfTypeFromRef(BaseWaypoint, Game.GetPlayer(), 1000000) ; is this large enough?
  return closest as WanderlustWaypoint
endFunction
