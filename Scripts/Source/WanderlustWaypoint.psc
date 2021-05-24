scriptname WanderlustWaypoint extends ObjectReference

WanderlustQuestScript property WanderQuest Auto
WanderlustWaypoint[] property Adjacent Auto

event OnTriggerEnter(ObjectReference akActionRef)
    if akActionRef == Game.GetPlayer()
        WanderQuest.OnWaypointTriggerEnter(self)
    endIf
endEvent
