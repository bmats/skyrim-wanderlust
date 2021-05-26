scriptname WanderlustWaypoint extends ObjectReference

WanderlustQuestScript property WanderQuest Auto
WanderlustWaypoint[] property Adjacent Auto

event OnTriggerEnter(ObjectReference akActionRef)
  if akActionRef == Game.GetPlayer()
    WanderQuest.OnWaypointTriggerEnter(self)
  endIf
endEvent

WanderlustWaypoint function GetRandomAdjacentWaypoint(WanderlustWaypoint avoidIfPossible = None)
  if Adjacent.Length == 0
    return None
  elseIf Adjacent.Length == 1
    return Adjacent[0]
  endIf

  ; Get the index of the waypoint to avoid
  int indexToAvoid = Adjacent.Find(avoidIfPossible)

  if indexToAvoid < 0
    ; Return any random adjacent waypoint
    int randomIndex = Utility.RandomInt(0, Adjacent.Length - 1)
    return Adjacent[randomIndex]
  endIf

  ; We need to avoid an index
  int randomIndex = Utility.RandomInt(0, Adjacent.Length - 2) ; leave one out

  ; Return a random adjacent waypoint, skipping over the index to avoid
  if randomIndex < indexToAvoid
    return Adjacent[randomIndex]
  else
    return Adjacent[randomIndex + 1]
  endIf
endFunction

string function ToString(int waypointIndex)
  return waypointIndex + " " + self
endFunction
