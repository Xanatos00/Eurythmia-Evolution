function hud.item_eat(hunger_change, replace_with_item)
			minetest.chat_send_all("eat")
	return function(itemstack, user, pointed_thing)
		if itemstack:take_item() ~= nil then
			local h = tonumber(hud.hunger[user:get_player_name()])
			h=h+hunger_change
			if h>30 then h=30 end
			hud.hunger[user:get_player_name()]=h
			hud.save_hunger(user)
			itemstack:add_item(replace_with_item) -- note: replace_with_item is optional
			--sound:eat
		end
		return itemstack
	end
end

local function overwrite(name, hunger_change, replace_with_item)
	local tab = minetest.registered_items[name]
	if tab == nil then return end
	tab.on_use = hud.item_eat(hunger_change)--, replace_with_item)
	minetest.registered_items[name] = tab
end

overwrite("default:apple", 2)
if minetest.get_modpath("farming") ~= nil then
	overwrite("farming:bread", 4)
end

if minetest.get_modpath("mobs") ~= nil then
	overwrite("mobs:meat", 6)
	overwrite("mobs:rat_cooked", 5)
end

if minetest.get_modpath("moretrees") ~= nil then
	overwrite("moretrees:coconut_milk", 1)
	overwrite("moretrees:raw_coconut", 2)
	overwrite("moretrees:acorn_muffin", 3)
	overwrite("moretrees:spruce_nuts", 1)
	overwrite("moretrees:pine_nuts", 1)
	overwrite("moretrees:fir_nuts", 1)
end

if minetest.get_modpath("dwarves") ~= nil then
	overwrite("dwarves:beer", 2)
	overwrite("dwarves:apple_cider", 1)
	overwrite("dwarves:midus", 2)
	overwrite("dwarves:tequila", 2)
	overwrite("dwarves:tequila_with_lime", 2)
	overwrite("dwarves:sake", 2)
end
