local collision = require "collision"
local level = {}

function level.load(name)
  local image = love.image.newImageData(name)
  local res = {}
  for x = 1, image:getWidth() do
    for y = 1, image:getHeight() do
      -- build entities from pixel posistion
      local pixel = image:getPixel( x - 1, y - 1 )
      if pixel ~= 255 then
        local primitive = {}
        primitive.coll = collision(
          (x*10) - 10,
          (y*10) - 10,
          10,
          10
        )
        primitive.color = {
          red   = 255,
          green = 0,
          blue  = 0
        }
        res[#res+1] = primitive
      end
    end
  end

  return res
end

return level
