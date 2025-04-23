' Component: RowListItemComponent.brs

sub OnContentSet()
    content = m.top.itemContent
    if content <> invalid 
        m.top.FindNode("poster").uri = content.thumbnail
    end if
end sub