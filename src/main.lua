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
      x = map.spawn_x,
      y = map.spawn_y,
      spawn_x = map.spawn_x,
      spawn_y = map.spawn_y
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
end

function love.update(dt)
  player.collision:update(map.entities,dt)

  local new_map_x, new_map_y = level.update(player.collision,map_x,map_y)
  if new_map_x then
    map_x = new_map_x
    map_y = new_map_y
    map = levels[map_x][map_y]
    player.collision.spawn_x = map.spawn_x == 0 and 300 or map.spawn_x
    player.collision.spawn_y = map.spawn_y == 0 and 20  or map.spawn_y
  end

  debug_items.xy.context         = "x:"..math.floor(player.collision.x)..", y:"..math.floor(player.collision.y)
  debug_items.y_velocity.context = "y_velocity: "..math.floor(player.collision.y_velocity)
end

function love.draw()
  draw.entity(player)
  draw.entities(map.entities.all)
  draw.game_debugs(debug_items)

  if player.collision.dead then
    draw.text("You are dead! Press \"R\" to restart.",love.graphics.getWidth()/2,love.graphics.getHeight()/2)
  end
end
