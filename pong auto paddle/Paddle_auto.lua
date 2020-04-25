Paddle_auto = Class{}
function Paddle_auto:init(x, y, width, height, dy)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = dy
end
function Paddle_auto:update(dt)
    if ball.x > VIRTUAL_WIDTH / 2 then
        self.y = ball.y
    end
end
function Paddle_auto:reset()
    paddle1 = Paddle(5, 20, 5 , 20)
    paddle2 = Paddle(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT - 30, 5, 20)
end

function Paddle_auto:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end