local M = {}

turtle = turtle -- shutup nvim

M.trashItems = {
	"cobblestone",
	"dirt",
	"flint",
	"gravel",
	"granite",
	"diorite",
}

M.trashItemsForCreate = {
	"cobblestone",
	"dirt",
	"flint",
}

-- Find and Select
function M.fas(itemname, prefix)
	local prefix = prefix or "minecraft:"
	for i = 1, 16 do
		turtle.select(i)
		if turtle.getItemCount(i) > 0 and turtle.getItemDetail(i).name == prefix .. itemname then
			return true
		end
	end
	return false
end

function M.dropTrash(create)
	local trash = (create and M.trashItemsForCreate or M.trashItems)
	for i = 1, 16 do
		turtle.select(i)
		local item = turtle.getItemDetail(i)
		if item then
			for _, v in ipairs(trash) do
				if item.name == "minecraft:" .. v then
					turtle.drop(64)
					break
				end
			end
		end
	end
end

return M
