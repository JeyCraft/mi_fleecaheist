local debug = CG.debug
--local chosenbank = FH.chosenbank
local hacked = false
local failed = false
local vaultopen = false
local vaultmoving = false

local function cooldown()
end

local function hackpad()
    if hacked == true then return end
    if not hacked then
        local success = lib.skillCheck({'medium', 'medium', 'hard'}, {'q', 'w', 'e'})
        if success then 
            hacked = true
            vaultmoving = true
            TriggerEvent('openvault')
            TriggerEvent('mifh:vault:trollys')
            Wait(20000)
            vaultmoving = false
            vaultopen = true
        else
            hacked = false
            failed = true
            
        end
    end
end

local function spawnsecpadzone1()
    local coords = BK.banks.alta.secsystemoutside.loc
    local head = BK.banks.alta.secsystemoutside.head
    local size = BK.banks.alta.secsystemoutside.size
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
                items = 'card_flcamnger',
                canInteract = function(_, distance)
                    return distance < 2.0 and not hacked
                end,
                onSelect = function()
                    vaultmoving = true
                    TriggerEvent('openvault')
                    TriggerEvent('mifh:vault:trollys')
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
                    TriggerEvent('openvault')
                    TriggerEvent('mifh:vault:trollys')
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
                    TriggerEvent('closevault')
                    Wait(20000)
                    vaultmoving = false
                    vaultopen = false
                end
            },
        }
    })
end

local function spawnsecpadzone2()
    local coords = BK.banks.alta.secsysteminside.loc
    local head = BK.banks.alta.secsysteminside.head
    local size = BK.banks.alta.secsysteminside.size
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
                    TriggerEvent('openvault')
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
                    TriggerEvent('closevault')
                    Wait(20000)
                    vaultmoving = false
                    vaultopen = false
                end
            },
        }
    })
end

RegisterCommand('bsec', function()
    spawnsecpadzone1()
    spawnsecpadzone2()
end, false)