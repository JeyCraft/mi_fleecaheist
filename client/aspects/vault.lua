local debug = CG.debug
--local chosenbank = FH.chosenbank
local door = nil
local drilled = false
local vaultopen = false
local drillt = {
    spawned = false,
    obj = nil
}
local vaultset


local function spawnvaultzone(choice)
    local coords = choice.vaultdoor.loc
    local head = choice.vaultdoor.head
    local size = choice.vaultdoor.size
    vaultset = exports.ox_target:addBoxZone({
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
                    return distance < 2.0 and not vaultopen and not drilled
                end,
                onSelect = function()
                    TriggerEvent('spawnthermaldrill', choice)
                    TriggerEvent('spawnthermaleffects', choice)
                    drilled = true
                    Wait(5000)
                    DeleteEntity(drillt.obj)
                    drillt.obj = nil
                    drillt.spawned = false
                    vaultopen = true
                    TriggerEvent('openvault', choice)
                end
            },
        }
    })
end

AddEventHandler('spawnthermaleffects', function(choice)
    local fxdict = 'des_bigjobdrill'
    local fxname = 'ent_ray_big_drill_loop'
    Citizen.CreateThread(function()
        lib.requestNamedPtfxAsset(fxdict, 250)
        while not HasNamedPtfxAssetLoaded(fxdict) do
            Citizen.Wait(10)
        end
        local coords = (choice.vaultdoor.head)
        local v = 0
        while v < 25 do
            UseParticleFxAsset(fxdict)
            StartParticleFxLoopedAtCoord(fxname, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, false, false, false, false)
            v = v+1
            Citizen.Wait(500)
        end
    end)

end)

AddEventHandler('spawnthermaldrill', function(choice)
    local thermdrill = lib.requestModel(joaat('k4mb1_prop_thermaldrill'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameras]
    local coords = choice.vaultdoor.drill
    local head = choice.vaultdoor.drillhead
    if drillt.spawned then return end

    local toolt = CreateObject(
        thermdrill, coords.x-0.34, coords.y, coords.z-0.4, 
        true, true, true)
    SetEntityHeading(toolt, head)
    FreezeEntityPosition(toolt, true)

    drillt.obj = toolt
    drillt.spawned = true
end)

AddEventHandler('openvault', function(choice)
    local vault = choice.vaultdoor
    door = vault.loc
    local obj = GetClosestObjectOfType(door.x, door.y, door.z, 10, vault.hash, false, false, false)
    local count = 0
    SetEntityHeading(obj, vault.head)
    repeat
        local rotation = GetEntityHeading(obj) - 0.05
        SetEntityHeading(obj, rotation)
        count = count + 1
        Wait(1)
    until count == 2000
    FreezeEntityPosition(obj, true)
end)

AddEventHandler('closevault', function(choice)
    local vault = choice.vaultdoor
    door = vault.loc
    local obj = GetClosestObjectOfType(door.x, door.y, door.z, 10, vault.hash, false, false, false)
    local count = 0
    SetEntityHeading(obj, vault.headend)
    repeat
        local rotation = GetEntityHeading(obj) + 0.05
        SetEntityHeading(obj, rotation)
        count = count + 1
        Wait(1)
    until count == 2000
    FreezeEntityPosition(obj, true)
end)

AddEventHandler('mifh:start:vault', function(choice)
    spawnvaultzone(choice)
end)

AddEventHandler('mifh:reset:vault', function(choice)
    choice = choice
    exports.ox_target:removeZone(vaultset)
end)