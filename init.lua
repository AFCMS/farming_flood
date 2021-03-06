local has_itemdrop = minetest.get_modpath("item_drop")

minetest.register_on_mods_loaded(function()
	for name,value in pairs(minetest.registered_nodes) do
		if minetest.get_item_group(name, "plant") >= 1 and not value.on_flood then
			minetest.override_item(name, {
				floodable = true,
				on_flood = function(pos, oldnode, newnode)
					minetest.dig_node(pos)
					if not has_itemdrop then
						local drops = minetest.get_node_drops(oldnode.name, nil)
						for i = 1, #drops do
							minetest.add_item(pos, drops[i])
						end
					end
				end,
			})
		end
	end
end)