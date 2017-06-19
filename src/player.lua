local collision = require "collision"
local player = {}

function player:new(x,y,w,h,speed,y_velocity,jump_height,gravity)  -- The constructor
  local object = {
    speed       = speed or 200,
    y_velocity  = y_velocity or 0,
    jump_height = jump_height or -400,
    gravity     = gravity or -1000,
    ground      = love.graphics.getHeight() - h,
    coll = collision:new(
      x or 0,
      y or 0,
      w or 0,
      h or 0
    ),
    color = {
      red   = 0,
      green = 0,
      blue  = 255
    }
  }
  setmetatable(object, { __index = player })  -- Inheritance
  return object
end

function player:setAll(speed,y_velocity,jump_height,gravity)
  self.speed       = speed or self.speed
  self.y_velocity  = y_velocity or self.y_velocity
  self.jump_height = jump_height or self.jump_height
  self.gravity     = gravity or self.gravity
end

function player:setGround(ground)
  self.x = ground
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
