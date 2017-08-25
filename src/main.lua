local Entity = require "entity"
local Color = require "color"
local Player = require "player"
local level = require "level"
local draw = require "draw"

local map, maps
local map_x = 0
local map_y = 0

function love.load()
  maps = level.get()
  map = maps[map_x][map_y]

  player = Entity {
    collision = Player({x = 300, y = 20}),
    color = Color {r = 0, g = 0, b = 255}
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
end

function love.draw()
  draw.entity(player)
  draw.entities(map)

  --debug
  draw.debug("x:"..math.floor(player.collision.x)..", y:"..math.floor(player.collision.y),0)
  draw.debug("y_velocity: "..math.floor(player.collision.y_velocity),1)
  --draw.debug("screen width: "..love.graphics.getWidth()..
  --           ", screen height: "..love.graphics.getHeight(),2)
end
