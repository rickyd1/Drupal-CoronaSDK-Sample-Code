-----------------------------------------------------------------------------------------
--
-- List All.lua
-- This file was created as an example for connecting your app to Drupal and pulling a list from a view
-- Your configuration may require different settings.
-- Richard Darling - richard@keikiapps.com www.keikiapps.com
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require "json"
-- use htmltotext to remove HTML from fields
local htmltotext = require "htmltotext"
local widget = require "widget"

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------
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


-- Called when the scene's view does not exist:
function scene:createScene( event )	
	local group = self.view

	-- create a white background to fill screen
	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight-49 )
	bg:setFillColor( 255 )	-- white

	-- all objects must be added to group (e.g. self.view)
	group:insert( bg )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	-- Load Table info
	listOptions = {	  
		top = display.statusBarHeight, 
		height = 360,
	}
	list = widget.newTableView( listOptions )
	
	-- establish connection url
	url = "http://www.YOU_WEBSITE.com/JSON_ENDPOINT/VIEW_PATH"

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

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	display.remove( list )
	list = nil
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	display.remove( list )
	list = nil
	-- INSERT code here (e.g. remove listeners, remove widgets, save state variables, etc.)
	
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene