' File: DetailsModalLogic.brs
' This file contains the logic for the DetailsModal component.
' It handles the display of details for a selected item and the interaction with the user.

sub ShowDetailsModal(content as Object, selectedItem as Integer)
    detailsModal = CreateObject("roSGNode", "DetailsModal")
    detailsModal.content = content
    detailsModal.jumpToItem = selectedItem
    detailsModal.ObserveField("visible", "OnDetailsModalVisibilityChanged")
    detailsModal.ObserveField("buttonSelected", "OnButtonSelected")
    ShowScreen(detailsModal)
end sub

sub OnButtonSelected(event)
    details = event.GetRoSGNode()
    content = details.content
    buttonIndex = event.getData()
    selectedItem = details.itemFocused
    if buttonIndex = 0
        ShowVideoScreen(content, selectedItem)
    end if
end sub

sub OnDetailsModalVisibilityChanged(event as Object)
    visible = event.GetData()
    detailsModal = event.GetRoSGNode()
    if visible = false
        m.HomePage.jumpToRowItem = [m.selectedIndex[0], detailsModal.itemFocused]
    end if
end sub