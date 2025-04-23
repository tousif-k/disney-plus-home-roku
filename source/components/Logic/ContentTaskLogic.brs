' File: ContentTaskLogic.brs
' This file contains the logic for the content task in the channel.
' It handles the loading of content and the interaction with the HomePage component.

sub RunContentTask()
    m.contentTask = CreateObject("roSGNode", "MainLoaderTask")
    m.contentTask.ObserveField("content", "OnMainContentLoaded")
    m.contentTask.control = "run"
    m.loadingIndicator.visible = true
end sub

sub OnMainContentLoaded()
    m.HomePage.SetFocus(true)
    m.loadingIndicator.visible = false
    m.HomePage.content = m.contentTask.content
end sub