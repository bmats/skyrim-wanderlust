scriptname WanderlustQuestScript extends Quest
{Main logic for Wanderlust mod.}

Activator property BaseWaypoint Auto
WanderlustWaypoint[] property Route Auto
Quest property PlayerPackageQuest Auto
ReferenceAlias property PlayerPackageQuestHorseAlias Auto
ActorBase property HorseActor Auto
Message property ManualRoutingMessage Auto

float _kUpdateIntervalSec = 2.0
float _kPlayerFollowDistance = 1000.0
float _kStuckMoveDistance = 50.0

WanderlustWaypoint _lastWaypoint
WanderlustWaypoint _currentWaypoint
bool _manualRouting
Actor _horsey
float _lastHorseX
float _lastHorseY
float _lastHorseZ
float _lastPositionX = -999999.9
float _lastPositionY = -999999.9
float _lastPositionZ = -999999.9

event OnUpdate()
  if _currentWaypoint == None
    return
  endIf

  Actor player = Game.GetPlayer()

  ; Make the player follow the horse at a distance
  float sqrDistanceFromLastHorsePositionToCurrentActorPosition = _SqrDistance(_horsey.GetPositionX(), _horsey.GetPositionY(), _horsey.GetPositionZ(), _lastHorseX, _lastHorseY, _lastHorseZ)
  if sqrDistanceFromLastHorsePositionToCurrentActorPosition > (_kPlayerFollowDistance * _kPlayerFollowDistance)
    player.TranslateTo(_lastHorseX, _lastHorseY, _lastHorseZ, 0, 0, 0, 1000)

    _lastHorseX = _horsey.GetPositionX()
    _lastHorseY = _horsey.GetPositionY()
    _lastHorseZ = _horsey.GetPositionZ()
  endIf

  ; if _SqrDistanceToLastPosition(player.GetPositionX(), player.GetPositionY(), player.GetPositionZ()) < (_kStuckMoveDistance * _kStuckMoveDistance)
  ;   ; Player is possibly stuck
  ;   _FixPlayer(player)
  ; endIf

  ; _lastPositionX = player.GetPositionX()
  ; _lastPositionY = player.GetPositionY()
  ; _lastPositionZ = player.GetPositionZ()

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

  _horsey = Game.GetPlayer().PlaceAtMe(HorseActor) as Actor
  PlayerPackageQuestHorseAlias.ForceRefTo(_horsey)

  _lastHorseX = _horsey.GetPositionX()
  _lastHorseY = _horsey.GetPositionY()
  _lastHorseZ = _horsey.GetPositionZ()

  ; Enable AI player package
  PlayerPackageQuest.Start()

  ; Disable player movement
  Game.DisablePlayerControls(false, false, false, false, false, false, false)

  ; Follow the horse in first person (ForceThirdPerson() is a hack to get this to take effect)
  Game.SetCameraTarget(_horsey)
  Game.ForceFirstPerson()
  Game.ForceThirdPerson()

  if !_manualRouting
    Game.ShowFirstPersonGeometry(false)
    Game.GetPlayer().SetAlpha(0)
  endIf

  RegisterForSingleUpdate(_kUpdateIntervalSec)
endFunction

function StopWander()
  Actor player = Game.GetPlayer()
  Game.ShowFirstPersonGeometry(true)
  player.SetAlpha(1)
  Game.EnablePlayerControls()
  Game.SetCameraTarget(player)
  _horsey.Delete()
  PlayerPackageQuest.Stop()

  _lastWaypoint = None
  _currentWaypoint = None
endFunction

Actor function GetMainActor()
  return _horsey
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

float function _SqrDistance(float x1, float y1, float z1, float x2, float y2, float z2)
  return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1)
endFunction

; float function _SqrDistanceToLastPosition(float x, float y, float z)
;   return (x - _lastPositionX) * (x - _lastPositionX) + (y - _lastPositionY) * (y - _lastPositionY) + (z - _lastPositionZ) * (z - _lastPositionZ)
; endFunction
