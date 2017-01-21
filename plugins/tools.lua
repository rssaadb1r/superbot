--Begin Tools.lua :)
local function index_function(user_id)
  for k,v in pairs(_config.admins) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end

local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

local function sudolist(msg)
local sudo_users = _config.sudo_users
local text = "*List of sudo users :*\n"
for i=1,#sudo_users do
    text = text..i.." - "..sudo_users[i].."\n"
end
return text
end

local function adminlist(msg)
		  	local text = '*List of bot admins :*\n'
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..'- '..(user[2] or '')..' ➣ ('..user[1]..')\n'
		  	i = i +1
		  	end
		  	if compare == text then
		  		text = '_No_ *admins* _available_'
		  	end
		  	return text
    end

local function action_by_reply(arg, data)
    local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
    if cmd == "adminprom" then
local function adminprom_cb(arg, data)
if data.username_ and not data.username_:match("_") then
user_name = '@'..data.username_
else
user_name = data.first_name_
end
if is_admin1(tonumber(data.id_)) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, adminprom_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "admindem" then
local function admindem_cb(arg, data)
	local nameid = index_function(tonumber(data.id_))
if data.username_ and not data.username_:match("_") then
user_name = '@'..data.username_
else
user_name = data.first_name_
end
if not is_admin1(data.id_) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   end
		table.remove(_config.admins, nameid)
		save_config()
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, admindem_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "visudo" then
local function visudo_cb(arg, data)
if data.username_ and not data.username_:match("_") then
user_name = '@'..data.username_
else
user_name = data.first_name_
end
if already_sudo(tonumber(data.id_)) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "desudo" then
local function desudo_cb(arg, data)
if data.username_ and not data.username_:match("_") then
user_name = '@'..data.username_
else
user_name = data.first_name_
end
     if not already_sudo(data.id_) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
end

local function action_by_username(arg, data)
    local cmd = arg.cmd
if data.type_.user_.username_ and not data.type_.user_.username_:match("_") then
user_name = '@'..data.type_.user_.username_
else
user_name = data.title_
end
if not arg.username then return false end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
end
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   end
		table.remove(_config.admins, nameid)
		save_config()
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
  end
end

local function action_by_id(arg, data)
    local cmd = arg.cmd
if data.username_ and not data.username_:match("_") then
user_name = '@'..data.username_
else
user_name = data.first_name_
end
if not tonumber(arg.user_id) then return false end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
end
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   end
		table.remove(_config.admins, nameid)
		save_config()
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
  end
end

local function run(msg, matches)
 if tonumber(msg.sender_user_id_) == 157059515 then --Put Your ID
if matches[1] == "visudo" then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="visudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="visudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="visudo"})
      end
   end
if matches[1] == "desudo" then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="desudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="desudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="desudo"})
      end
   end
end
if matches[1] == "adminprom" and is_sudo(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="adminprom"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="adminprom"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="adminprom"})
      end
   end
if matches[1] == "admindem" and is_sudo(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="admindem"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="admindem"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="admindem"})
      end
   end


if matches[1] == 'creategroup' and is_admin(msg) then
local text = matches[2]
tdcli.createNewGroupChat({[0] = msg.sender_user_id_}, text)
return '_Group Has Been Created!_'
end

if matches[1] == 'createsuper' and is_admin(msg) then
local text = matches[2]
tdcli.createNewChannelChat({[0] = msg.sender_user_id_}, text)
return '_SuperGroup Has Been Created!_'
end

if matches[1] == 'tosuper' and is_admin(msg) then
local id = msg.chat_id_
tdcli.migrateGroupChatToChannelChat(id)
return '_Group Has Been Changed To SuperGroup!_'
end

if matches[1] == 'import' and is_admin(msg) then
tdcli.importChatInviteLink(matches[2])
return '*Done!*'
end

if matches[1] == 'setbotname' and is_sudo(msg) then
tdcli.changeName(matches[2])
return '_Bot Name Changed To:_ *'..matches[2]..'*'
end

if matches[1] == 'setbotusername' and is_sudo(msg) then
tdcli.changeUsername(matches[2])
return '_Bot Username Changed To:_ *@'..matches[2]..'*'
end

if matches[1] == 'delbotusername' and is_sudo(msg) then
tdcli.changeUsername('')
return '*Done!*'
end

if matches[1] == 'markread' then
if matches[2] == 'on' then
redis:set('markread','on')
return '_Markread >_ *ON*'
end
if matches[2] == 'off' then
redis:set('markread','off')
return '_Markread >_ *OFF*'
end
end

if matches[1] == 'sudolist' and is_sudo(msg) then
return sudolist(msg)
    end
if matches[1] == 'botnet' then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 1, _config.info_text, 1, 'html')
    end
if matches[1] == 'adminlist' and is_admin(msg) then
return adminlist(msg)
    end
     if matches[1] == 'leave' and is_admin(msg) then
  tdcli.changeChatMemberStatus(chat, our_id, 'Left')
   end
     if matches[1] == 'autoleave' and is_admin(msg) then
local hash = 'auto_leave_bot'
--Enable Auto Leave
     if matches[2] == 'enable' then
    redis:del(hash)
   return '_Auto leave has been_ *enabled*'
--Disable Auto Leave
     elseif matches[2] == 'disable' then
    redis:set(hash, true)
   return '_Auto leave has been_ *disabled*'
--Auto Leave Status
      elseif matches[2] == 'status' then
      if not redis:get(hash) then
   return '_Auto leave is_ *enable*'
       else
   return '_Auto leave is_ *disable*'
         end
      end
   end
end
return { 
patterns = { 
"^[!/#](visudo)$", 
"^[!/#](desudo)$",
"^[!/#](sudolist)$",
"^[!/#](visudo) (.*)$", 
"^[!/#](desudo) (.*)$",
"^[!/#](adminprom)$", 
"^[!/#](admindem)$",
"^[!/#](adminlist)$",
"^[!/#](adminprom) (.*)$", 
"^[!/#](admindem) (.*)$",
"^[!/#](leave)$",
"^[!/#](autoleave) (.*)$", 
"^[!/#](botnet)$",
"^[!/#](creategroup) (.*)$",
"^[!/#](createsuper) (.*)$",
"^[!/#](tosuper)$",
"^[!/#](import) (.*)$",
"^[!/#](setbotname) (.*)$",
"^[!/#](setbotusername) (.*)$",
"^[!/#](delbotusername) (.*)$",
"^[!/#](markread) (.*)$",
}, 
run = run 
}
