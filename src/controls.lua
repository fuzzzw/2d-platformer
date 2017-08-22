local controls = {}

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

local function groundOrCeilingBlock(player,entities,dt,approx_y)
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
    if player.x < (love.graphics.getWidth() - player.w) then
      player.x = player.x + (player.speed * dt)
      for _, entity in ipairs(entities) do
        if player:check_collision(entity.collision) then
          player.x = entity.collision.x - player.w
          break
        end
      end
    end
  elseif love.keyboard.isDown('left') then
    if player.x > 0 then
      player.x = player.x - (player.speed * dt)
      for _, entity in ipairs(entities) do
        if player:check_collision(entity.collision) then
          player.x = entity.collision.x + entity.collision.w
          break
        end
      end
    end
  end
end

function controls.update(player,entities,dt)

  fallingUpdate(player,entities,dt)
  groundOrCeilingBlock(player,entities,dt)
  leftOrRightBlock(player,entities,dt)

end

return controls
