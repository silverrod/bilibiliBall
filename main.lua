display.setStatusBar(display.HiddenStatusBar)


local physics = require( "physics" )
physics.start()

physics.setGravity( 0, 0 )

	local rcorona = require("rcorona")
	rcorona.startServer(8181)
end

local backgroundMusic = audio.loadStream("bgm.mp3")
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }  )

local life = 3

-- display size

local dWidth = display.contentWidth
local dHeight = display.contentHeight

local sWidth = dWidth
local sHeight = dWidth * 0.6
local user

	user:applyLinearImpulse( -100*event.yGravity, -100*event.xGravity, user.x, user.y )

end

-- Create a circle that moves with Accelerator events
local function reborn( event )

	user = display.newCircle(0, 0, 30)
	--user = display.newImage("angry.png")
	user.x = dWidth * 0.95
	user.y = dHeight * 0.9
	user:setFillColor( 0, 0, 255 )		-- blue
	physics.addBody( user, { density = 1.0, friction = 1.0, bounce = 0, radius = 30 } )

	user.linearDamping = 8
end


local function dead( event )
	reborn()
	Runtime:addEventListener ("accelerometer", onAccelerate);
end


	Runtime:removeEventListener ("accelerometer", onAccelerate);
	myText:setTextColor(255, 255, 0)

end

local function delay( event )

	timer.performWithDelay( 500, dead )

end


reborn()

-- Create a stage

local obstacles = {

for inex,sensor in pairs(sensors) do
	physics.addBody( sensor, "static", {isSensor = true} )
	sensor:addEventListener( "collision", delay )
end

	goal:addEventListener( "collision", clear )
Runtime:addEventListener ("accelerometer", onAccelerate);