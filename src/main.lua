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
      y = 20
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
  player.collision:update(map,dt)

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
