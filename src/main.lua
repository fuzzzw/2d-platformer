local Entity = require "entity"
local Color = require "color"
local Player = require "player"
local Game_debug = require "game_debug"
local level = require "level"
local draw = require "draw"

local map, maps
local map_x = 0
local map_y = 0
local debug_items = {}

function love.load()
  maps = level.get()
  map = maps[map_x][map_y]

  player = Entity {
    collision = Player {x = 300, y = 20},
    color = Color {r = 0, g = 0, b = 255}
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
  player.collision:update(map,dt)

  local new_map_x, new_map_y = level.update(player.collision,map_x,map_y)
  if new_map_x then
    map_x = new_map_x
    map_y = new_map_y
    map = maps[map_x][map_y]
  end

  -- only for debug
  if love.keyboard.isDown('r') then
    player.collision.x = 300
    player.collision.y = 20
    map_x = 0
    map_y = 0
    map = maps[map_x][map_y]
  end

  debug_items.xy.context         = "x:"..math.floor(player.collision.x)..", y:"..math.floor(player.collision.y)
  debug_items.y_velocity.context = "y_velocity: "..math.floor(player.collision.y_velocity)
end

function love.draw()
  draw.entity(player)
  draw.entities(map.all)
  draw.game_debugs(debug_items)
end
