local collision = require "collision"
local color = require "color"
local level = {}

function level.load(name)
  local image = love.image.newImageData(name)
  local res = {}
  for x = 1, image:getWidth() do
    for y = 1, image:getHeight() do
      -- build entities from pixel posistion
      local pixel = image:getPixel( x - 1, y - 1 )
      if pixel ~= 255 then
        local primitive = {
          collision = collision(
            (x*10) - 10,
            (y*10) - 10,
            10,
            10
          ),
          color = color(255,0,0)
        }
        res[#res+1] = primitive
      end
    end
  end

  return res
end

return level
