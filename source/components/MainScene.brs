' Component: MainScene.brs
' The main scene of the channel

sub Init()
    m.top.backgroundColor = "0x021526"
    m.top.backgroundUri= ""
    m.loadingIndicator = m.top.FindNode("loadingIndicator")
    InitScreenStack()
    ShowHomePage()
    RunContentTask()
end sub

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        if key = "back"
            numberOfScreens = m.screenStack.Count()
            ' close top screen if there are two or more screens in the screen stack
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true
            end if
        end if
    end if
    return result
end function
