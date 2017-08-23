local Entity = require "entity"
local Color = require "color"
local Player = require "player"
local level = require "level"
local draw = require "draw"
local map, maps

function love.load()
  maps = level.get()
  map = maps[0][0]

  player = Entity {
    collision = Player(),
    color = Color {r = 0, g = 0, b = 255}
  }
end

function love.update(dt)
  player.collision:update(map,dt)

  -- only for debug
  if love.keyboard.isDown('r') then
    player.collision.x = 10
    player.collision.y = 300
    map = maps[0][0]
  end
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
