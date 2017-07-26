local controls = require "controls"
local entity = require "entity"
local color = require "color"
local player = require "player"
local level = require "level"
local draw = require "drawIt"
local map, maps

function love.load()
  maps = level.get()
  map = maps[0][0]

  player = entity {
    collision = player {x = 10, y = 300, w = 32, h = 32},
    color = color {r = 0, g = 0, b = 255}
  }
end

function love.update(dt)
  local approx_x = 5
  local approx_y = 15
  controls.update(player,map,approx_x,approx_y,dt)
end

function love.draw()
  draw.entity(player)
  draw.entities(map)

  --debug
  draw.debug("x:"..math.floor(player.collision.x)..", y:"..math.floor(player.collision.y),0)
  draw.debug("player.y_velocity: "..math.floor(player.collision.y_velocity),1)
  draw.debug("screen width: "..love.graphics.getWidth()..
             ", screen height: "..love.graphics.getHeight(),2)
end
