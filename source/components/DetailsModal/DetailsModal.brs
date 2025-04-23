' Component: DetailsModal.brs
' This component represents the DetailsModal screen that displays details of a selected item.

 function Init()
    m.top.ObserveField("visible", "OnVisibleChange")
    m.top.ObserveField("itemFocused", "OnItemFocusedChanged")

    m.buttons = m.top.FindNode("buttons")
    m.poster = m.top.FindNode("poster") 
    m.rating = m.top.FindNode("ratingLabel")
    m.ratingDesc = m.top.FindNode("ratingDescLabel")
    m.timeLabel = m.top.FindNode("timeLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.releaseLabel = m.top.FindNode("releaseLabel")
    
    buttonContent = CreateObject("roSGNode", "ContentNode")
    item = CreateObject("roSGNode", "ContentNode")
    item.SetFields({title : "Watch Preview"})
    buttonContent.AppendChild(item)
    m.buttons.content = buttonContent
end function

sub OnVisibleChange()
    if m.top.visible = true
        m.buttons.SetFocus(true)
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub SetDetailsContent(content as Object)
    m.rating.text = "Rating: " + content.rating
    if content.ratingDescription <> invalid
        m.ratingDesc.text = Capitalize(content.ratingDescription)
    else
        m.ratingDesc.text = ""
    end if
    m.top.FindNode("posterDetails").uri = content.thumbnail
    m.titleLabel.text = content.title
    if content.releaseDate <> invalid and content.releaseDate <> ""
        date = ParseDate(content.releaseDate)
        m.releaseLabel.text = "Released: "
        m.releaseLabel.text = m.releaseLabel.text + date.month + " " + date.day + ", " + date.year
    else
        m.releaseLabel.text = ""
    end if
    if content.mediaType = "DmcSeries"
        m.timeLabel.text = ""
    else
        m.timeLabel.text = GetTime(content.length)
    end if
    if content.url <> ""
        m.buttons.visible = true
    else
        m.buttons.visible = false
    end if
end sub

sub OnJumpToItem()
    content = m.top.content
    if content <> invalid and m.top.jumpToItem >= 0 and content.GetChildCount() > m.top.jumpToItem
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub OnItemFocusedChanged(event as Object)
    focusedItem = event.GetData()
    content = m.top.content.GetChild(focusedItem)
    SetDetailsContent(content)
end sub

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        currentItem = m.top.itemFocused
        if key = "left"
            m.top.jumpToItem = currentItem - 1 
            result = true
        else if key = "right"
            m.top.jumpToItem = currentItem + 1 
            result = true
        end if
    end if
    return result
end function