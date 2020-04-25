Paddle = Class{}
function Paddle:init(x, y, width, height, dy)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = dy
end
random = math.random(7)
function Paddle:update(dt)
    if random ~= 1 then
        self.y = ball.y
    else
        math.random(-50, 50)
    end
end

function Paddle:reset()
    paddle1 = Paddle(5, 20, 5 , 20)
    paddle2 = Paddle(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT - 30, 5, 20)
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end