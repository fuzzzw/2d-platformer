local Collision = require "collision"
local Player = Collision:extend()

function Player:new(obj)  -- The constructor
  if type(obj) ~= "table" then
    obj = {}
  end

  Player.super.new(self,{
    x = obj.x or 10,
    y = obj.y or 300,
    w = obj.w or 32,
    h = obj.h or 32
  })

  self.speed       = obj.speed or 200
  self.y_velocity  = obj.y_velocity or 0
  self.jump_height = obj.jump_height or -400
  self.gravity     = obj.gravity or -1000
end

local function fallingUpdate(player,entities,dt)
  if player.y_velocity == 0 then
    if love.keyboard.isDown('space') then
      player.y_velocity = player.jump_height
    else
      if not player:check_entities(entities) then
        player.y_velocity = 1
      end
    end
  end

  if player.y_velocity ~= 0 then
    player.y = player.y + player.y_velocity * dt
    player.y_velocity = player.y_velocity - player.gravity * dt
  end
end

local function groundOrCeilingBlock(player,entities,dt)
  if player.y_velocity > 0 then
    local entity = player:check_entities(entities)
    if entity then
      player.y_velocity = 0
      player.y = entity.collision.y - player.h
    end
  elseif player.y_velocity < 0 then
    local entity = player:check_entities(entities)
    if entity then
      player.y_velocity = 1
      player.y = entity.collision.y + entity.collision.h
    end
  end
end

local function leftOrRightBlock(player,entities,dt)
  if love.keyboard.isDown('right') then
    player.x = player.x + (player.speed * dt)
    local entity = player:check_entities(entities)
    if entity then
      player.x = entity.collision.x - player.w
    end
  elseif love.keyboard.isDown('left') then
    player.x = player.x - (player.speed * dt)
    local entity = player:check_entities(entities)
    if entity then
      player.x = entity.collision.x + entity.collision.w
    end
  end
end

function Player:update(map,dt)
  fallingUpdate(self,map,dt)
  groundOrCeilingBlock(self,map,dt)
  leftOrRightBlock(self,map,dt)
end

return Player
