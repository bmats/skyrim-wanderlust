scriptname WanderlustMenu extends SKI_ConfigBase
{Mod Configuration Menu entrypoint for Wanderlust mod.}

WanderlustQuestScript property MainQuest Auto

event OnPageReset(string page)
    SetCursorFillMode(TOP_TO_BOTTOM)
    AddTextOptionST("StartWander", "Start Wandering", "")
    AddTextOptionST("StopWander", "Stop Wandering", "")
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
