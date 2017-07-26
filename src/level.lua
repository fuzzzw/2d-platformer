local collision = require "collision"
local color = require "color"
local entity = require "entity"
local maps_dir = love.filesystem.getDirectoryItems("maps")
local level = {}

local function load(name)
  local image = love.image.newImageData(name)
  local entities = {}
  for x = 1, image:getWidth() do
    for y = 1, image:getHeight() do
      -- build entities from pixel posistion
      local pixel = image:getPixel(x - 1, y - 1)
      if pixel ~= 255 then
        new_entity = entity {
          collision = collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = color {r = 255, g = 0, b = 0}
        }
        entities[#entities+1] = new_entity
      end
    end
  end

  return entities
end

function level.get()
  local maps = {}
  local pattern = "_(%l)(%d-)_(%l)(%d-).png"
  for _, v in ipairs(maps_dir) do
    local xs, xd, ys, yd = v:match(pattern)

    -- convert to numbers
    xd = xd + 0
    yd = yd + 0

    if xs == "n" then
      xd = xd * -1
    end

    if ys == "n" then
      yd = yd * -1
    end

    if maps[xd] == nil then
      maps[xd] = {}
    end

    maps[xd][yd] = load("maps/"..v)
  end

  return maps
end

return level
