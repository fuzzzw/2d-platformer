local Collision = require "collision"
local Color = require "color"
local Entity = require "entity"
local maps_dir = love.filesystem.getDirectoryItems("maps")
local level = {}

local function load(name)
  local image = love.image.newImageData(name)
  local entities = { all = {} }

  for x = 1, image:getWidth() do
    for y = 1, image:getHeight() do
      local r, g, b = image:getPixel(x - 1, y - 1)
      local entity_type
      local found_entity = true

      if r == 255 and g == 0 and b == 0 then
        entity_type = "death"
      elseif r == 0 and g == 0 and b == 0 then
        r = 255
        g = 255
        b = 255
      else
        found_entity = false
      end

      if found_entity then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {r = r, g = g, b = b}
        }
        if entity_type then
          if not entities[entity_type] then
            entities[entity_type] = {}
          end
          entities[entity_type][#entities[entity_type] + 1] = entity
        end
        entities.all[#entities.all + 1] = entity
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
      xd = -xd
    end

    if ys == "n" then
      yd = -yd
    end

    if maps[xd] == nil then
      maps[xd] = {}
    end

    maps[xd][yd] = load("maps/"..v)
  end

  return maps
end

function level.update(player,map_x,map_y)
  local which_side = player:check_boundaries()
  if which_side then
    local half_w = player.w / 2
    local half_h = player.h / 2

    if which_side == "top" then
      map_y = map_y + 1
      player.y = love.graphics.getHeight() - half_h
    elseif which_side == "bottom" then
      map_y = map_y - 1
      player.y = -half_h
    elseif which_side == "right" then
      map_x = map_x + 1
      player.x = -half_w
    else
      map_x = map_x - 1
      player.x = love.graphics.getWidth() - half_w
    end
    return map_x, map_y
  end

  return nil
end

return level
