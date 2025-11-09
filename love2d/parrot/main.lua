function love.load()
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
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(sprites.background, 0, 0)
    love.graphics.draw(player.sprite, player.x, player.y, nil, player.scale, nil, player.ox, player.oy)
end