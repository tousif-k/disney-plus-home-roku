' File: HomePageLogic.brs
' This file contains the logic for the HomePage component.
' It handles the initialization of the HomePage, content loading, and item selection.

sub ShowHomePage()
    m.HomePage = CreateObject("roSGNode", "HomePage")
    m.HomePage.ObserveField("rowItemSelected", "OnHomePageItemSelected") ' observe HomePage node to know when item is selected
    ShowScreen(m.HomePage) ' show HomePage
end sub

sub OnHomePageItemSelected(event as Object) ' invoked when HomePage item is selected
    grid = event.GetRoSGNode()
    ' extract the row and column indexes of the item the user selected
    m.selectedIndex = event.GetData()
    ' the entire row from the RowList will be used by the Video node
    rowContent = grid.content.GetChild(m.selectedIndex[0])
    ShowDetailsModal(rowContent, m.selectedIndex[1]) ' show DetailsModal
end sub