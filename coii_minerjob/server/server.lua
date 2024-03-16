ESX = exports["es_extended"]:getSharedObject()

function discordname(source)
    local discord = ""
    local id = ""
    
    if source then
        local identifiers = GetNumPlayerIdentifiers(source)
        for i = 0, identifiers - 1 do
            local identifier = GetPlayerIdentifier(source, i)
            if identifier and string.match(identifier, "discord") then
                discord = identifier
                id = string.sub(discord, 9, -1)
                break
            end
        end
    end

    return "<@" .. id .. ">"
end

RegisterServerEvent("coii:minereward")
AddEventHandler("coii:minereward", function()
    local xPlayer = ESX.GetPlayerFromId(source)

    logs('Miner Job', "**NAME ↴**\n " .. GetPlayerName(source) .. "\n" .. "**IDENTIFIER ↴**\n " .. GetPlayerIdentifier(source) .. "\n" .. "**DISCORD ↴**\n" .. discordname(source) .. "\n" .. "**FINISH ↴**\nSuccessfully mined ore!", 5763719)

    dajitem(xPlayer.source)
    
end)

RegisterServerEvent("buypickaxe")
AddEventHandler("buypickaxe", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local pickcost = 500
    local PlayerMoney = xPlayer.getMoney()

    if PlayerMoney >= pickcost then
    xPlayer.addInventoryItem('pickaxe', 1)
    xPlayer.removeMoney(pickcost)
    else
    TriggerClientEvent("coii:notify", source, "Miner Job", "You don't have enough money! (500$)")
    end
end)

function dajitem(da)
    local d = math.random(0, 100)
    local xPlayer = ESX.GetPlayerFromId(da)

    local items = {
    'ironore',
    'copperore',
    'goldore'
    }

    local randomItem = items[math.random(1, #items)]

    if Config.Debug then print(d) end

    if d <= 55 then
        xPlayer.addInventoryItem('stone', 1)
    elseif d <= 70 then 
        xPlayer.addInventoryItem(randomItem, 1)
    elseif d <= 85 then 
        local uncutgems = {'uncutemerald', 'uncutruby', 'uncutsapphire'}
        local randomgem = uncutgems[math.random(1, #uncutgems)]
        xPlayer.addInventoryItem(randomgem, 1)
    elseif d <= 100 then 
        xPlayer.addInventoryItem('uncutdiamond', 1)
    end
end

function logs(name, message, color, imageUrl)
    local webhookjob = 'https://discord.com/api/webhooks/1216099739456766092/qgSPpsRRl6zp6YwK6-4TT4RSH7v9LevdEb5f9prflqUFSlttXV31HZYUIGdYf4tcJu61'

    if message == nil or message == '' then 
        return false 
    end

    local embed = {
        title = message,
        type = "rich",
        color = color,
        footer = {
            text = "Miner Logs",
            icon_url = "https://i.imgur.com/fRoVDVJ.png",
        },
        thumbnail = {
            url = "https://i.imgur.com/VOjrWND.png",
        },
        author = {
            name = 'Miner Logs',
            icon_url = 'https://i.imgur.com/fRoVDVJ.png',
        },
    }

    local payload = {
        username = name,
        embeds = {embed},
    }

    PerformHttpRequest(webhookjob, function(err, text, headers) end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end


