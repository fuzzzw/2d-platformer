local controls = {}

local function common_collision(player,entity,approx_y)
  if player:check_collision(entity) then
    if player:ground_collision(entity, player:getY_velocity(), approx_y) then
      player:setY_velocity(0)
      player:setY(entity:getY() - player:getHeight() + 1)
    elseif player:ceiling_collision(entity, player:getY_velocity(), approx_y) then
      player:setY_velocity(2)
      player:setY(entity:getY() + entity:getHeight())
    end
  else
    if not love.keyboard.isDown('space') and
    player:getY_velocity() == 0 then
      player:setY_velocity(1)
    end
  end
end

local function movement(player,entities,dt,approx_x)
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

function controls.update(player,entities,approx_x,approx_y,dt)
  for _, entity in ipairs(entities) do
    common_collision(player:getCollision(),entity:getCollision(),approx_y)
  end
  movement(player:getCollision(),entities,dt,approx_x)
end

return controls
