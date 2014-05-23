-- CellGrid by ING
-- allows massive 3d entity management

class 'CellGrid'

function CellGrid:__init(cellSize, offsetX, offsetY)
	self.grid      = {}
	self.size      = cellSize or 100
	self.offsetX   = offsetX or -15000
	self.offsetY   = offsetY or -15000
end

-- #################################################################################################################################

function CellGrid:AddObject(object, pos, radius)
	range = radius and (math.ceil(radius / self.size)) or 0
	x = math.max(1, math.floor((pos.x - self.offsetX) / self.size - range))
	y = math.max(1, math.floor((pos.z - self.offsetY) / self.size - range))
	
	for i = x, range * 2 + x, 1 do
		if self.grid[i] == nil then self.grid[i] = {} end
		for j = y, range * 2 + y, 1 do
			if self.grid[i][j] == nil then self.grid[i][j] = {} end
			table.insert(self.grid[i][j], object)
		end
	end
end

function CellGrid:RemoveObject(object, pos, radius)
	range = radius and (math.ceil(radius / self.size)) or 0
	x = math.max(1, math.floor((pos.x - self.offsetX) / self.size - range))
	y = math.max(1, math.floor((pos.z - self.offsetY) / self.size - range))
	
	for i = x, range * 2 + x, 1 do
		for j = y, range * 2 + y, 1 do
			for k, comp in ipairs(self.grid[i][j]) do
				if comp == object then
					table.remove(self.grid[i][j], k)
					break
				end
			end
		end
	end
end

function CellGrid:GetCell(pos)
	x = math.max(1, math.floor((pos.x - self.offsetX) / self.size))
	y = math.max(1, math.floor((pos.z - self.offsetY) / self.size))
	
	if not self.grid[x] then return nil end
	return self.grid[x][y]
end


