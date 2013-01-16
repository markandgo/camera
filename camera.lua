--[[
Copyright (c) 2010-2012 Matthias Richter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

local camera   = {}
camera.__index = camera

local lg  = love.graphics
local cos = math.cos
local sin = math.sin
local abs = math.abs
local max,min = math.max,math.min

local rotate = function(theta,x,y)
	return x*cos(theta)-y*sin(theta),x*sin(theta)+y*cos(theta)
end

local getCenter = function(self)
	if not self.shape then return lg.getWidth()/2,lg.getHeight()/2 end
	return self.shape:center()
end
-------------------
-- public interface
-------------------
function camera.new(shape,x,y,r,sx,sy)
	if type(shape) == 'number' then
		shape,x,y,r,sx,sy = nil,shape,x,y,r,sx
	end
	local t -- closure for swappable/optional shape
	local _stencil = lg.newStencil(function()
		t.shape:draw('fill')
	end)
	x,y   = x or lg.getWidth()/2, y or lg.getHeight()/2
	sx    = sx or 1
	sy,r  = sy or sx,r or 0
	t     = 
		{
			x = x, y = y, sx = sx, sy = sy, r = r,
			_stencil = _stencil,shape = shape
		}
	return setmetatable(t,camera)
end

function camera:rotate(phi)
	self.r = self.r + phi
	return self
end

function camera:setAngle(phi)
	self.r = phi
	return self
end

function camera:move(dx,dy)
	self.x, self.y = self.x + dx, self.y + dy
	return self
end

function camera:moveTo(x,y)
	self.x, self.y = x,y
	return self
end

function camera:setScale(sx,sy)
	self.sx,self.sy = sx,sy or sx
end

function camera:scale(sx,sy)
	self.sx,self.sy = self.sx*sx,self.sy*(sy or sx)
end

function camera:attach()
	-- draw poly mask
	lg.push()
	local cx,cy = getCenter(self)
	if self.shape then lg.setStencil(self._stencil) end
	-- transform view in viewport
	lg.translate(cx, cy)
	lg.scale(self.sx,self.sy)
	lg.rotate(self.r)
	lg.translate(-self.x, -self.y)
end

function camera:detach()
	if self.shape then lg.setStencil() end
	lg.pop()
end

function camera:draw(func)
	self:attach()
	func()
	self:detach()
end

function camera:cameraCoords(x,y)
	local cx,cy = getCenter(self)
	x,y = rotate(self.r, x-self.x, y-self.y)
	x,y = x*self.sx,y*self.sy
	return x + cx, y + cy
end

function camera:worldCoords(x,y)
	local cx,cy = getCenter(self)
	x,y = x-cx,y-cy
	x,y = x/self.sx, y/self.sy
	x,y = rotate(-self.r, x, y)
	return x+self.x, y+self.y
end

function camera:mouseWorldPos()
	return self:worldCoords(love.mouse.getPosition())
end

-------------------
--NOT available when shapeless
-------------------
function camera:worldContains(x,y)
	return self.shape:contains(self:cameraCoords(x,y))
end

function camera:bbox()
	return self.shape:bbox()
end

function camera:worldBbox()
	local x1,y1,x2,y2 = self.shape:bbox()
	x1,y1 = self:worldCoords(x1,y1)
	x2,y2 = self:worldCoords(x2,y2)
	x1,x2 = min(x1,x2),max(x1,x2)
	y1,y2 = min(y1,y2),max(y1,y2)
	return x1,y1,x2,y2
end

function camera:intersectsWorldRay(x,y,dx,dy)
	local x2,y2 = self:cameraCoords(x+dx,y+dy)
	x,y         = self:cameraCoords(x,y)
	dx,dy       = x2-x,y2-y
	return self.shape:intersectsRay(x,y,dx,dy)
end

return camera