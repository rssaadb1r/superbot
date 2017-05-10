do
local function pre_process(msg)
 local hash = 'muteall:'..msg.to.id
  if redis:get(hash) and msg.to.type == 'channel' and not is_mod(msg)  then
    tdcli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
       end
    return msg
 end
 
local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if matches[1] == 'mute' and matches[2] == 'all' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             return "mute all has been enabled"
 else
local hour = string.gsub(matches[3], 'h', '')
local num1 = tonumber(hour) * 3600
local minutes = string.gsub(matches[4], 'm', '')
local num2 = tonumber(minutes) * 60
local second = string.gsub(matches[5], 's', '')
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[3].."\n⏺ minutes : "..matches[4].."\n⏺ seconds : "..matches[5].."\n@BeyondTeam"
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[3].."\n⏺ دقیقه : "..matches[4].."\n⏺ ثانیه : "..matches[5].."\n@BeyondTeam"
 end
 end
 end
 if matches[1] == 'mute' and matches[2] == 'hours' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             return "mute all has been enabled"
 else
local hour = string.gsub(matches[3], 'h', '')
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[3].."\n@BeyondTeam"
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[3].."\n@BeyondTeam"
 end
 end
 end
  if matches[1] == 'mute' and matches[2] == 'minutes' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             return "mute all has been enabled"
 else
local minutes = string.gsub(matches[3], 'm', '')
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ minutes : "..matches[3].."\n@BeyondTeam"
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ دقیقه : "..matches[3].."\n@BeyondTeam"
 end
 end
 end
  if matches[1] == 'mute' and matches[2] == 'seconds' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             return "mute all has been enabled"
 else
local second = string.gsub(matches[3], 's', '')
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "Mute all has been enabled for \n⏺ seconds : "..matches[3].."\n@BeyondTeam"
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ثانیه : "..matches[3].."\n@BeyondTeam"
 end
 end
 end
if matches[1] == 'helpmute' then
if not lang then
text = [[
* اوامر كتم الصوت المؤقت:*

*!mute all* `(ساعات) (دقائق) (ثواني)`
_اوامر كتم الصوت في وقت محدد_ 
*!mute hours* `(العدد)`
_يمكنك الكتم لعدد من الساعات_ 
*!mute minute* `(العدد)`
_يمكنك الكتم لعدة دقائق_
*!mute seconds* `(العدد)`
_يمكنك الكتم ايضا لعدة ثواني_ 
*!unmute all*
_الغاء كتم الكل _ 
_يمكنك استخدام [!/#] في بداية الامر _

* مع تحياتي =>> @saad7m*
]]
elseif lang then
text = [[
* اوامر كتم الصوت المؤقت:*

*!mute all* `(ساعات) (دقائق) (ثواني)`
_اوامر كتم الصوت في وقت محدد_ 
*!mute hours* `(العدد)`
_يمكنك الكتم لعدد من الساعات_ 
*!mute minute* `(العدد)`
_يمكنك الكتم لعدة دقائق_
*!mute seconds* `(العدد)`
_يمكنك الكتم ايضا لعدة ثواني_ 
*!unmute all*
_الغاء كتم الكل _ 
_يمكنك استخدام [!/#] في بداية الامر _

* مع تحياتي =>> @saad7m*
]]
end
return text
end
if matches[1] == 'unmute' and matches[2] == 'all' and is_mod(msg) then
               local hash = 'muteall:'..msg.to.id
        redis:del(hash)
		if not lang then
          return "mute all has been disabled"
		  elseif lang then
		  return "گروه ازاد شد و افراد می توانند دوباره پست بگذارند"
  end
end
end
return {
   patterns = {
 "^[!/#]([Uu]nmute) (all)$",
"^[!/#]([Hh]elpmute)$",
"^[!/#]([Mm]ute) (all) (.*) (.*) (.*)$",
"^[!/#]([Mm]ute) (hours) (.*)$",
"^[!/#]([Mm]ute) (minutes) (.*)$",
"^[!/#]([Mm]ute) (seconds) (.*)$",
 },
run = run,
pre_process = pre_process
}
end
--by @BeyondTeam
