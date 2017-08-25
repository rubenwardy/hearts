hearts = {}

function hearts.get_hearts(player)
	return tonumber(player:get_attribute("hearts") or "0")
end

function hearts.set_hearts(player, v)
	player:set_attribute("hearts", v)
	hearts.set_player_max_hp(player)
end

function hearts.add_hearts(player, v)
	v = v or 1

	-- Increase hearts value
	local h = hearts.get_hearts(player)
	hearts.set_hearts(player, h + v)

	-- Increase HP
	print("HP was " .. player:get_hp())
	player:set_hp(player:get_hp() + v * 2)
	print("HP is now " .. player:get_hp())
end

function hearts.set_player_max_hp(player)
	local hp_max = 20 + hearts.get_hearts(player) * 2
	print("Setting hp_max to " .. hp_max)
	player:set_properties({
		hp_max = hp_max
	})
end

minetest.register_on_joinplayer(function(player)
	hearts.set_player_max_hp(player)
end)

minetest.register_chatcommand("giveheart", {
	privs = { server = true },
	func = function(name, param)
		if param:trim() == "" then
			param = nil
		end

		local player = minetest.get_player_by_name(param or name)
		hearts.add_hearts(player, 1)
		return true, "You now have " .. hearts.get_hearts(player) .. " hearts!"
 	end
})
