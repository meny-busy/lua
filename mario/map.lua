map = class{}
tile_brick = 1
tile_empty = 4

function map:init()
    self.spritesheet = love.graphics.newImage('pack.png')
    self.tilewidth = 16
    self.tileheight = 16
    self.mapwidth = 30
    self.mapheight = 28
    self.tiles = {}

    self.tilesprites = generatequads(self.spritesheet, self.tilewidth, self.tileheight)

    for y = 1, self.mapheight do
        for x = 1, self.mapwidth do
            self:setTile(x, y, tile_empty)
        end
    end

    for y = self.mapheight / 2, self.mapheight do
        for x = 1, self.mapwidth do
            self.setTile(x, y, tile_brick)
        end
    end
end
function map:setTile(x, y, tile)
    self.tiles[(y - 1) * self.mapwidth + x] = tile
end

function map:getTile(x, y)
    return self.tiles[(y - 1) * self.mapwidth + x]
end

function map:update(dt)
    -- body
end

function map:render()
    for y = 1, self.mapheight do
        for x = 1, self.mapwidth do
            love.graphics.draw(self.spritesheet, self.tilesprites[self:getTile(x, y)],
                (x - 1) * self.tilewidth, (y - 1) * self.tileheight)
        end
    end
end