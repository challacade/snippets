function love.load()
    sprites = {
        parrot = love.graphics.newImage("images/parrot.png"),
        background = love.graphics.newImage("images/background.png"),
    }

    player = {
        x = 500,
        y = 300,
        speed = 5,
        sprite = sprites.parrot,
        scale = 1.0
    }
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(sprites.background, 0, 0)

    local ox = player.sprite:getWidth() / 2
    local oy = player.sprite:getHeight() / 2
    love.graphics.draw(player.sprite, player.x, player.y, nil, player.scale, nil, ox, oy)
end