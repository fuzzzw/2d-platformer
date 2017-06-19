local player = require "player"
local level = require "level"
local draw = require "drawIt"
local map

local function common_collision(entity)
  if player:check_collision(entity.coll) then
    local approx_y = 15

    if player:ground_collision(entity.coll, player:getY_velocity(), approx_y) then
      player:setY_velocity(0)
      player:setY(entity.coll:getY() - player:getH() + 1)
    end
  else
    if not love.keyboard.isDown('space') and
    player:getY_velocity() == 0 then
      player:setY_velocity(1)
    end
  end
end

function love.load()
  map = level.load('maps/level_0.png')
  player = player(10,300,32,32)
end

function love.update(dt)

  local approx_x = 5
  -- collision checks
  for _, entity in ipairs(map) do
    common_collision(entity)
  end

	if love.keyboard.isDown('right') then
		if player:getX() < (love.graphics.getWidth() - player:getW()) then
      local blocked = false
      for _, entity in ipairs(map) do
        if player:right_collision(entity.coll, approx_x) then
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
    for _, entity in ipairs(map) do
      if player:left_collision(entity.coll, approx_x) then
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

function love.draw()
  draw.entity(player)
  draw.entities(map)

  --debug
  draw.debug("x:"..math.floor(player:getX())..", y:"..math.floor(player:getY()),0)
  draw.debug("player:getY_velocity(): "..math.floor(player:getY_velocity()), 1)
  draw.debug("screen width: "..love.graphics.getWidth()..
             ", screen height: "..love.graphics.getHeight(),2)
end
