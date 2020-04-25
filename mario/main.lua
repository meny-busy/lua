windwo_width = 1280
windwo_height = 720

virtual_width = 432
virtual_height = 243

class = require 'class'
push = require 'push'

require 'util'

require 'map'

function love.load()
    map = map()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(virtual_width, virtual_height, windwo_width, windwo_height, {
        fullscreen = false,
        resizable = false,
        vsync = true
})
end



function love.update(dt)

end




function love.draw()
    push:apply('start')
    love.graphics.clear(108/255, 140/255,255/255, 255/255)
    map.render()

    push:apply('end')
end