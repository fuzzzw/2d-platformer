local collision = require "collision"
local color = require "color"
local player = collision:extend()

function player:new(x,y,w,h,speed,y_velocity,jump_height,gravity)  -- The constructor
  player.super.new(self,x,y,w,h)
  self.speed       = speed or 200
  self.y_velocity  = y_velocity or 0
  self.jump_height = jump_height or -400
  self.gravity     = gravity or -1000
  self.ground      = love.graphics.getHeight() - h
  self.color       = color(0,0,255)
end

function player:setGround(ground)
  self.ground = ground
end

function player:setGravity(speed)
  self.speed = speed
end

function player:setY_velocity(y_velocity)
  self.y_velocity = y_velocity
end

function player:setJump_height(jump_height)
  self.jump_height = jump_height
end

function player:setGravity(gravity)
  self.gravity = gravity
end

function player:getGround()
  return self.ground
end

function player:getSpeed()
  return self.speed
end

function player:getY_velocity()
  return self.y_velocity
end

function player:getJump_height()
  return self.jump_height
end

function player:getGravity()
  return self.gravity
end

return player
