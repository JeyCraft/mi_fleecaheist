local debug = CG.debug
--local chosenbank = FH.chosenbank
local vault = BK.banks.alta.vaultdoor
local door = nil
local drill = {
    spawned = false,
    obj = nil
}

local function spawnvaultzone()
    local coords = BK.banks.alta.vaultdoor.loc
    local head = BK.banks.alta.vaultdoor.head
    local size = BK.banks.alta.vaultdoor.size
    exports.ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = head,
        debug = debug,
        options = {
            {
                name = 'vault_thermal',
                icon = 'fa-solid fa-temperature-high',
                label = 'Use thermal drill',
                canInteract = function(_, distance)
                    return distance < 2.0
                end,
                onSelect = function()
                    lib.notify({
                        id = 'caught_alert',
                        title = 'You did a hack',
                        description = 'good job criminal guy',
                        position = CG.notify.position,
                        style = {
                            backgroundColor = CG.notify.background,
                            color = CG.notify.textcolor,
                            ['.description'] = {
                                color = CG.notify.desccolor
                            }
                        },
                        icon = CG.notify.icon,
                        iconColor = CG.notify.iconcolor
                    })
                end
            },
            {
                name = 'vault_electric',
                icon = 'fa-solid fa-bolt',
                label = 'Use electric drill',
                canInteract = function(_, distance)
                    return distance < 2.0
                end,
                onSelect = function()
                    --TriggerEvent('spawnelectricdrill')
                end
            },
        }
    })
end

AddEventHandler('spawnelectricdrill', function()
    local elecdrill = lib.requestModel(joaat('k4mb1_prop_drill2'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameras]
    local coords = BK.banks.alta.vaultdoor.drill
    local head = BK.banks.alta.vaultdoor.drillhead
    if drill.spawned then return end

    local tool = CreateObject(
        elecdrill, coords.x, coords.y, coords.z, 
        true, true, true)
    SetEntityHeading(tool, head)
    FreezeEntityPosition(tool, true)

    drill.obj = elecdrill
    drill.spawned = true
end)

AddEventHandler('spawnthermaldrill', function()
    local thermdrill = lib.requestModel(joaat('k4mb1_prop_thermaldrill'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameras]
    local coords = BK.banks.alta.vaultdoor.drill
    local head = BK.banks.alta.vaultdoor.drillhead
    if drill.spawned then return end

    local tool = CreateObject(
        thermdrill, coords.x-0.34, coords.y, coords.z-0.4, 
        true, true, true)
    SetEntityHeading(tool, head)
    FreezeEntityPosition(tool, true)

    drill.obj = tool
    drill.spawned = true
end)

AddEventHandler('openvault', function()
    local location = vault.loc
    door = GetClosestObjectOfType(location.x, location.y, location.z, 10, vault.hash, false, false, false)
    SetEntityHeading(door, vault.head)
    local headstart = vault.head
    local headend = vault.headend
    if headstart ~= headend then
        while headstart ~= headend do
            Wait(1)
            SetEntityHeading(door, headstart -1)
            headstart = GetEntityHeading(door)
        end
        SetEntityHeading(door, headend)
    end
end)

RegisterCommand('bvlt', function()
    spawnvaultzone()
    TriggerEvent('spawnthermaldrill')
    Wait(5000)
    DeleteEntity(drill.obj)
    drill.obj = nil
    drill.spawned = false
end, false)

RegisterCommand('bdoor', function()
    TriggerEvent('openvault')
end, false)