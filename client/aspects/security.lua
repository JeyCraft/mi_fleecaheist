local debug = CG.debug
--local chosenbank = FH.chosenbank
local hacked = false
local failed = false
local vaultopen = false
local vaultmoving = false


local function hackpad()
    if hacked == true then return end
    if not hacked then
        local success = lib.skillCheck({'easy', 'easy', 'medium'}, {'q', 'w', 'e'})
        if success then 
            hacked = true
            Wait(20000)
            vaultmoving = false
        else
            hacked = false
            failed = true
            
        end
    end
end

local function spawnsecpadzone1(choice)
    local coords = choice.secsystemoutside.loc
    local head = choice.secsystemoutside.head
    local size = choice.secsystemoutside.size
    exports.ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = head,
        debug = debug,
        options = {
            {
                name = 'secpad_hack1',
                icon = 'fa-solid fa-laptop-file',
                label = 'Hack Securitypad',
                canInteract = function(_, distance)
                    return distance < 2.0 and not hacked and not failed
                end,
                onSelect = function()
                    hackpad()
                end
            },
            {
                name = 'secpad_card1',
                icon = 'fa-solid fa-id-card-clip',
                label = 'Use keycard',
                items = BK.banks.key,
                canInteract = function(_, distance)
                    return distance < 2.0 and not hacked
                end,
                onSelect = function()
                    vaultmoving = true
                    TriggerEvent('openvault', choice)
                    Wait(20000)
                    vaultmoving = false
                    vaultopen = true
                end
            },

            {
                name = 'secpad_vltopen1',
                icon = 'fa-solid fa-door-open',
                label = 'Open Vault',
                canInteract = function(_, distance)
                    return distance < 2.0 and hacked and not vaultmoving and not vaultopen
                end,
                onSelect = function()
                    vaultmoving = true
                    TriggerEvent('openvault', choice)
                    Wait(20000)
                    vaultmoving = false
                    vaultopen = true
                end
            },
            {
                name = 'secpad_vltclose1',
                icon = 'fa-solid fa-door-closed',
                label = 'Close Vault',
                canInteract = function(_, distance)
                    return distance < 2.0 and hacked and not vaultmoving and vaultopen
                end,
                onSelect = function()
                    vaultmoving = true
                    TriggerEvent('closevault', choice)
                    Wait(20000)
                    vaultmoving = false
                    vaultopen = false
                end
            },
        }
    })
end

local function spawnsecpadzone2(choice)
    local coords = choice.secsysteminside.loc
    local head = choice.secsysteminside.head
    local size = choice.secsysteminside.size
    exports.ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = head,
        debug = debug,
        options = {
            {
                name = 'secpad_vltopen2',
                icon = 'fa-solid fa-door-open',
                label = 'Open Vault',
                canInteract = function(_, distance)
                    return distance < 2.0 and hacked and not vaultmoving and not vaultopen
                end,
                onSelect = function()
                    vaultmoving = true
                    TriggerEvent('openvault', choice)
                    Wait(20000)
                    vaultmoving = false
                    vaultopen = true
                end
            },
            {
                name = 'secpad_vltclose2',
                icon = 'fa-solid fa-door-closed',
                label = 'Close Vault',
                canInteract = function(_, distance)
                    return distance < 2.0 and hacked and not vaultmoving and vaultopen
                end,
                onSelect = function()
                    vaultmoving = true
                    TriggerEvent('closevault', choice)
                    Wait(20000)
                    vaultmoving = false
                    vaultopen = false
                end
            },
        }
    })
end

AddEventHandler('mifh:start:security', function(choice)
    spawnsecpadzone1(choice)
    spawnsecpadzone2(choice)
end)

RegisterCommand('bsec', function(choice)
    choice = BK.debug
    spawnsecpadzone1(choice)
    spawnsecpadzone2(choice)
end, false)