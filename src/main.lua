require "collision"
require "entities"
require "level"
require "drawIt"

function common_collision(ent)
  if player.coll:check_collision(ent.coll) then
    local approx_y = 15

    if player.coll:ground_collision(ent.coll, player.y_velocity, approx_y) then
      player.y_velocity = 0
      player.y = ent.coll:getY() - player.height + 1
    end
  else
    if not love.keyboard.isDown('space') and
    player.y_velocity == 0 then
      player.y_velocity = 1
    end
  end
end

function love.load()
  loadLevel('maps/level_0.png')
  loadEntities()
end

function love.update(dt)

  local approx_x = 5
  -- collision checks
  for _, ent in ipairs(entity) do
    common_collision(ent)
  end

	if love.keyboard.isDown('right') then
		if player.x < (love.graphics.getWidth() - player.width) then
      local blocked = false
      for _, ent in ipairs(entity) do
        if player.coll:right_collision(ent.coll, approx_x) then
          blocked = true
          break
        end
      end
      if not blocked then
        player.x = player.x + (player.speed * dt)
      end
		end
	elseif love.keyboard.isDown('left') then
    local blocked = false
    for _, ent in ipairs(entity) do
      if player.coll:left_collision(ent.coll, approx_x) then
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
		player.y_velocity = 0
    player.y = player.ground
	end

  --update player collision
  player.coll:setAll(player.x, player.y, player.width, player.height)
end

function love.draw()
  -- draw primitives
  for _, v in ipairs(entity) do
    if v.primitive then
      drawIt(v.coll,255,0,0)
    end
  end

  drawIt(platform.coll, 255, 255, 255)
  drawIt(player.coll, 0, 0, 255)

  -- custom entities
  --drawIt(boxt.coll,255,0,255)
  --drawIt(box.coll,255,0,0)
  --drawIt(box2.coll, 255,0,0)
  --drawIt(box3.coll, 255, 255, 0)
  --drawIt(box4.coll, 255, 255, 0)

  love.graphics.setColor(255, 255, 255)

  --debug
  love.graphics.print( "x:"..math.floor(player.x)..", y:"..math.floor(player.y), 0, 0)
  love.graphics.print("player.y_velocity: "..math.floor(player.y_velocity), 0, 15)
  love.graphics.print("screen width: "..love.graphics.getWidth()..
                      ", screen height: "..love.graphics.getHeight(), 0, 30)
end
