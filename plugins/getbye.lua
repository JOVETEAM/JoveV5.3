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
local function run(msg, matches, callback, extra)

local data = load_data(_config.moderation.data)

local group_bye = data[tostring(msg.to.id)]['group_bye']

if matches[1] == 'chat_del_user' then --For Normal Group
    if not msg.service then 
        return nil 
    else
        return group_bye
end
end
end
return {
  patterns = {
  "^!!tgservice (chat_del_user)$"
  },
  run = run,
  pre_process = pre_process
}