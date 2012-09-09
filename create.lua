-----------------------------------------------------------------------------------------
--
-- Create.lua
-- This file allows you to create a node.
-- Your configuration may require different settings.
-- Richard Darling - richard@keikiapps.com www.keikiapps.com
--
-----------------------------------------------------------------------------------------
local widget = require("widget")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require "json"
local m_message, m_submit

local function onMessageField(e)
	if e.phase == "began" then
		m_message.text = ""
	elseif e.phase == "ended" then
		m_message.message = tostring(e.text)
		if m_message.text == "" then
			m_message.text = "Create Title"
		end
	elseif e.phase == "submitted" then
		native.setKeyboardFocus(nil)
		if m_message.text == "" then
			m_message.text = "Create Title"
		end
	end
end

local function sendDataToDrupal ( event )
	if ( event.isError) then
		print("Network Error!")
	else
		print("Response:" .. event.response)
	end
end
local function onSend(e)

	if e.phase == "release" then
		url = "http://www.YOU_WEBSITE.com/SERVICE_END_POINT/node"
		
		headers = {}

		headers["Content-Type"] = "application/json"
		headers["Accept-Language"] = "en-US"
		
		messageTransmit = m_message.text
		print(messageTransmit)
		
		articleTitle = m_message.text
		-- You can other fields here
		
		
		articleDataTable = {}		
		articleDataTable.type = "article"
		articleDataTable.title = articleTitle			
		articleData = json.encode{articleDataTable}
		
		drupalData = string.sub(articleData, 2, -2)
		
		local params = {}
		params.headers = headers
		params.body = drupalData
		
		print(params.body)
		print(params.headers)
		network.request(url, "POST",  sendDataToDrupal, params)
	end
end
-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	-- create a white background to fill screen
	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	bg:setFillColor( 255 )	-- white
	

	-- setup fields
	
	m_message = native.newTextField(20, 150, display.contentWidth-40, 28)
	m_message.text = "Enter Title"
	m_message.size = 18
	m_message:addEventListener('userInput', onMessageField)

	m_submit = widget.newButton{
		label = "Send",
		width = 60,
		height = 30,
		left = (display.contentWidth/2) - 30,
		top = (display.contentHeight) - 100,
		onEvent = onSend
	}
	
	

	
	-- all objects must be added to group (e.g. self.view)
	group:insert( bg )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- do nothing
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	display.remove( m_message )
	m_message = nil
	
	display.remove( m_submit )
	m_submit = nil
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