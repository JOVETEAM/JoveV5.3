--[[
|------------------------------------------------- |--------- ______-----------------_______---|
|   ______   __   ______    _____     _____    __  |  _____  |  ____|  __     __    /  _____/  |
|  |__  __| |  | |__  __|  /     \   |     \  |  | | |__   | | |____  |  |   |  |  /  /____    |
|    |  |   |  |   |  |   /  /_\  \  |  |\  \ |  | |   /  /  |  ____| |  |   |  |  \____   /   |
|    |  |   |  |   |  |  /  _____  \ |  | \  \|  | |  /  /_  | |____  |  |___|  |   ___/  /    |
|    |__|   |__|   |__| /__/     \__\|__|  \_____| | |_____| |______|  \_______/  /______/     |
|--------------------------------------------------|-------------------------------------------|
| This Project Powered by : Pouya Poorrahman CopyRight 2016 Jove Version 5.3 Anti Spam Cli Bot |
|----------------------------------------------------------------------------------------------|
]]
local function run(msg, matches)
    if matches[1]:lower() == '+' and is_sudo(msg) then
        block_user("user#id"..matches[2],ok_cb,false)
        return "User blocked"
    end
    if matches[1]:lower() == '-' and is_sudo(msg) then
	    unblock_user("user#id"..matches[2],ok_cb,false)
        return "User unblocked"
    end
return {
  patterns = {
	"^[Bb]lock (+) (%d+)$",
	"^[Bb]lock (-) (%d+)$",
	"^[#!/][Bb]lock (+) (%d+)$",
	"^[#!/][Bb]lock (-) (%d+)$",
  },
  run = run,
}
end
--By @POUYA POORRAHMAN :)
----Ready For Jove TG V5.3
