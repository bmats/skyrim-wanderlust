scriptname WanderlustQuestScript extends Quest
{Main logic for Wanderlust mod.}

Activator property BaseWaypoint Auto
WanderlustWaypoint[] property Route Auto
Quest property PlayerPackageQuest Auto
Message property ManualRoutingMessage Auto

float _kUpdateIntervalSec = 1.0
float _kStuckMoveDistance = 50.0

WanderlustWaypoint _lastWaypoint
WanderlustWaypoint _currentWaypoint
bool _manualRouting
float _lastPositionX = -999999.9
float _lastPositionY = -999999.9
float _lastPositionZ = -999999.9

event OnUpdate()
  if _currentWaypoint == None
    return
  endIf

  Actor player = Game.GetPlayer()
  if _SqrDistanceToLastPosition(player.GetPositionX(), player.GetPositionY(), player.GetPositionZ()) < (_kStuckMoveDistance * _kStuckMoveDistance)
    ; Player is possibly stuck
    _FixPlayer(player)
  endIf

  _lastPositionX = player.GetPositionX()
  _lastPositionY = player.GetPositionY()
  _lastPositionZ = player.GetPositionZ()

  RegisterForSingleUpdate(_kUpdateIntervalSec)
endEvent

; Called by WanderlustMenu
function StartWander()
  _currentWaypoint = _GetClosestWaypoint()

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
  Game.ShowFirstPersonGeometry(false)

  RegisterForSingleUpdate(_kUpdateIntervalSec)
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
  WanderlustWaypoint nextWaypoint
  if !_manualRouting
    nextWaypoint = _currentWaypoint.GetRandomAdjacentWaypoint(_lastWaypoint)
  else
    nextWaypoint = _ShowManualRoutingMessage()
  endIf

  _lastWaypoint = _currentWaypoint
  _currentWaypoint = nextWaypoint

  ; Enable the next waypoint and start again
  _SetWaypointEnabled(_lastWaypoint, false)
  _SetWaypointEnabled(_currentWaypoint, true)
  PlayerPackageQuest.Start()
endFunction

function DebugSetManualRouting(bool manualRouting)
  _manualRouting = manualRouting
endFunction

function _SetWaypointEnabled(WanderlustWaypoint waypoint, bool isEnabled)
  if isEnabled
    waypoint.Enable()
  else
    waypoint.Disable()
  endIf
endFunction

function _FixPlayer(Actor player)
  Debug.Notification("AI is stuck")

  ; We can't call player.ResetAI(), that crashes the game. Try resetting the AI another way
  Game.SetPlayerAIDriven(false)
  PlayerPackageQuest.Stop()
  Utility.Wait(0.1)
  PlayerPackageQuest.Start()
  Game.SetPlayerAIDriven()
  player.SetPosition(player.GetPositionX(), player.GetPositionY(), player.GetPositionZ() + 5000)
endFunction

WanderlustWaypoint function _GetClosestWaypoint()
  ObjectReference closest = Game.FindClosestReferenceOfTypeFromRef(BaseWaypoint, Game.GetPlayer(), 1000000) ; is this large enough?
  return closest as WanderlustWaypoint
endFunction

WanderlustWaypoint function _ShowManualRoutingMessage()
  string routesMessage = "Reached waypoint: " + _currentWaypoint.ToString(Route.Find(_currentWaypoint)) + "\n\nWhich waypoint shall we go to next?\n"
  int i = 0
  while i < _currentWaypoint.Adjacent.Length
    WanderlustWaypoint adjacent = _currentWaypoint.Adjacent[i]
    routesMessage += "[ " + _IntToAlphaChar(i) + " ]: " + adjacent.ToString(Route.Find(adjacent)) + "\n"
    i += 1
  endWhile

  Debug.MessageBox(routesMessage)

  int option = ManualRoutingMessage.Show()
  return _currentWaypoint.Adjacent[option]
endFunction

string function _IntToAlphaChar(int v)
  if v == 0
    return "A"
  elseIf v == 1
    return "B"
  elseIf v == 2
    return "C"
  elseIf v == 3
    return "D"
  elseIf v == 4
    return "E"
  endIf
endFunction

float function _SqrDistanceToLastPosition(float x, float y, float z)
  return (x - _lastPositionX) * (x - _lastPositionX) + (y - _lastPositionY) * (y - _lastPositionY) + (z - _lastPositionZ) * (z - _lastPositionZ)
endFunction
