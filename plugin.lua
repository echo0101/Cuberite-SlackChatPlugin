cConfig = {
  apiToken = "";
  channel = "";
}

local function isempty(s)
  return s == nil or s == ''
end

function InitializeConfig()
  local ini = cIniFile();
  if (not(ini:ReadFile("SlackChat.ini"))) then
    LOGINFO("SlackChat: Cannot read SlackChat.ini, all plugin configuration is set to defaults.");
  end
  cConfig.apiToken = ini:GetValueSet("SlackChat", "apiToken", "") 
  cConfig.channel = ini:GetValueSet("SlackChat", "channel", "#minecraft") 
  ini:WriteFile("SlackChat.ini");
end

function urlencode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w ])",
    function (c) return string.format ("%%%02X", string.byte(c)) end)
    str = string.gsub (str, " ", "+")
  end
  return str    
end

function Initialize(Plugin)
  Plugin:SetName("SlackChat")
  Plugin:SetVersion(1)

  InitializeConfig()

  cPluginManager.AddHook(cPluginManager.HOOK_CHAT, OnChat)

  LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
  if (isempty(cConfig.apiToken)) then
    LOGWARN("SlackChat: No api token configured! Plugin will not work.")
  end
  return true
end

function SendChat(user, msg)
  if (isempty(cConfig.apiToken)) then
    return
  end
  local baseUrl = "https://slack.com/api/chat.postMessage"
  local avatarBaseUrl = "https://mcapi.ca/avatar/2d/"
  local c = "curl -g \"" .. baseUrl .. "?token=" .. cConfig.apiToken .. "&channel=" .. urlencode(cConfig.channel) .. "&text=" .. urlencode(msg) .. "&as_user=false&username=" .. urlencode(user)  .. "&icon_url=" .. urlencode(avatarBaseUrl .. user) .. "\""
  local t = os.execute(c)
  return false
end

function OnChat(Player, Message)
  SendChat(Player:GetName(), StripColorCodes(Message))
  return false
end
