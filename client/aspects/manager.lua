local debug = CG.debug
local heistactive = true
local manager
local mngrped = {
    spawned = false,
    ped = nil
}
local function spawnmanager()
    -- varables for ped
    if heistactive then
        local mngrloc = BK.banks.alta.manager.loc
        local mngr = BK.banks.alta.manager
        local loc = mngrloc[math.random(1, #mngrloc)]
        mngrloc = loc

        -- spawn ped
        local model = lib.requestmodel(joaat(mngr.ped))
        local coords = mngrloc
        local anim = mngr.anim
        local isdead = false
        
        if mngrped.spawned then return 
        else
            manager = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
            TaskStartScenarioInPlace(manager, anim, 0, true)
            FreezeEntityPosition(manager, false)
            SetEntityInvincible(manager, false)
            SetBlockingOfNonTemporaryEvents(manager, false)
            mngr.ped = manager
            mngrped.spawned = true

            local ped_options = {
                {
                    name = 'mngrrob',
                    label = 'Rob for recurity card',
                    icon = 'fa-solid fa-id-card-clip',
                    canInteract = function(_, distance)
                        return distance < 2.5 and not IsEntityDead(manager)
                    end,
                    onSelect = function()
                        local player = GetPlayerPed(source)
                        -- mugging
                        local mugging = lib.requestAnimDict('random@mugging2', 100)
                        local holdgun = lib.requestAnimSet('ig_1_guy_stickup_loop', 100)
                        -- surrendering
                        local surrendering = lib.requestAnimDict('random@arrests', 100)
                        local handsup = lib.requestAnimSet('idle_2_hands_up', 100)
                        if lib.progressBar({
                            duration = 2000,
                            label = 'Robbing',
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                            },
                            anim = {
                                dict = mugging,
                                clip = holdgun
                            },
                        }) then 
                            TaskPlayAnim(manager, surrendering, handsup, 8.0, 1.0, -1, 128, 0, false, false, false)
                        else print('Do stuff when cancelled') end

                        
                        lib.callback('mifh:give:securitycard', false, function(source)
                            Wait(10)
                            exports.ox_target:removeLocalEntity(mngr.ped, { 'mngrdead' })
                        end)
                    end
                },
                {
                    name = 'mngrdead',
                    label = 'Retrieve recurity card',
                    icon = 'fa-solid fa-id-card-clip',
                    canInteract = function(_, distance)
                        return distance < 2.5 and IsEntityDead(manager)
                    end,
                    onSelect = function()
                        lib.callback('mifh:give:securitycard', false, function(source)
                            Wait(10)
                            exports.ox_target:removeLocalEntity(mngr.ped, { 'mngrdead' })
                        end)
                    end
                },
            }
            exports.ox_target:addLocalEntity(mngr.ped, ped_options)
        end
        
        
        -- ped options
        
        
    end
end

AddEventHandler('mifh:mngr:robem', function(ped)
    -- scene variables
    local player = GetPlayerPed(source)
    -- mugging
    local mugging = lib.requestAnimDict('arandom@mugging2', 100)
    local holdgun = lib.requestAnimSet('ig_1_guy_stickup_loop', 100)
    -- surrendering
    local surrendering = lib.requestAnimDict('random@arrests', 100)
    local busted = lib.requestAnimDict('random@arrests@busted', 100)
    local handsup = lib.requestAnimSet('idle_2_hands_up', 100)
    local kneel = lib.requestAnimSet('kneeling_arrest_idle', 100)
    local eneterbust = lib.requestAnimSet('enter', 100)
    local idlebust = lib.requestAnimSet('idle_a', 100)
    -- ped & player details
    local plyrcrd, plyrrot = GetEntityCoords(player), GetEntityRotation(player)
    local pedcrd, pedrot = GetEntityCoords(ped), GetEntityRotation(ped)

    -- start scene
    TaskPlayAnim( player, mugging, holdgun, 8.0, 1.0, -1, 128, 0, false, false, false )
    TaskPlayAnim( ped, surrendering, handsup, 8.0, 1.0, -1, 128, 0, false, false, false )
    Citizen.Wait(10000)



end)

RegisterCommand('mngr', function()
    spawnmanager()
end, false)