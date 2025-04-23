' File: VideoPlayerLogic.brs
' This file contains the logic for the video player component.
' It handles the video playback, state changes, and visibility changes.

sub ShowVideoScreen(content as Object, itemIndex as Integer)
    m.videoPlayer = CreateObject("roSGNode", "Video")
    child = content.GetChild(itemIndex)
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
end sub

sub OnVideoPlayerStateChange()
   state = m.videoPlayer.state
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
       m.HomePage.jumpToRowItem = [m.selectedIndex[0], currentIndex + m.selectedIndex[1]]
   end if
end sub