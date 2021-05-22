Scriptname WanderlustTravelTrigger Extends ObjectReference

WanderlustQuestScript property WanderQuest Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    If akActionRef == Game.GetPlayer()
        WanderQuest.OnTravelTriggerEnter(self as ObjectReference)
    EndIf
EndEvent
