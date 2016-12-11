local function reload_plugins( )
  plugins = {}
  load_plugins()
end

function run(msg, matches)
 if is_sudo(msg) or is_owner(msg) or is_admin(msg) or is_admin2(msg) then
 
  if msg.to.type == 'channel' then
 if matches[1] == "setlang" and matches[2] == "en" then
    redis:set("sp:lang", "en")
    file = http.request("http://142.0.70.100/supergroup-en.txt")
	security = http.request("http://142.0.70.100/msg_checks.txt")
	ban = http.request("http://142.0.70.100/banhammer-en.txt")
	filter = http.request("http://142.0.70.100/filter-en.txt")
	help = http.request("http://142.0.70.100/help-en.txt")
	lockb = http.request("http://142.0.70.100/lockbot-en.txt")
	rmsg = http.request("http://142.0.70.100/rmsg-en.txt")
    local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	while b ~= 0 do
    security = security:trim()
    security,b = security:gsub('^!+','')
	end
    while b ~= 0 do
    ban = ban:trim()
    ban,b = ban:gsub('^!+','')
	end
    while b ~= 0 do
    filter = filter:trim()
    filter,b = filter:gsub('^!+','')
	end
    while b ~= 0 do
    help = help:trim()
    help,b = help:gsub('^!+','')
	end
    while b ~= 0 do
    lockb = lockb:trim()
    lockb,b = lockb:gsub('^!+','')
	end
    while b ~= 0 do
    rmsg = rmsg:trim()
    rmsg,b = rmsg:gsub('^!+','')
	end
      fileb = io.open("./plugins/supergroup.lua", "w")
      fileb:write(file)
      fileb:flush()
      fileb:close()
	  sysb = io.open("./plugins/msg_checks.lua", "w")
      sysb:write(security)
      sysb:flush()
      sysb:close()
                      banb = io.open("./plugins/banhammer.lua", "w")
      banb:write(ban)
      banb:flush()
      banb:close()
                       filterb = io.open("./plugins/filter.lua", "w")
      filterb:write(filter)
      filterb:flush()
      filterb:close()
                       helpb = io.open("./plugins/helpen.lua", "w")
      helpb:write(help)
      helpb:flush()
      helpb:close()
                       lockbb = io.open("./plugins/lock_bots.lua", "w")
      lockbb:write(lockb)
      lockbb:flush()
      lockbb:close()
                       rmsgb = io.open("./plugins/rmsg.lua", "w")
      rmsgb:write(rmsg)
      rmsgb:flush()
      rmsgb:close()
	  reload_plugins( )
	  return "<i>💫Supergroup languages has been changed💫</i>"
elseif matches[1] == "setlang" and matches[2] == "فا" then
    redis:set("sp:lang", "فا")
    file = http.request("http://142.0.70.100/supergroup-fa.txt")
	security = http.request("http://142.0.70.100/msg_checks.txt")
	ban = http.request("http://142.0.70.100/banhammer-fa.txt")
	filter = http.request("http://142.0.70.100/filter-fa.txt")
	help = http.request("http://142.0.70.100/help-fa.txt")
	lockb = http.request("http://142.0.70.100/lockbot-fa.txt")
	rmsg = http.request("http://142.0.70.100/rmsg-fa.txt")
 local b = 1
    while b ~= 0 do
    file = file:trim()
    file,b = file:gsub('^!+','')
	end
	while b ~= 0 do
    security = security:trim()
    security,b = security:gsub('^!+','')
	end
    while b ~= 0 do
    ban = ban:trim()
    ban,b = ban:gsub('^!+','')
	end
    while b ~= 0 do
    filter = filter:trim()
    filter,b = filter:gsub('^!+','')
	end
    while b ~= 0 do
    help = help:trim()
    help,b = help:gsub('^!+','')
	end
    while b ~= 0 do
    lockb = lockb:trim()
    lockb,b = lockb:gsub('^!+','')
	end
    while b ~= 0 do
    rmsg = rmsg:trim()
    rmsg,b = rmsg:gsub('^!+','')
	end
      filec = io.open("./plugins/supergroup.lua", "w")
      filec:write(file)
      filec:flush()
      filec:close()
	  sysc = io.open("./plugins/msg_checks.lua", "w")
      sysc:write(security)
      sysc:flush()
      sysc:close()
                      banc = io.open("./plugins/banhammer.lua", "w")
      banc:write(ban)
      banc:flush()
      banc:close()
                       filterc = io.open("./plugins/filter.lua", "w")
      filterc:write(filter)
      filterc:flush()
      filterc:close()
                       helpc = io.open("./plugins/helpen.lua", "w")
      helpc:write(help)
      helpc:flush()
      helpc:close()
                       lockbc = io.open("./plugins/lock_bots.lua", "w")
      lockbc:write(lockb)
      lockbc:flush()
      lockbc:close()
                       rmsgc = io.open("./plugins/rmsg.lua", "w")
      rmsgc:write(rmsg)
      rmsgc:flush()
      rmsgc:close()
	  reload_plugins( )
      return "<i>💫زبان سوپرگپ با موفقیت به فارسی با دستورات فارسی تغییر کرد💫</i>"
end
end

 if matches[1] == "update" then
  txt = "Updated!"
  send_msg(get_receiver(msg), txt, ok_cb, false)
  return reload_plugins( )
 end
 if matches[1] == "lang" and matches[2] == "list" then
 	return [[
List of language:
 	
⚓️ !setlang en
Change language to English
 		
⚓️ !setlang فا
تغییر زبان به فارسی با دستورات فارسی
]]
end
  elseif not is_sudo(msg) or not is_owner(msg) or not is_admin(msg) or not is_admin2(msg) then
 return "You cant change language!"
end
end
 return {
 advan = {
 "Created by: @vVv_ERPO_vVv",
 "Powered by: @JoveCH",
 "CopyRight all right reserved",
 },
 patterns = {
    "^[!#/](setlang) (fa)$",
	   "^[!#/](setlang) (en)$",
	   "^[!#/](setlang) (فا)$",
	   "^[!#/](lang) (list)$",
	   "^[!#/](update)$",
	   "^(setlang) (en)$",
	   "^(setlang) (فا)$",
	   "^(lang) (list)$",
	   "^(update)$",
 },
 run = run
}