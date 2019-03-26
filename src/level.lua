local Collision = require "collision"
local Color = require "color"
local Entity = require "entity"
local Map = require "map"
local level = {}

local function load(name)
  local image = love.image.newImageData(name)
  local entities = {
    all = {},
    block = {},
    script = {},
    updateable = {}
  }

  for x = 1, image:getWidth() do
    for y = 1, image:getHeight() do
      local r, g, b = image:getPixel(x - 1, y - 1)
      local entity = nil
      r = r * 255
      g = g * 255
      b = b * 255

      if r == 255 and g == 0 and b == 0 then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {
            r = r,
            g = g,
            b = b
          },
          script = function (args)
            args.player.dead = true
          end
        }
      elseif r == 51 and g == 51 and b == 51 then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {
            r = 255,
            g = 255,
            b = 255
          }
        }
      elseif r == 0 and g == 255 and b == 0 then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {
            r = r,
            g = g,
            b = b
          },
          script = function (args)
            args.player.map_spawn_x = args.map.x
            args.player.map_spawn_y = args.map.y
            args.player.spawn_x = args.entity.collision.x - args.entity.collision.w
            args.player.spawn_y = args.entity.collision.y - args.player.h
          end
        }
      elseif r == 255 and g == 0 and b == 255 then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {
            r = r,
            g = g,
            b = b
          },
          block = true,
          updateable = function (args)
            local moveAmount = 60
            local speed = 30
            args.entity:iTime()

            if args.entity.time > (moveAmount+1) then
              args.entity.time = -moveAmount
            end

            if args.entity.time > 0 then
              args.entity.collision.y = args.entity.collision.y - speed * args.dt
            else
              args.entity.collision.y = args.entity.collision.y + speed * args.dt
            end
          end
        }
      elseif r == 255 and g == 255 and b == 0 then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {
            r = r,
            g = g,
            b = b
          },
          block = true,
          updateable = function (args)
            local moveAmount = 60
            local speed = 30
            args.entity:iTime()

            if args.entity.time > (moveAmount+1) then
              args.entity.time = -moveAmount
            end

            if args.entity.time > 0 then
              args.entity.collision.x = args.entity.collision.x - speed * args.dt
            else
              args.entity.collision.x = args.entity.collision.x + speed * args.dt
            end
          end
        }
      elseif r == 45 and g == 212 and b == 255 then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {
            r = r,
            g = g,
            b = b
          },
          block = true,
          updateable = function (args)
            local moveAmount = 60
            local speed = 30
            args.entity:iTime()

            if args.entity.time > (moveAmount+1) then
              args.entity.time = -moveAmount
            end

            args.entity.collision.y = args.entity.collision.y - speed * args.dt
          end
        }
      elseif r == 0 and g == 0 and b == 0 then
        entity = Entity {
          collision = Collision {
            x = (x*10) - 10,
            y = (y*10) - 10,
            w = 10,
            h = 10
          },
          color = Color {
            r = 255,
            g = 255,
            b = 255
          },
          block = true
        }
      end

      if entity then
        if entity.script then
          entities.script[#entities.script + 1] = entity
        end

        if entity.block then
          entities.block[#entities.block + 1] = entity
        end

        if entity.updateable then
          entities.updateable[#entities.updateable + 1] = entity
        end

        entities.all[#entities.all + 1] = entity
      end
    end
  end

  return Map {
    entities = entities
  }
end

function level.get_levels(dir)
  local levels = {}
  local pattern = "_(%l)(%d-)_(%l)(%d-).png"
  for _, v in ipairs(love.filesystem.getDirectoryItems(dir)) do
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

    if levels[xd] == nil then
      levels[xd] = {}
    end

    map = load(dir..v)
    map.x = xd
    map.y = yd
    levels[xd][yd] = map
  end

  return levels
end

function level.update(player,map_x,map_y)
  local which_side = player:check_boundaries()
  if which_side then
    local half_w = player.w / 2
    local half_h = player.h / 2

    if which_side == 0 then       -- top
      map_y = map_y + 1
      player.y = love.graphics.getHeight() - half_h
    elseif which_side == 1 then   -- bottom
      map_y = map_y - 1
      player.y = -half_h
    elseif which_side == 3 then   -- right
      map_x = map_x + 1
      player.x = -half_w
    else                          -- left
      map_x = map_x - 1
      player.x = love.graphics.getWidth() - half_w
    end
    return map_x, map_y
  end

  return nil
end

return level
