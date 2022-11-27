local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

bucket = {
	version = os.time({ year = 2022, month = 5, day = 13 }),
	fork = "fluxionary",

	modname = modname,
	modpath = modpath,

	S = S,

	has = {
		default = minetest.get_modpath("default"),
	},

	log = function(level, message, ...)
		message = message:format(...)
		minetest.log(level, ("[%s] %s"):format(modname, message))
	end,

	tell = function(player, message, ...)
		if type(player) ~= "string" then
			player = player:get_player_name()
		end

		message = message:format(...)
		minetest.chat_send_player(player, ("[%s] %s"):format(modname, message))
	end,

	dofile = function(...)
		dofile(table.concat({ modpath, ... }, DIR_DELIM) .. ".lua")
	end,
}

bucket.dofile("settings")
bucket.dofile("resources")
bucket.dofile("api", "init")
bucket.dofile("tools", "init")
bucket.dofile("compat", "init")
