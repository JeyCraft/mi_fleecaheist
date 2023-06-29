local debug = CG.debug

-- animation variables


-- trolley variables
local vaultaccess = false
local trolly1, trolly2, trolly3
local trollys1 = {
    spawned = false,
    obj = nil
}
local trollys2 = {
    spawned = false,
    obj = nil
}
local trollys3 = {
    spawned = false,
    obj = nil
}


local function spawntrolly1()
    local loc = BK.banks.alta.money.loc
    if vaultaccess then return end
    local model = lib.requestModel(joaat('hei_prop_hei_cash_trolly_01'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameracontrol]
    local coords = loc[1]
    if trollys1.spawned then return end

    trolly1 = CreateObject(
        model, coords.x, coords.y, coords.z-1, 
        true, true, true)
    SetEntityHeading(trolly1, coords.w)
    FreezeEntityPosition(trolly1, true)

    trollys1.obj = trolly1
    

    local pad_options = {
        {
            name = 'flctrolly1',
            label = 'Steal Money',
            icon = 'fa-solid fa-sack-dollar',
            canInteract = function(_, distance)
                return distance < 2.5
            end,
            onSelect = function()
                TriggerEvent('mifh:anim:takemoney', trollys1.obj)
            end
        }
    }
    exports.ox_target:addLocalEntity(trollys1.obj, pad_options)
end

local function spawntrolly2()
    local loc = BK.banks.alta.money.loc
    if vaultaccess then return end
    local model = lib.requestModel(joaat('hei_prop_hei_cash_trolly_01'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameracontrol]
    local coords = loc[2]
    if trollys2.spawned then return end

    trolly2 = CreateObject(
        model, coords.x, coords.y, coords.z-1, 
        true, true, true)
    SetEntityHeading(trolly2, coords.w)
    FreezeEntityPosition(trolly2, true)

    trollys2.obj = trolly2
    

    local pad_options = {
        {
            name = 'flctrolly2',
            label = 'Steal Money',
            icon = 'fa-solid fa-sack-dollar',
            canInteract = function(_, distance)
                return distance < 2.5
            end,
            onSelect = function()
                TriggerEvent('mifh:anim:takemoney', trollys2.obj)
            end
        }
    }
    exports.ox_target:addLocalEntity(trollys2.obj, pad_options)
end

local function spawntrolly3()
    local loc = BK.banks.alta.money.loc
    if vaultaccess then return end
    local model = lib.requestModel(joaat('hei_prop_hei_cash_trolly_01'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameracontrol]
    local coords = loc[3]
    if trollys3.spawned then return end

    trolly3 = CreateObject(
        model, coords.x, coords.y, coords.z-1, 
        true, true, true)
    SetEntityHeading(trolly3, coords.w)
    FreezeEntityPosition(trolly3, true)

    trollys3.obj = trolly3
    

    local pad_options = {
        {
            name = 'flctrolly3',
            label = 'Steal Money',
            icon = 'fa-solid fa-sack-dollar',
            canInteract = function(_, distance)
                return distance < 2.5
            end,
            onSelect = function()
                TriggerEvent('mifh:anim:takemoney', trollys3.obj)
            end
        }
    }
    exports.ox_target:addLocalEntity(trollys3.obj, pad_options)
end

AddEventHandler('mifh:anim:takemoney', function(object)
    local animdict = lib.requestAnimDict('anim@heists@ornate_bank@grab_cash', 100)
    local animplayer = lib.requestAnimSet('grab', 100)
    local animbag = lib.requestAnimSet('bag_grab', 100)
    local animcart = lib.requestAnimSet('cart_cash_dissapear', 100)

    local animdict = 'anim@heists@ornate_bank@grab_cash'
    while not HasAnimDictLoaded(animdict) or HasModelLoaded('hei_p_m_bag_var22_arm_s') do
        RequestAnimDict(animdict)
        RequestModel("hei_p_m_bag_var22_arm_s")
        Citizen.Wait(100)
    end

    local player = PlayerPedId()
    TaskGoStraightToCoord(player, object.x, object.y, object.z, 1.0, 3000, object.w, 1.0)
    Citizen.Wait(1500)

    local playercoord, playerrot = GetEntityCoords(player), GetEntityRotation(player)
    local objcoords = GetEntityCoords(object)
    local animpos = GetAnimInitialOffsetPosition(
        animdict, 'grab', objcoords.x, objcoords.y, objcoords.z, 
        objcoords.x, objcoords.y, objcoords.z, 0, 2)
    local netscene = NetworkCreateSynchronisedScene(
        animpos.x, animpos.y, animpos.z, 
        playerrot.x, playerrot.y, player.z, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 
    playercoord.x, playercoord.y, playercoord.z, true, true, false)

    NetworkAddPedToSynchronisedScene(player, netscene, animdict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netscene, animdict, 'bag_grab', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(object, netscene, animdict, 'cart_cash_dissapear', 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(netscene)
    Citizen.Wait(GetAnimDuration(animdict, "grab") * 1000) -- 47.93 secs
    NetworkStopSynchronisedScene(netscene)
end)

RegisterCommand('trolley', function()
    --[[
    while not HasAnimDictLoaded(animdict) or
        not HasModelLoaded(bagmodel) or
        not HasModelLoaded(trolleymodel) do
        Citizen.Wait(100)
    end
    FreezeEntityPosition(player, true)
    NetworkAddPedToSynchronisedScene(player, netScene, animdict, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
    local bag = CreateObject(bagmodel, playerloc.x, playerloc.y, playerloc.z-1, true, true, false)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animdict, "bag_grab", 4.0, -8.0, 1)
    local trolly = CreateObject(trolleymodel, playerloc.x, playerloc.y, playerloc.z-1, true, true, false)
    NetworkAddEntityToSynchronisedScene(trolly, netScene, animdict, "cart_cash_dissapear", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(netScene)
    Citizen.Wait(GetAnimDuration(animdict, "grab") * 1000) -- 47.93 secs
    NetworkStopSynchronisedScene(netScene)
    DeleteObject(bag)
    DeleteObject(trolly)
    FreezeEntityPosition(player, false)
    ]]
    spawntrolly1()
    spawntrolly2()
    spawntrolly3()
end, false)

