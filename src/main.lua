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

  player = entity(
    player(10,300,32,32),
    color(0,0,255)
  )
end

function love.update(dt)
  local approx_x = 5
  local approx_y = 10
  controls.update(player,map,approx_x,approx_y,dt)
end

function love.draw()
  draw.entity(player)
  draw.entities(map)

  --debug
  draw.debug("x:"..math.floor(player:getCollision():getX())..", y:"..math.floor(player:getCollision():getY()),0)
  draw.debug("player:getY_velocity(): "..math.floor(player:getCollision():getY_velocity()), 1)
  draw.debug("screen width: "..love.graphics.getWidth()..
             ", screen height: "..love.graphics.getHeight(),2)
end
