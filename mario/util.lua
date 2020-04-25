function generatequads(atlas, tilewidth, tileheigth)
    local sheetwidth = atlas:getwidth() / tilewidth
    local sheetheight = atlas:getheight() / tileheigth

    local sheetcounter = 1
    local quads = {}

    for y = 0, sheetheight - 1 do
        for x = 0, sheetwidth - 1 do
            quads[sheetcounter] = love.graphics.newQuad(x * tilewidth, y * tileheigth, tilewidth, tileheigth, atlas:getDimensions())
            sheetcounter = sheetcounter + 1
        end
    end

    return quads
end