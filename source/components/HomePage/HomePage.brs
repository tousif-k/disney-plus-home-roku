' Component: HomePage.brs
' This component represents the home page of the channel.

sub Init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.top.ObserveField("visible", "OnVisibleChange")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.rowList.ObserveField("rowItemFocused", "OnItemFocused")
end sub

sub OnVisibleChange()
    if m.top.visible = true
        m.rowList.SetFocus(true)
    end if
end sub

sub OnItemFocused()
    focusedIndex = m.rowList.rowItemFocused
    row = m.rowList.content.GetChild(focusedIndex[0])
    item = row.GetChild(focusedIndex[1])
    if item.length > 0
        m.descriptionLabel.text = GetTime(item.length)
    else
        m.descriptionLabel.text = ""
    end if
    m.titleLabel.text = item.title + " | " + item.releaseYear.ToStr()
end sub