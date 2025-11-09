function love.load()
    shaders = require("shaders")

    sprites = {
        parrot = love.graphics.newImage("images/parrot.png"),
        background = love.graphics.newImage("images/background.png"),
    }

    player = {
        x = 400,
        y = 300,
        speed = 5,
        sprite = sprites.parrot,
        scale = 1.5
    }

    player.ox = player.sprite:getWidth() / 2
    player.oy = player.sprite:getHeight() / 2
end

function love.update(dt)
    if love.keyboard.isDown("right", "d") then
        player.x = player.x + player.speed
    end

    if love.keyboard.isDown("left", "a") then
        player.x = player.x - player.speed
    end

    if love.keyboard.isDown("down", "s") then
        player.y = player.y + player.speed
    end

    if love.keyboard.isDown("up", "w") then
        player.y = player.y - player.speed
    end

    shaders.light:send("playerPosition", {player.x, player.y})

    -- Set up multiple light sources
    local lights = {
        {player.x, player.y, 250},  -- Player light
        {100, 150, 150},             -- Static light 1
        {600, 400, 200},             -- Static light 2
    }
    
    shaders.multiLight:send("lightPositions", unpack(lights))
    shaders.multiLight:send("numLights", #lights)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(sprites.background, 0, 0)

    love.graphics.setShader(shaders.greyscale)
    love.graphics.draw(player.sprite, player.x, player.y, nil, player.scale, nil, player.ox, player.oy)
    love.graphics.setShader()

    love.graphics.setShader(shaders.multiLight)
    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.rectangle("fill", 0, 0, 1920, 1080)
    love.graphics.setShader()
end