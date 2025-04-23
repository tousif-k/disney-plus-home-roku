' Component: MainLoaderTask.brs
' This component is responsible for loading the main content of the channel.
' It fetches data from the Disney+ API and processes it to create a content node.
' It also handles the extraction of refIds and item details from the JSON response.

sub Init()
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    ' request the content feed from the Disney+ API
    request = CreateObject("roUrlTransfer")
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.SetUrl("https://cd-static.bamgrid.com/dp-117731241344/home.json")
    response = request.GetToString()
    rootChildren = []

    json = ParseJson(response)
    if json <> invalid
        refIds = ExtractRefIds(json)
        for each refId in refIds
            row = {}
            row.title = refIds[refId]
            row.children = []
            items = GetItems(refId)
            for each item in items
                row.children.push(item)
            end for
            rootChildren.Push(row)
        end for
        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        m.top.content = contentNode
    end if
end sub

function ExtractRefIds(json as Object) as Object
    refIds = {}
    
    if json <> invalid and json.data <> invalid and json.data.StandardCollection <> invalid
        containers = json.data.StandardCollection.containers
        if containers <> invalid
            for each container in containers
                if container <> invalid and container.set <> invalid and container.set.refId <> invalid
                    refIds[container.set.refId] = container.set.text.title.full.set.default.content
                end if
            end for
        end if
    end if
    
    return refIds
end function

function GetItems(refId as Object) as Object
    request = CreateObject("roUrlTransfer")
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.SetUrl("https://cd-static.bamgrid.com/dp-117731241344/sets/" + refId + ".json")
    response = request.GetToString()
    data = ParseJson(response)

    if data <> invalid and data.data <> invalid
        ' this for loop is to get the items object and work around the different json structure
        for each key in data.data
            if type(data.data[key]) = "roAssociativeArray" and data.data[key].items <> invalid
                items = ProcessItems(data.data[key].items)
                return items
            end if
        end for
    end if

    ?"Error: Invalid JSON or missing data"
    return invalid
end function

function ProcessItems(items as Object) as Object
    content = []
    for each item in items
        title = GetTitle(item.text.title.full)
        thumbnail = GetThumbnailUrl(item.image.tile)
        mediaType = item.type
        releaseDate = item.releases[0].releaseDate
        releaseYear = item.releases[0].releaseYear
        rating = item.ratings[0].value
        ratingDescription = item.ratings[0].description
        ' conditional check for runtimeMillis as only movies will have this field
        if item.mediaMetadata <> invalid and item.mediaMetadata.runtimeMillis <> invalid
            length = item.mediaMetadata.runtimeMillis
        else
            length = 0
        end if
        ' conditional check for preview clip as not all items will have this field
        if item.videoArt[0] <> invalid and item.videoArt[0].mediaMetadata <> invalid and item.videoArt[0].mediaMetadata.urls <> invalid
            url = item.videoArt[0].mediaMetadata.urls[0].url
        else
            url = ""
        end if

        content.push({
            title: title,
            thumbnail: thumbnail,
            mediaType: mediaType,
            releaseDate: releaseDate,
            releaseYear: releaseYear,
            rating: rating,
            ratingDescription: ratingDescription,
            length: length
            url: url
        })
    end for
    return content
end function

function GetTitle(title as Object) as String
    if title <> invalid
        for each key in title
            if type(title[key]) = "roAssociativeArray" and title[key].default.content <> invalid
                return title[key].default.content
            end if
        end for
    end if
    return ""
end function

function GetThumbnailUrl(imageData as Object) as String
    if imageData <> invalid and imageData["1.78"] <> invalid
        for each key in imageData["1.78"]
            if type(imageData["1.78"][key]) = "roAssociativeArray" and imageData["1.78"][key].default.url <> invalid
                return imageData["1.78"][key].default.url
            end if
        end for
    end if
    return ""
end function
