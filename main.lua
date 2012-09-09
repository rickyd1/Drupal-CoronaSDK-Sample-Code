-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local storyboard = require "storyboard"

storyboard.isDebug = true
storyboard.purgeOnSceneChange = true

-- event listeners for tab buttons:
local function onFirstView( event )
	storyboard.gotoScene( "listAll" )
end

local function onSecondView( event )
	storyboard.gotoScene( "recent" )
end
local function onThirdView( event )
	storyboard.gotoScene( "create" )
end


-- create a tabBar widget with two buttons at the bottom of the screen

-- table to setup buttons
local tabButtons = {
	
	{ label="All", up="icon1.png", down="icon1-down.png", width = 32, height = 32, onPress=onFirstView, selected=true},	
	{ label="Recent", up="icon2.png", down="icon2-down.png", width = 32, height = 32, onPress=onSecondView },
	{ label="Create", up="icon2.png", down="icon2-down.png", width = 32, height = 32, onPress=onThirdView }
}

-- create the actual tabBar widget
local tabBar = widget.newTabBar{
	top = display.contentHeight - 50,	-- 50 is default height for tabBar widget
	buttons = tabButtons
}

onFirstView()	-- invoke first tab button's onPress event manually