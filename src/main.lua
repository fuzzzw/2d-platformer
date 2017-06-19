local entity = require "entity"
local color = require "color"
local player = require "player"
local level = require "level"
local draw = require "drawIt"
local map

local function common_collision(player,entity,approx_y)
  if player:check_collision(entity) then
    if player:ground_collision(entity, player:getY_velocity(), approx_y) then
      player:setY_velocity(0)
      player:setY(entity:getY() - player:getHeight() + 1)
    end
  else
    if not love.keyboard.isDown('space') and
    player:getY_velocity() == 0 then
      player:setY_velocity(1)
    end
  end
end

local function controls(player,entities,dt,approx_x)
  if love.keyboard.isDown('right') then
		if player:getX() < (love.graphics.getWidth() - player:getWidth()) then
      local blocked = false
      for _, entity in ipairs(entities) do
        if player:right_collision(entity:getCollision(), approx_x) then
          blocked = true
          break
        end
      end
      if not blocked then
        player:setX(player:getX() + (player:getSpeed() * dt))
      end
		end
	elseif love.keyboard.isDown('left') then
    local blocked = false
    for _, entity in ipairs(entities) do
      if player:left_collision(entity:getCollision(), approx_x) then
        blocked = true
        break
      end
    end
    if not blocked then
  		if player:getX() > 0 then
  			player:setX(player:getX() - (player:getSpeed() * dt))
  		end
    end
	end

	if love.keyboard.isDown('space') then
		if player:getY_velocity() == 0 then
			player:setY_velocity(player:getJump_height())
		end
	end

	if player:getY_velocity() ~= 0 then
		player:setY(player:getY() + player:getY_velocity() * dt)
		player:setY_velocity(player:getY_velocity() - player:getGravity() * dt)
	end

	if player:getY() > player:getGround() then
		player:setY_velocity(0)
    player:setY(player:getGround())
	end
end

function love.load()
  map = level.load('maps/level_0.png')
  player = entity(
    player(10,300,32,32),
    color(0,0,255)
  )
end

function love.update(dt)
  -- collision checks
  for _, entity in ipairs(map) do
    common_collision(player:getCollision(),entity:getCollision(),15)
  end

  controls(player:getCollision(),map,dt,5)
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
