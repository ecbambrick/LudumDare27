return function(image, x, y, w, h)
	return {
		image = image,
		quad = love.graphics.newQuad(x, y, w, h, image:getWidth(), image:getHeight()),
		x = x,
		y = y,
		w = w,
		h = h,
		draw = function(self, x, y, dx)
			if dx == -1 then x = x + self.w end
			love.graphics.drawq(self.image, self.quad, x, y, 0, dx, 1)
		end,
	}
end
