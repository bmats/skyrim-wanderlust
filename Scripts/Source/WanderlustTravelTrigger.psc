Scriptname WanderlustTravelTrigger Extends ObjectReference

WanderlustQuestScript property WanderQuest Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    Debug.MessageBox(GetName() + " hit by " + akActionRef.GetName())
    If akActionRef == Game.GetPlayer()
        WanderQuest.OnTravelTriggerEnter(self as ObjectReference)
    EndIf
EndEvent
