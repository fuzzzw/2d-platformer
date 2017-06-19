local p = require "player"
local draw = require "drawIt"
local level = require "level"
local map

local function common_collision(entity)
  if p.coll:check_collision(entity.coll) then
    local approx_y = 15

    if p.coll:ground_collision(entity.coll, p:getY_velocity(), approx_y) then
      p:setY_velocity(0)
      p.coll:setY(entity.coll:getY() - p.coll:getH() + 1)
    end
  else
    if not love.keyboard.isDown('space') and
    p:getY_velocity() == 0 then
      p:setY_velocity(1)
    end
  end
end

function love.load()
  map = level.load('maps/level_0.png')
  p = p:new(10,300,32,32)
end

function love.update(dt)

  local approx_x = 5
  -- collision checks
  for _, entity in ipairs(map) do
    common_collision(entity)
  end

	if love.keyboard.isDown('right') then
		if p.coll:getX() < (love.graphics.getWidth() - p.coll:getW()) then
      local blocked = false
      for _, entity in ipairs(map) do
        if p.coll:right_collision(entity.coll, approx_x) then
          blocked = true
          break
        end
      end
      if not blocked then
        p.coll:setX(p.coll:getX() + (p:getSpeed() * dt))
      end
		end
	elseif love.keyboard.isDown('left') then
    local blocked = false
    for _, entity in ipairs(map) do
      if p.coll:left_collision(entity.coll, approx_x) then
        blocked = true
        break
      end
    end
    if not blocked then
  		if p.coll:getX() > 0 then
  			p.coll:setX(p.coll:getX() - (p:getSpeed() * dt))
  		end
    end
	end

	if love.keyboard.isDown('space') then
		if p:getY_velocity() == 0 then
			p:setY_velocity(p:getJump_height())
		end
	end

	if p:getY_velocity() ~= 0 then
		p.coll:setY(p.coll:getY() + p:getY_velocity() * dt)
		p:setY_velocity(p:getY_velocity() - p:getGravity() * dt)
	end

	if p.coll:getY() > p:getGround() then
		p:setY_velocity(0)
    p.coll:setY(p:getGround())
	end
end

function love.draw()
  draw.entity(p)
  draw.entities(map)

  --debug
  draw.debug("x:"..math.floor(p.coll:getX())..", y:"..math.floor(p.coll:getY()),0)
  draw.debug("p:getY_velocity(): "..math.floor(p:getY_velocity()), 1)
  draw.debug("screen width: "..love.graphics.getWidth()..
             ", screen height: "..love.graphics.getHeight(),2)
end
