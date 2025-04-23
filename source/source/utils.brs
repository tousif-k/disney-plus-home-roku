' File: utils.brs
' This file contains utility functions for the application.

' Helper function convert AA to Node
function ContentListToSimpleNode(contentList as Object, nodeType = "ContentNode" as String) as Object
    result = CreateObject("roSGNode", nodeType) ' create node instance based on specified nodeType
    if result <> invalid
        ' go through contentList and create node instance for each item of list
        for each itemAA in contentList
            item = CreateObject("roSGNode", nodeType)
            item.SetFields(itemAA)
            result.AppendChild(item) 
        end for
    end if
    return result
end function

' this method converts milliseconds to visual format
' GetTime(138000) returns "2 hr 18 min"
function GetTime(length as Integer) as String
    secondsTotal = length / 1000 ' Convert milliseconds to seconds
    hours = secondsTotal \ 3600 ' Get the number of hours
    minutes = (secondsTotal MOD 3600) \ 60 ' Get the remaining minutes

    if minutes < 10 and hours > 0
        minutes = "0" + minutes.ToStr()
    else
        minutes = minutes.ToStr()
    end if

    ' Return hh:mm:ss if hours > 0, otherwise mm:ss
    if hours > 0
        return hours.ToStr() + " hr " + minutes + " min"
    else
        return minutes + " min"
    end if
end function

function parseDate(dateString as String) as Object
    dateComponents = dateString.Split("-")
    months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    month = months[dateComponents[1].ToInt() - 1] ' Convert month number to month name
    day = dateComponents[2].ToInt().ToStr()
    return {
        year: dateComponents[0],
        month: month,
        day: day
    }
end function

function capitalize(str as String) as String
    if str = "" then return str
    firstChar = str.Left(1)
    if firstChar = UCase(firstChar) then return str ' already capitalized
    return UCase(firstChar) + str.Mid(1)
end function