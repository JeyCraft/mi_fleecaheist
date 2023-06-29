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

local function setanimdict(dict)
    while (not HasAnimDictLoaded(dict) ) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

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
    
end)

--[[
    "anim@heists@ornate_bank@grab_cash", "intro"
    "anim@heists@ornate_bank@grab_cash", "bag_intro"
    "anim@heists@ornate_bank@grab_cash", "grab"
    "anim@heists@ornate_bank@grab_cash", "bag_grab"
    "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear"
    "anim@heists@ornate_bank@grab_cash", "exit"
    "anim@heists@ornate_bank@grab_cash", "bag_exit"
]]



RegisterCommand('anim', function()
    -- data
    local player = GetPlayerPed(-1)
    local plyrcrd, plyrrot = GetEntityCoords(player), GetEntityRotation(player)
    -- anims
    local bag = lib.requestModel('hei_p_m_bag_var22_arm_s', 100)
    local trolly = lib.requestModel('hei_prop_hei_cash_trolly_01', 100)
    local grabcash = lib.requestAnimDict('anim@heists@ornate_bank@grab_cash', 100)
    -- models
    local mod_bag = CreateObject(bag, plyrcrd.x, plyrcrd.y, plyrcrd.z, true, true, false)
    local mod_trolly = CreateObject(trolly, plyrcrd.x, plyrcrd.y, plyrcrd.z, true, true, false)
    -- netscene
    local netscene = NetworkCreateSynchronisedScene(
        plyrcrd.x, plyrcrd.y, plyrcrd.z-0.52, 
        plyrrot.x, plyrrot.y, plyrrot.z, 
        2, false, false, 1065353216, 0, 1.3)
    -- add to netscene
    FreezeEntityPosition(player, true)
    NetworkAddPedToSynchronisedScene(player, netscene, grabcash, "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(mod_bag, netscene, grabcash, "bag_grab", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(mod_trolly, netscene, grabcash, "cart_cash_dissapear", 4.0, -8.0, 1)
    -- start scene
    NetworkStartSynchronisedScene(netscene)
    Citizen.Wait(37000) -- 47.93 secs
    NetworkStopSynchronisedScene(netscene)
    DeleteObject(mod_bag)
    DeleteObject(mod_trolly)
    FreezeEntityPosition(player, false)

end, false)

