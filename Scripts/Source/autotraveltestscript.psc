Scriptname autotraveltestscript extends ReferenceAlias  

Actor Property PlayerRef  Auto  
Quest Property autotravelquest auto
ObjectReference Property markarthtrigger auto
ObjectReference Property markarthmarker auto
ObjectReference Property dawnstartrigger auto
ObjectReference Property dawnstarmarker auto
ObjectReference Property solitudemarker  Auto  
ObjectReference Property SolitudeTrigger  Auto  
ObjectReference Property riftentrigger auto
ObjectReference Property riftenmarker auto
ObjectReference Property whiteruntrigger auto
ObjectReference Property whiterunmarker auto
ObjectReference Property morthalmarker  Auto  
ObjectReference Property morthaltrigger  Auto
ObjectReference Property windhelmtrigger auto
ObjectReference Property windhelmmarker auto
ObjectReference Property winterholdtrigger  Auto  
ObjectReference Property winterholdmarker  Auto    
Objectreference Property FalkreathMarker Auto
Objectreference Property Falkreathtrigger auto

Event OnInit()
game.DisablePlayerControls()
utility.wait(0.1)
game.EnablePlayerControls()
	RegisterForSingleUpdate(0.2)
EndEvent

Event OnUpdate()

Int iNumKeysPressed = Input.GetNumKeysPressed()
If iNumKeysPressed > 0
markarthtrigger.disable()
markarthmarker.disable()
dawnstartrigger.disable()
dawnstarmarker.disable()
solitudetrigger.disable()
SolitudeTrigger.disable()
riftentrigger.disable()
riftenmarker.disable()
whiteruntrigger.disable()
whiterunmarker.disable()
morthalmarker.disable()
morthaltrigger.disable()
windhelmtrigger.disable()
windhelmmarker.disable()
winterholdtrigger.disable()
winterholdmarker.disable()
falkreathmarker.disable()
falkreathtrigger.disable()
autotravelquest.stop()
Else
RegisterForSingleUpdate(0.2)
Endif
EndEvent





