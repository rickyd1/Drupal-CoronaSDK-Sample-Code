local mime = require "mime"
local json = require "json"
local widget = require "widget"

listOptions = {	
    data=data,      
	top = display.statusBarHeight, 
	height = 360,
}
list = widget.newTableView( listOptions )
-- onEvent listener for the tableView
local function onRowTouch( event )
        local row = event.target
        local rowGroup = event.view

        if event.phase == "press" then
        	rowGroup.alpha = 0.5

        elseif event.phase == "release" then
			rowGroup.alpha = 1
        end
end

-- onRender listener for the tableView
local function onRowRender( event )
        local row = event.target
        local rowGroup = event.view

        local text = display.newRetinaText( title, 12, 0, "Helvetica-Bold", 18 )
        text:setReferencePoint( display.CenterLeftReferencePoint )
        text.y = row.height * 0.5
        text.x = 15
        text:setTextColor( 0 )
      

        -- must insert everything into event.view:
        rowGroup:insert( text )
end

DataSet = {}
function DataSet:new(url)			
	local function networkListener( event )
		if ( event.isError ) then
			print( "Network error!")
		else
			print ( "Fuck Yeah!!" .. event.response )
			dataSet = json.decode(event.response)
			
			for i=1, #dataSet do
				local rowHeight, rowColor, lineColor
						       
		        title = dataSet[i].node_title
			
				print(title)
		
				list:insertRow{
	                onRender=onRowRender,
	                height=rowHeight,
	                isCategory=isCategory,
	                rowColor=rowColor,
	                lineColor=lineColor
				}
			end
		
				
		end
	end
	network.request( url, "GET", networkListener )
end