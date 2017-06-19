local collision = require "collision"
local color = require "color"
local entity = require "entity"
local level = {}

function level.load(name)
  local image = love.image.newImageData(name)
  local entities = {}
  for x = 1, image:getWidth() do
    for y = 1, image:getHeight() do
      -- build entities from pixel posistion
      local pixel = image:getPixel( x - 1, y - 1 )
      if pixel ~= 255 then
        new_entity = entity(
          collision(
            (x*10) - 10,
            (y*10) - 10,
            10,
            10
          ),
          color(255,0,0)
        )
        entities[#entities+1] = new_entity
      end
    end
  end

  return entities
end

return level
