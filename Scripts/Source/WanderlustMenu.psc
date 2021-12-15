scriptname WanderlustMenu extends SKI_ConfigBase
{Mod Configuration Menu entrypoint for Wanderlust mod.}

WanderlustQuestScript property MainQuest Auto

bool _manualRouting = false

int _manualRoutingOptionId

event OnPageReset(string page)
  SetCursorFillMode(TOP_TO_BOTTOM)
  AddTextOptionST("StartWander", "Start Wandering", "")
  AddTextOptionST("StopWander", "Stop Wandering", "")

  SetCursorPosition(1)

  AddHeaderOption("Debug")
  _manualRoutingOptionId = AddToggleOption("Manual waypoint routing", _manualRouting)

  AddTextOption("Next waypoint: " + MainQuest.GetCurrentWaypoint(), "", OPTION_FLAG_DISABLED)
  AddTextOption("Previous waypoint: " + MainQuest.GetLastWaypoint(), "", OPTION_FLAG_DISABLED)
endEvent

event OnOptionSelect(int optionId)
	{Called when the user selects a non-dialog option}

	if (optionId == _manualRoutingOptionId)
		_manualRouting = !_manualRouting
    MainQuest.DebugSetManualRouting(_manualRouting)
		SetToggleOptionValue(_manualRoutingOptionId, _manualRouting)
	endIf
endEvent

state StartWander
  event OnHighlightST()
    SetInfoText("Walk to the closest waypoint and then start wandering.")
  endEvent

  event OnSelectST()
    ; Wait until the menu closes
    Utility.Wait(0.1)

    MainQuest.StartWander()
  endEvent
endState

state StopWander
  event OnHighlightST()
    SetInfoText("Stop wandering and enable player controls.")
  endEvent

  event OnSelectST()
    ; Wait until the menu closes
    Utility.Wait(0.1)

    MainQuest.StopWander()
  endEvent
endState
