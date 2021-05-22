Scriptname autotravelscript extends Objectreference


quest property autotravelquest auto
ObjectReference Property XMarker  Auto

Event OnTriggerEnter(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer()
autotravelquest.stop()
XMarker.disable()
self.disable()
EndIf
EndEvent



