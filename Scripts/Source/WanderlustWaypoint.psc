Scriptname WanderlustWaypoint Extends ObjectReference

WanderlustQuestScript property WanderQuest Auto
WanderlustWaypoint[] property Adjacent Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    If akActionRef == Game.GetPlayer()
        WanderQuest.OnWaypointTriggerEnter(self)
    EndIf
EndEvent
