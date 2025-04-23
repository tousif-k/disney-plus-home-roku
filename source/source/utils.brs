' File: utils.brs
' This file contains utility functions for the channel.

' this method converts milliseconds to visual format
' GetTime(138000) returns "2 hr 18 min"
function GetTime(length as Integer) as String
    secondsTotal = length / 1000 ' Convert milliseconds to seconds
    hours = secondsTotal \ 3600
    minutes = (secondsTotal MOD 3600) \ 60

    if minutes < 10 and hours > 0
        minutes = "0" + minutes.ToStr()
    else
        minutes = minutes.ToStr()
    end if

    if hours > 0
        return hours.ToStr() + " hr " + minutes + " min"
    else
        return minutes + " min"
    end if
end function

function ParseDate(dateString as String) as Object
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

function Capitalize(str as String) as String
    if str = "" then return str
    firstChar = str.Left(1)
    if firstChar = UCase(firstChar) then return str
    return UCase(firstChar) + str.Mid(1)
end function