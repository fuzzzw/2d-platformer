local controls = require "controls"
local entity = require "entity"
local color = require "color"
local player = require "player"
local level = require "level"
local draw = require "drawIt"
local map

function love.load()
  map = level.load('maps/level_0.png')
  player = entity(
    player(10,300,32,32),
    color(0,0,255)
  )
end

function love.update(dt)
  controls.update(player,map,5,15,dt)
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
