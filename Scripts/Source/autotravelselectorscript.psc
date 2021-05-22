Scriptname autotravelselectorscript extends ObjectReference  

Quest property autotravelquest auto
Message property choosemessage auto

ObjectReference Property DawnstarTriggerbox  Auto  
ObjectReference Property Dawnstarxmarker  Auto  
ObjectReference Property MarkarthTriggerbox  Auto  
ObjectReference Property Markarthxmarker  Auto  
ObjectReference Property SolitudeTriggerbox  Auto  
ObjectReference Property Solitudexmarker  Auto  
ObjectReference Property MorthalTriggerBox  Auto  
ObjectReference Property MorthalXmarker  Auto  
ObjectReference Property RiftenTriggerbox  Auto  
ObjectReference Property RiftenXMarker  Auto  
ObjectReference Property WhiterunTriggerbox  Auto  
ObjectReference Property WhiterunXmarker  Auto  
ObjectReference Property WindhelmTriggerbox  Auto  
ObjectReference Property WindhelmXmarker  Auto  
ObjectReference Property WinterholdTriggerbox  Auto  
ObjectReference Property WinterholdXmarker  Auto  
ObjectReference Property FalkreathTriggerbox  Auto  
ObjectReference Property FalkreathXmarker  Auto  

Event OnRead()
autotravelquest.stop()
MarkarthTriggerbox.disable()
Markarthxmarker.disable()
DawnstarTriggerbox.disable()
Dawnstarxmarker.disable()
SolitudeTriggerbox.disable()
Solitudexmarker.disable()
RiftenTriggerbox.disable()
RiftenXMarker.disable()
WhiterunTriggerbox.disable()
WhiterunXmarker.disable()
MorthalTriggerBox.disable()
MorthalXmarker.disable()
WindhelmTriggerbox.disable()
WindhelmXmarker.disable()
WinterholdTriggerbox.disable()
WinterholdXmarker.disable()
FalkreathTriggerbox.disable()
FalkreathXmarker.disable()
utility.WaitMenuMode(1.5)
Int iButton = choosemessage.Show()

If iButton == 0 
DawnstarTriggerbox.enable()
Dawnstarxmarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 1 ; Falkreath
FalkreathXmarker.enable()
FalkreathTriggerbox.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 2
MarkarthTriggerbox.enable()
Markarthxmarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 3
MorthalTriggerBox.enable()
MorthalXmarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 4
RiftenTriggerbox.enable()
RiftenXMarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 5
SolitudeTriggerbox.enable()
Solitudexmarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 6
WhiterunTriggerbox.enable()
WhiterunXmarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 7
WindhelmTriggerbox.enable()
WindhelmXmarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 8
WinterholdTriggerbox.enable()
WinterholdXmarker.enable()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
autotravelquest.start()

ElseIf iButton == 9
; do nothing muahaha
EndIf


EndEvent

