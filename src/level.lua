function loadLevel(name)
  local image = love.image.newImageData(name)
  for x = 1, image:getWidth() do
    for y = 1, image:getHeight() do
      -- build entities from pixel posistion
      local pixel = image:getPixel( x - 1, y - 1 )
      if pixel ~= 255 then
        local primitives = {}
        primitives.coll = Collision:new(
          (x*10) - 10,
          (y*10) - 10,
          10,
          10
        )
        primitives.primitive = true
        primitives.color = {
          red   = 255,
          green = 0,
          blue  = 0
        }
        entity[#entity+1] = primitives
      end
    end
  end
end
