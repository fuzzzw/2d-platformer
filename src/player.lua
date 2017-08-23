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
  self.ground      = obj.ground or love.graphics.getHeight()
end

local function fallingUpdate(player,entities,dt)
  if player.y_velocity == 0 then
    if love.keyboard.isDown('space') then
      player.y_velocity = player.jump_height
    else
      for _, entity in ipairs(entities) do
        if not player:check_collision(entity.collision) then
          player.y_velocity = 1
          break
        end
      end
    end
  end

  if player.y_velocity ~= 0 then
    player.y = player.y + player.y_velocity * dt
    player.y_velocity = player.y_velocity - player.gravity * dt
  end

  if player.y > player.ground then
    playery_velocity = 0
    player.y = player.ground
  end
end

local function groundOrCeilingBlock(player,entities,dt)
  if player.y_velocity > 0 then
    for _, entity in ipairs(entities) do
      if player:check_collision(entity.collision) then
        player.y_velocity = 0
        player.y = entity.collision.y - player.h
        break
      end
    end
  elseif player.y_velocity < 0 then
    for _, entity in ipairs(entities) do
      if player:check_collision(entity.collision) then
        player.y_velocity = 1
        player.y = entity.collision.y + entity.collision.h
        break
      end
    end
  end
end

local function leftOrRightBlock(player,entities,dt)
  if love.keyboard.isDown('right') then
    player.x = player.x + (player.speed * dt)
    for _, entity in ipairs(entities) do
      if player:check_collision(entity.collision) then
        player.x = entity.collision.x - player.w
        break
      end
    end
  elseif love.keyboard.isDown('left') then
    player.x = player.x - (player.speed * dt)
    for _, entity in ipairs(entities) do
      if player:check_collision(entity.collision) then
        player.x = entity.collision.x + entity.collision.w
        break
      end
    end
  end
end

function Player:update(map,dt)
  fallingUpdate(self,map,dt)
  groundOrCeilingBlock(self,map,dt)
  leftOrRightBlock(self,map,dt)
end

return Player
