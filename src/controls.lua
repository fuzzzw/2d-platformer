local new_player = require "player"
local controls = {}

local function common_collision(player,entity,approx_y)
  if player:check_collision(entity) then
    if player:ground_collision(entity, player.y_velocity, approx_y) then
      player.y_velocity = 0
      player.y = entity.y - player.h + 1
    elseif player:ceiling_collision(entity, player.y_velocity, approx_y) then
      player.y_velocity = 2
      player.y = entity.y + entity.h
    end
  else
    if not love.keyboard.isDown('space') and
    player.y_velocity == 0 then
      player.y_velocity = 1
    end
  end

  return false
end

local function movement(player,entities,dt,approx_x)
  local blocked = false

  if love.keyboard.isDown('right') then
    if player.x < (love.graphics.getWidth() - player.w) then
      blocked = false
      for _, entity in ipairs(entities) do
        if player:right_collision(entity.collision, approx_x) then
          blocked = true
          break
        end
      end
      if not blocked then
        player.x = player.x + (player.speed * dt)
      end
    end
  elseif love.keyboard.isDown('left') then
    blocked = false
    for _, entity in ipairs(entities) do
      if player:left_collision(entity.collision, approx_x) then
        blocked = true
        break
      end
    end
    if not blocked then
      if player.x > 0 then
        player.x = player.x - (player.speed * dt)
      end
    end
  end

  if love.keyboard.isDown('space') then
    if player.y_velocity == 0 then
      player.y_velocity = player.jump_height
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

function controls.update(player,entities,approx_x,approx_y,dt)
  -- local tmp_player = new_player(player.collision) TODO: make this work for every class

  for _, entity in ipairs(entities) do
    local collision_found = common_collision(player.collision,entity.collision,approx_y)
    if collision_found then
      break
    end
  end
  movement(player.collision,entities,dt,approx_x)
end

return controls
