' File: HomePageLogic.brs
' This file contains the logic for the HomePage component.
' It handles the initialization of the HomePage, content loading, and item selection.

sub ShowHomePage()
    m.HomePage = CreateObject("roSGNode", "HomePage")
    ' observe HomePage node to know when item is selected
    m.HomePage.ObserveField("rowItemSelected", "OnHomePageItemSelected")
    ShowScreen(m.HomePage)
end sub

sub OnHomePageItemSelected(event as Object)
    grid = event.GetRoSGNode()
    ' extract the row and column indexes of the item the user selected
    m.selectedIndex = event.GetData()
    rowContent = grid.content.GetChild(m.selectedIndex[0])
    ShowDetailsModal(rowContent, m.selectedIndex[1])
end sub