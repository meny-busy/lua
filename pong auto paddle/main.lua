--import push
Class = require 'class'
push = require 'push' 

require 'Ball'
require 'Paddle'
require 'Paddle_auto'

--window sttings
WINDOW_WIDTH = 960
WINDOW_HEIGHT = 540

--sttings for the objects
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200


--veribles of the program  
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('pong')

    math.randomseed(os.time())
    small_font = love.graphics.newFont('font.ttf', 8)
    score_font = love.graphics.newFont('font.ttf', 32)
    victory_font = love.graphics.newFont('font.ttf', 24)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('paddle.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('wall.wav', 'static'),
        ['score_hit'] = love.audio.newSource('score.wav', 'static')
    }

    player1score = 0
    player2score = 0
   
    servingplayer = math.random(2) == 1 and 1 or 2

    winning_player = 0

    player1y = 30
    player2y = VIRTUAL_HEIGHT - 50

    paddle1 = Paddle(5, 20, 5 , 20)
    paddle2 = Paddle_auto(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT - 30, 5, 20)
    ball = Ball(VIRTUAL_WIDTH /2 -2,VIRTUAL_HEIGHT / 2 -2, 5, 5)
    
    if servingplayer == 1 then
        ball.dx = 100
    else
        ball.dx = -100
    end

    game_state = 'start'

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end
function love.resize(w, h)
    push:resize(w, h)
end
function love.update(dt)
    if game_state == 'play' then
        if ball.x < 0 then
            player2score = player2score + 1
            servingplayer = 1
            ball:reset()
            ball.dx = 100
            if player2score >= 3 then
                game_state = 'victory'
                winning_player = 2
            else
                game_state = 'serve'
            end
            sounds['score_hit']:play()
        end
        if ball.x > VIRTUAL_WIDTH - 4 then
            player1score = player1score + 1
            servingplayer = 2
            ball:reset()
            ball.dx = -100
            if player1score >= 3 then
                game_state = 'victory'
                winning_player = 1
            else
                game_state = 'serve'
            end
            sounds['score_hit']:play()
        end
        
        if ball:collides(paddle1) then
            ball.dx = - ball.dx * 1.05
            ball.x = paddle1.x + 5

            sounds['paddle_hit']:play()
        end
        if ball:collides(paddle2) then
            ball.dx = -ball.dx * 1.05
            sounds['paddle_hit']:play()
        end
        if ball.y <=0 then
            ball.dy = -ball.dy
            ball.y = 0
            sounds['wall_hit']:play()
        end
        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.dy = -ball.dy
            ball.y = VIRTUAL_HEIGHT - 4
            sounds['wall_hit']:play()
        end

        paddle1:update(dt)
        
        --left player paddle
        if love.keyboard.isDown('w') then
            paddle1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            paddle1.dy = PADDLE_SPEED
            else
                paddle1.dy = 0
        end
    end
    if game_state == 'play' then
        ball:update(dt)
        paddle2:update(dt)
    end
end

--keys (genral)
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if game_state == 'start' then
            game_state = 'serve'
        elseif game_state == 'serve' then
            game_state = 'play'
        elseif game_state == 'victory' then
            game_state = 'start'
            player2score = 0
            player1score = 0
            winning_player = 0
            servingplayer = math.random(2) == 1 and 1 or 2
        end
    end
end

function love.draw()
    push:apply('start')
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    --show hello  
    love.graphics.setFont(small_font)
    if game_state == 'start' then
        love.graphics.printf("welcome to pong!", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("press enter to play!", 0, 32, VIRTUAL_WIDTH, 'center')
    elseif game_state == 'serve' then
        love.graphics.printf("player" .. tostring(servingplayer) .. "s turn", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("press enter to serve!", 0, 32, VIRTUAL_WIDTH, 'center')
    elseif game_state == 'victory' then
        love.graphics.setFont(victory_font)
        love.graphics.printf("player " .. tostring(winning_player) .. " wins!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(small_font)
        love.graphics.printf("press enter to restart!", 0, 42, VIRTUAL_WIDTH, 'center')
    
    end
        --show score
    love.graphics.setFont(score_font)
    love.graphics.print(player1score, VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(player2score, VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
    
    --ball
    ball:render()
    --paddels
    paddle1:render()
    paddle2:render()

    --fps
    displayFPS()

    push:apply('end')
end

function displayFPS()
    love.graphics.setColor(0,1,0,1)
    love.graphics.setFont(small_font)
    love.graphics.print('fps: ' .. tostring(love.timer.getFPS()), 40, 20)
end
