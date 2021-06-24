scriptname WanderlustQuestScript extends Quest
{Main logic for Wanderlust mod.}

Activator property BaseWaypoint Auto
WanderlustWaypoint[] property Route Auto
Quest property PlayerPackageQuest Auto
ReferenceAlias property PlayerPackageQuestHorseAlias Auto
ActorBase property HorseActor Auto
Message property ManualRoutingMessage Auto

float _kUpdateIntervalSec = 5.0
float _kPlayerFollowDistance = 1000.0
float _kStuckDistanceThreshold = 50.0

WanderlustWaypoint _lastWaypoint
WanderlustWaypoint _currentWaypoint
bool _manualRouting
Actor _horsey
float _lastFollowPosX
float _lastFollowPosY
float _lastFollowPosZ
float _lastUpdatePosX = -999999.9
float _lastUpdatePosY = -999999.9
float _lastUpdatePosZ = -999999.9

event OnUpdate()
  if _currentWaypoint == None
    return
  endIf

  ; The player actor needs to stay within range of the horse because the world loads around the player position.
  ; Otherwise, the horse will reach the end of the world.
  ; Every time the horse moves _kPlayerFollowDistance, move the player there and update the last follow position.
  Actor player = Game.GetPlayer()
  float sqrDistanceFromFollowPos = _SqrDistanceToObject(_horsey, _lastFollowPosX, _lastFollowPosY, _lastFollowPosZ)
  if sqrDistanceFromFollowPos > (_kPlayerFollowDistance * _kPlayerFollowDistance)
    player.TranslateTo(_lastFollowPosX, _lastFollowPosY, _lastFollowPosZ, 0, 0, 0, 1000)
    _lastFollowPosX = _horsey.GetPositionX()
    _lastFollowPosY = _horsey.GetPositionY()
    _lastFollowPosZ = _horsey.GetPositionZ()
  endIf

  if _SqrDistanceToObject(_horsey, _lastUpdatePosX, _lastUpdatePosY, _lastUpdatePosZ) < (_kStuckDistanceThreshold * _kStuckDistanceThreshold)
    ; Horse is stuck. Just teleport to the next waypoint to fix this
    _TeleportToNextWaypoint()
  endIf

  _lastUpdatePosX = _horsey.GetPositionX()
  _lastUpdatePosY = _horsey.GetPositionY()
  _lastUpdatePosZ = _horsey.GetPositionZ()
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

  ; Spawn a horse at our current position
  _horsey = Game.GetPlayer().PlaceAtMe(HorseActor) as Actor
  PlayerPackageQuestHorseAlias.ForceRefTo(_horsey)

  ; Use the starting position as the first follow position
  _lastFollowPosX = _horsey.GetPositionX()
  _lastFollowPosY = _horsey.GetPositionY()
  _lastFollowPosZ = _horsey.GetPositionZ()

  ; Enable AI package
  PlayerPackageQuest.Start()

  ; Disable player movement
  Game.DisablePlayerControls()

  ; Follow the horse (double function calls is a hack to make SetCameraTarget() take effect)
  Game.SetCameraTarget(_horsey)
  Game.ForceFirstPerson()
  Game.ForceThirdPerson()

  ; Don't hide geometry in debug mode
  if !_manualRouting
    Game.ShowFirstPersonGeometry(false)
    Game.GetPlayer().SetAlpha(0)
  endIf

  RegisterForUpdate(_kUpdateIntervalSec)
endFunction

function StopWander()
  UnregisterForUpdate()

  Actor player = Game.GetPlayer()
  player.SetAlpha(1)
  Game.ShowFirstPersonGeometry(true)
  Game.SetCameraTarget(player)
  Game.EnablePlayerControls()
  PlayerPackageQuest.Stop()
  PlayerPackageQuestHorseAlias.ForceRefTo(None)
  _horsey.Delete()

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

function _TeleportToNextWaypoint()
  Debug.Notification("AI is stuck, teleporting")

  _horsey.MoveTo(_currentWaypoint, 0, 0, 5000, false)
  Game.GetPlayer().MoveTo(_currentWaypoint, 0, 0, 5000, false)
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

float function _SqrDistanceToObject(ObjectReference obj, float x, float y, float z)
  float x2 = obj.GetPositionX()
  float y2 = obj.GetPositionY()
  float z2 = obj.GetPositionZ()
  return (x2 - x) * (x2 - x) + (y2 - y) * (y2 - y) + (z2 - z) * (z2 - z)
endFunction
