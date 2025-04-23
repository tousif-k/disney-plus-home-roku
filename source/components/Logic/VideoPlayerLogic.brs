' File: VideoPlayerLogic.brs
' This file contains the logic for the video player component.
' It handles the video playback, state changes, and visibility changes.

sub ShowVideoScreen(content as Object, itemIndex as Integer)
    child = content.GetChild(itemIndex)
    if child.url <> ""
        m.videoPlayer = CreateObject("roSGNode", "Video")
        childrenClone = []
        childrenClone.Push(child.Clone(false))

        node = CreateObject("roSGNode", "ContentNode")
        node.Update({ children: childrenClone }, true)
        m.videoPlayer.content = node
        m.videoPlayer.contentIsPlaylist = true
        ShowScreen(m.videoPlayer)

        m.videoPlayer.control = "play"
        m.videoPlayer.ObserveField("state", "OnVideoPlayerStateChange")
        m.videoPlayer.ObserveField("visible", "OnVideoVisibleChange")
    end if
end sub

sub OnVideoPlayerStateChange()
    state = m.videoPlayer.state
    if state = "error"
        errorCode = m.videoPlayer.errorCode
        errorMsg = m.videoPlayer.errorMsg
        print "Video Player Error Code: " + errorCode.ToStr()
        print "Error Message: " + errorMsg
    end if
    ' close video screen in case of error or end of playback
    if state = "error" or state = "finished"
        CloseScreen(m.videoPlayer)
    end if
end sub

sub OnVideoVisibleChange()
   if m.videoPlayer.visible = false and m.top.visible = true
       currentIndex = m.videoPlayer.contentIndex
       m.videoPlayer.control = "stop"
       m.videoPlayer.content = invalid
       m.HomePage.SetFocus(true)
   end if
end sub