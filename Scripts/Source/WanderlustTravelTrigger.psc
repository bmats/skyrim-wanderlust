Scriptname WanderlustTravelTrigger Extends ObjectReference

WanderlustQuest property MainQuest Auto

Event OnTriggerEnter(ObjectReference akActionRef)
    If akActionRef == Game.GetPlayer()
        MainQuest.OnTravelTriggerEnter()
        self.Disable()
    EndIf
EndEvent
