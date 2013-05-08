display.setStatusBar(display.HiddenStatusBar)


local physics = require( "physics" )
physics.start()

physics.setGravity( 0, 0 )
if system.getInfo("environment") == "simulator" then
	local rcorona = require("rcorona")
	rcorona.startServer(8181)
end

local backgroundMusic = audio.loadStream("bgm.mp3")local se1 = audio.loadStream("se1.mp3")local se_dead = audio.loadStream("se_dead.mp3")
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 }  )

local life = 3

-- display size

local dWidth = display.contentWidth
local dHeight = display.contentHeight

local sWidth = dWidth
local sHeight = dWidth * 0.6
local userlocal function onAccelerate( event )

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


local function dead( event )	display.remove( user )	Runtime:removeEventListener ("accelerometer", onAccelerate);
	reborn()
	Runtime:addEventListener ("accelerometer", onAccelerate);	local deadChannel = audio.play( se_dead ) 
end
local function clear( event )

	Runtime:removeEventListener ("accelerometer", onAccelerate);	local myText = display.newText("congratulations", dWidth*0.2, dHeight*0.4, native.systemFont, 180)
	myText:setTextColor(255, 255, 0)	local seChannel = audio.play( se ) 

end

local function delay( event )

	timer.performWithDelay( 500, dead )

end


reborn()

-- Create a stage
local walls = {	display.newRect( 0, 0, dWidth, 10 ),	display.newRect( 0, 10, 10, dHeight-20 ),	display.newRect( dWidth-10, 10, 10, dHeight-20 ),	display.newRect( 0, dHeight-10, dWidth, 10 ) ,	display.newRect( dWidth*0.8, dHeight*0.7, 10, dHeight*0.3 ) ,	display.newRect( dWidth*0.8, dHeight*0.7, dWidth*0.1, 10 ) ,}
local obstacles = {	display.newRect( dWidth*0.9, dHeight*0.2, 10, dHeight*0.5 ) ,	display.newRect( dWidth*0.8, dHeight*0.0, 10, dHeight*0.5 ) ,	display.newRect( dWidth*0.5, dHeight*0.5, dWidth*0.3, 10 ) ,	display.newRect( dWidth*0.5, dHeight*0.5, 10, dHeight*0.3) ,	display.newRect( dWidth*0.15, dHeight*0.8, dWidth*0.35, 10 ) ,	display.newRect( dWidth*0.15, dHeight*0.5, 10, dHeight*0.3 ) ,	display.newRect( dWidth*0.15, dHeight*0.5, dWidth*0.05, 10 ) ,	display.newRect( dWidth*0.0, dHeight*0.3, dWidth*0.2, 10 ) ,	display.newRect( dWidth*0.2, dHeight*0.15, 10, dHeight*0.15 ) ,	display.newRect( dWidth*0.2, dHeight*0.15, dWidth*0.5, 10 ) ,	display.newRect( dWidth*0.7, dHeight*0.15, 10, dHeight*0.15 ) ,	display.newRect( dWidth*0.5, dHeight*0.3, dWidth*0.2, 10 ) ,}--local obstacles2 = display.newRect( dWidth*0.55, dHeight*0.75, dWidth*0.2, 10 ) local sensors = {	display.newRect( dWidth*0.9, dHeight*0.2, 10, dHeight*0.5 ) ,	display.newRect( dWidth*0.8, dHeight*0.0, 10, dHeight*0.5 ) ,	display.newRect( dWidth*0.5, dHeight*0.5, dWidth*0.3, 10 ) ,	display.newRect( dWidth*0.5, dHeight*0.5, 10, dHeight*0.3) ,	display.newRect( dWidth*0.15, dHeight*0.8, dWidth*0.35, 10 ) ,	display.newRect( dWidth*0.15, dHeight*0.5, 10, dHeight*0.3 ) ,	display.newRect( dWidth*0.15, dHeight*0.5, dWidth*0.05, 10 ) ,	display.newRect( dWidth*0.0, dHeight*0.3, dWidth*0.2, 10 ) ,	display.newRect( dWidth*0.2, dHeight*0.15, 10, dHeight*0.15 ) ,	display.newRect( dWidth*0.2, dHeight*0.15, dWidth*0.5, 10 ) ,	display.newRect( dWidth*0.7, dHeight*0.15, 10, dHeight*0.15 ) ,	display.newRect( dWidth*0.5, dHeight*0.3, dWidth*0.2, 10 ) ,	display.newRect( dWidth*0.2, dHeight*0.0, dWidth*0.8, 10 ) ,	display.newRect( dWidth*0.0, dHeight*0.3, 10, dHeight*0.7 ) ,	display.newRect( dWidth*0.0, dHeight*0.99, dWidth*0.8, 10 ) ,	display.newRect( dWidth*0.995, dHeight*0.0, 10, dHeight*0.7 ) ,}local goal = display.newRect( 0, 0, dWidth*0.2, dHeight*0.3 ) for inex,wall in pairs(walls) do	physics.addBody( wall , "static",  {  density=1, friction =  1, bounce = 0} )end
for inex,obstacle in pairs(obstacles) do	physics.addBody( obstacle , "static",  {  density=1, friction =  1, bounce = 0.2} )end--physics.addBody( obstacles2 , "static",  {  density=1, friction =  1, bounce = 0.2} )
for inex,sensor in pairs(sensors) do
	physics.addBody( sensor, "static", {isSensor = true} )	sensor:setFillColor( 255, 0, 0 )
	sensor:addEventListener( "collision", delay )
end
	physics.addBody( goal, "static", {isSensor = true} )	goal:setFillColor( 255, 255, 0 )
	goal:addEventListener( "collision", clear )
Runtime:addEventListener ("accelerometer", onAccelerate);
