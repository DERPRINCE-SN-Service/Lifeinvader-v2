ESX = exports["es_extended"].getSharedObject()

local logo = [===[^1
  ______  _   __        __     _  ____       ____                         __           
 / ____/ / | / /       / /    (_)/ __/___   /  _/____  _   __ ____ _ ____/ /___   _____
 \___ \ /  |/ /______ / /    / // /_ / _ \  / / / __ \| | / // __ `// __  // _ \ / ___/
 ___/ // /|  //_____// /___ / // __//  __/_/ / / / / /| |/ // /_/ // /_/ //  __// /
/____//_/ |_/       /_____//_//_/   \___//___//_/ /_/ |___/ \__,_/ \__,_/ \___//_/
^0

^2SN-Info^0 >>> ^1LifeInvader ^2v2^0 - ^1Better than ever! ^0]===]

print(logo)

local lastAdDate 			   = 0

function sendToDiscord(color, name, title, fieldTextName, fieldTextAd, footer)
	local connect = {
		{
			["title"] = title,
			["thumbnail"] = {
				["url"] = Config.Discord.thumb_url
			},
			["color"] = color,
			
			["fields"] = {
				{
					["name"] = "Name",
					["value"] = fieldTextName
				},
				{
					["name"] = "Werbungsinhalt",
					["value"] = fieldTextAd
				}
			},
			["footer"] = {
				["text"] = footer, 
				["icon_url"] = Config.Discord.icon_url
			}
		}
	}
	PerformHttpRequest(Config.Webhook.link, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = connect}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("SyncWerbung")
AddEventHandler('SyncWerbung', function(inputText)
	if os.time(os.date("!*t")) > (lastAdDate + Config.Time) then
		lastAdDate = os.time(os.date("!*t"))
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source) 
		if xPlayer == nil then
			name = "Test per TX-Admin" 
		else
			name = _source
		end
		TriggerClientEvent('DisplayWerbung', -1, inputText, name)
		if Config.Webhook.enable then
			local tag = os.date("%d.%m.%Y %X")

			sendToDiscord(16711680, "News", "LiveInvader", name, "```"..inputText.."```", "Werbung geschalten am "..tag)
		end
		if xPlayer ~= nil then
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeMoney(Config.Price)
		end
	else
		TriggerClientEvent('FehlerWerbung', source, "In den letzten 10 Minuten wurde bereits Werbung geschaltet.")
	end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

RegisterCommand("liveinvader", function(source, args, rawCommand)
	rstring = json.decode(json.encode(stringsplit(rawCommand, " ")))[2]
	TriggerEvent("SyncWerbung", rstring)
end)