local debug = CG.debug
local heistactive = true
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
            local ped = CreatePed(1, model, coords.x, coords.y, coords.z-1, coords.w, false, false)
            TaskStartScenarioInPlace(ped, anim, 0, true)
            FreezeEntityPosition(ped, false)
            SetEntityInvincible(ped, false)
            SetBlockingOfNonTemporaryEvents(ped, false)
            mngr.ped = ped
            mngrped.spawned = true

            local ped_options = {
                {
                    name = 'mngrrob',
                    label = 'Rob for recurity card',
                    icon = 'fa-solid fa-id-card-clip',
                    canInteract = function(_, distance)
                        return distance < 2.5 and not IsEntityDead(ped)
                    end,
                    onSelect = function()
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
                        return distance < 2.5 and IsEntityDead(ped)
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

RegisterCommand('mngr', function()
    spawnmanager()
end, false)