local debug = CG.debug
--local chosenbank = FH.chosenbank
local vault = nil
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
                    TriggerEvent('spawnelectricdrill')
                end
            },
        }
    })
end

AddEventHandler('spawnelectricdrill', function()
    local elecdrill = lib.requestModel(joaat('k4mb1_prop_drill2'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameras]
    local coords = BK.banks.alta.vaultdoor.drill
    if drill.spawned then return end

    local drill = CreateObject(
        elecdrill, coords.x-0.1, coords.y-0.34, coords.z+0.05, 
        true, true, true)
    SetEntityHeading(elecdrill, coords.w)
    FreezeEntityPosition(elecdrill, true)

    drill.obj = elecdrill
    drill.spawned = true
end)


RegisterCommand('bvlt', function()
    spawnvaultzone()
end, false)