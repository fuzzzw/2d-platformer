local Entity = require "entity"
local Color = require "color"
local Player = require "player"
local Map = require "map"
local Game_debug = require "game_debug"
local level = require "level"
local draw = require "draw"

local levels
local map_x = 0
local map_y = 0
local debug_items = {}

function love.load()
  levels = level.get_levels("maps/")
  map = levels[map_x][map_y]

  player = Entity {
    collision = Player {
      x = 300,
      y = 20,
      jump_height = -250
    },
    color = Color {r = 0, g = 0, b = 255},
  }

  debug_items["xy"] = Game_debug {
    posistion = 0,
    color     = Color {r = 0, g = 255, b = 255}
  }
  debug_items["y_velocity"] = Game_debug {
    posistion = 1,
    color     = Color {r = 0, g = 255, b = 255}
  }
  debug_items["map_location"] = Game_debug {
    posistion = 2,
    color     = Color {r = 0, g = 255, b = 255}
  }
end

function love.update(dt)
  for _, entity in ipairs(map.entities.updateable) do
    local args = {
      entity = entity,
      dt = dt
    }
    entity.updateable(args)
  end

  local entity = nil

  player.collision:update_y(dt)
  entity = player.collision:check_entities(map.entities.block)
  if entity then
    if player.collision.y < entity.collision.y then
      player.collision.y_velocity = 0
      player.collision.y = entity.collision.y - player.collision.h
    elseif player.collision.y_velocity < 0 then
      player.collision.y_velocity = 1
      player.collision.y = entity.collision.y + entity.collision.h
    end
  end

  player.collision:update_x(dt)
  entity = player.collision:check_entities(map.entities.block)
  if entity then
    if player.collision.x < entity.collision.x then
      player.collision.x = entity.collision.x - player.collision.w
    else
      player.collision.x = entity.collision.x + entity.collision.w + 1
    end
  end

  player.collision:update_other()

  entity = player.collision:check_entities(map.entities.script)
  if entity then
    local args = {
      player = player.collision,
      map = map,
      entity = entity
    }
    entity.script(args)
  end

  local new_map_x, new_map_y
  if player.collision.respawn then
    new_map_x = player.collision.map_spawn_x
    new_map_y = player.collision.map_spawn_y
    player.collision.respawn = false
  else
    new_map_x, new_map_y = level.update(player.collision,map_x,map_y)
  end

  if new_map_x then
    map_x = new_map_x
    map_y = new_map_y
    player.collision.map_x = new_map_x
    player.collision.map_y = new_map_y
    map = levels[map_x][map_y]
  end

  debug_items.xy.context         = "x:"..math.floor(player.collision.x)..", y:"..math.floor(player.collision.y)
  debug_items.y_velocity.context = "y_velocity: "..math.floor(player.collision.y_velocity)
  debug_items.map_location.context = "map: "..map_x..":"..map_y
end

function love.draw()
  draw.entity(player)
  draw.entities(map.entities.all)
  draw.game_debugs(debug_items)

  if player.collision.dead then
    draw.text("You are dead! Press \"R\" to restart.",love.graphics.getWidth()/2,love.graphics.getHeight()/2)
  end
end
