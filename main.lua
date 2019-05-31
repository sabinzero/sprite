
local Quad = love.graphics.newQuad
-- sprite = love.graphics.newImage('sprite.png')
function love.load()
    character = {}
    character.player = love.graphics.newImage ("sprite.png")
    character.x = 50
    character.y = 50
    direction = 'right'
    
    iteration = 1
    max = 8

    idle = true
    timer = 0.1

    quads = {}

    for j=1,8 do
        quads[j] = Quad((j-1)*32, 0, 32, 32, 256, 32);
       -- quads['right'][j] = Quad((j-1)*32, 0, 32, 32, 256, 32); - not needed anymore
       -- quads['left'][j] = Quad((j-1)*32, 0, 32, 32, 256, 32); - not needed anymore 
       -- flip horizontally x = true, y = false
       -- quads['left'][j]:flip(true, false) - this is now done in love.graphics.draw
    end
end


function love.update(dt)
    if idle == false then
        timer = timer + dt
        if timer > 0.2 then
            timer = 0.1
            iteration = iteration + 1
            if love.keyboard.isDown('right') then
                character.x = character.x + 5
            end
            if love.keyboard.isDown('left') then
                character.x = character.x - 5
            end
            if iteration > max then
                iteration = 1
            end
        end
    end
end


function love.keypressed(key)
    if quads[key] then
        direction = key
        idle = false
    end
end


function love.keyreleased(key)
    if quads[key] and direction == key then
        idle = true
        iteration = 1
        direction = 'right'
    end
end


function love.draw()
    --since quads cant be flipped I use a negative scale in the X axis (sx) to flip the quad
	--(direction == "right" and 1 or -1) means: if direction == "right" then 1 else -1 end, but returns that value
    love.graphics.draw(character.player, quads[iteration], character.x, character.y, 0, (direction == 'right' and 1 or -1), 1)
end