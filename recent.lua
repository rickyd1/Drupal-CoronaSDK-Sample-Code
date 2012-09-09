-----------------------------------------------------------------------------------------
--
-- recent.lua
-- This file Pulls the top node from a list of nodes created by a view
-- Your configuration may require different settings.
-- Richard Darling - richard@keikiapps.com www.keikiapps.com
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require "json"
local htmltotext = require "htmltotext"

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------




-- Called when the scene's view does not exist:
function scene:createScene( event )
	-- establish connection url
	url = "http://www.YOU_WEBSITE.com/SERIVCE_ENDPOINT/VIEW"
	
	local group = self.view	
	

	
	-- call data from server
	local function networkListener( event )
		if ( event.isError ) then
			print( "Network error!")
			articleTitle ="Not connected"
			articleBody = "Please check your connection it seems that something is not right."
		else
			print ( "Fuck Yeah!!" .. event.response )
			nodes = json.decode(event.response)		
			articleTitle = nodes[1].node_title 			
			articleBodyRaw = nodes[1].body
			articleBody = "you can pull the body here."
						
			articleId = nodes[1].nid
		end
		
		-- create some text
		title = display.newRetinaText( articleTitle, 0, 0, native.systemFont, 32 )
		title:setTextColor( 0 )	-- black
		title:setReferencePoint( display.CenterReferencePoint )
		title.x = display.contentWidth * 0.5
		title.y = 125	
		group:insert( title )
		
		local summary = display.newRetinaText( articleBody, 0, 0, 292, 292, native.systemFont, 16 )
		summary:setTextColor( 0 ) -- black
		summary:setReferencePoint( display.CenterReferencePoint )
		summary.x = display.contentWidth * 0.5 + 10
		summary.y = 300		
		group:insert( summary )
		
		local itemId = display.newRetinaText( "This is article " .. articleId, 0, 0, 292, 292, native.systemFont, 14 )
		itemId:setTextColor( 0 ) -- black
		itemId:setReferencePoint( display.CenterReferencePoint )
		itemId.x = display.contentWidth * 0.5 + 10
		itemId.y = display.contentHeight		
		group:insert( itemId )
	end
	network.request( url, "GET", networkListener )
	
	-- create a white background to fill screen
	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	bg:setFillColor( 255 )	-- white
	
	freedom = display.newRetinaText( "This is a teaser to the most recent article", 0, 0, native.systemFont, 10 )
	freedom:setTextColor( 0 )	-- black
	freedom:setReferencePoint( display.CenterReferencePoint )
	freedom.x = display.contentWidth * 0.5
	freedom.y = 45
	
	
	
	-- all objects must be added to group (e.g. self.view)
	group:insert( bg )
	group:insert( freedom )	
	
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- Do nothing
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
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