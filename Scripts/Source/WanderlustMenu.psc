Scriptname WanderlustMenu Extends SKI_ConfigBase
{Mod Configuration Menu entrypoint for Wanderlust mod.}

WanderlustQuestScript property MainQuest Auto

Event OnPageReset(string page)
    SetCursorFillMode(TOP_TO_BOTTOM)
    AddTextOptionST("StartWander", "Start Wandering", "")
    AddTextOptionST("StopWander", "Stop Wandering", "")
EndEvent

State StartWander
    Event OnHighlightST()
        SetInfoText("Enable AI wandering and start moving towards the closest path node.")
    EndEvent
    Event OnSelectST()
        ; Wait until the menu closes
        Utility.Wait(0.1)

        MainQuest.StartWander()
    EndEvent
EndState

State StopWander
    Event OnSelectST()
        ; Wait until the menu closes
        Utility.Wait(0.1)

        MainQuest.StopWander()
    EndEvent
EndState
