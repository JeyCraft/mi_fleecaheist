local debug = CG.debug
--local chosenbank = FH.chosenbank
local allow = CG.options.cameras
local powered = true
local camzone1, camzone2

local camera = {
    spawned = false,
    obj = nil
}
local camerapad = {
    spawned = false,
    obj = nil
}


local function notifylaw()
    -- add export here for police job to show alert
    lib.notify({
        id = 'caught_alert',
        title = CG.notify.title,
        description = CG.notify.description,
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

local function spawncameras()
    if not allow then return end
    local cammodel = lib.requestModel(joaat('v_serv_securitycam_03'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameras]
    local coords = BK.banks.alta.camera
    if camera.spawned then return end

    local camcam = CreateObject(
        cammodel, coords.x-0.1, coords.y-0.34, coords.z+0.05, 
        true, true, true)
    SetEntityHeading(camcam, coords.w)
    FreezeEntityPosition(camcam, true)

    camera.obj = camcam
    camera.spawned = true
end

local function spawncamerazoneoutside()
    if not allow then return end
    if not powered then return end
    local coords = BK.banks.alta.camzoneoutside.loc
    local head = BK.banks.alta.camzoneoutside.head
    local size = BK.banks.alta.camzoneoutside.size
    camzone1 = exports.ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = head,
        debug = debug,
        onEnter = function()
            notifylaw()
        end,
    })
end

local function spawncamerazoneinside()
    if not allow then return end
    if not powered then return end
    local coords = BK.banks.alta.camzoneinside.loc
    local head = BK.banks.alta.camzoneinside.head
    local size = BK.banks.alta.camzoneinside.size
    camzone2 = exports.ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = head,
        debug = debug,
        onEnter = function()
            notifylaw()
        end,
    })
end

local function spawncamerapad()
    if not allow then return end
    local elecpad = lib.requestModel(joaat('ch_prop_ch_fuse_box_01a'))
    -- for testing, changed to alta [BK.banks.chosenbank.cameracontrol]
    local coords = BK.banks.alta.cameracontrol
    if camerapad.spawned then return end

    local campad = CreateObject(
        elecpad, coords.x, coords.y, coords.z, 
        true, true, true)
    SetEntityHeading(campad, coords.w)
    FreezeEntityPosition(campad, true)

    camerapad.obj = campad
    camerapad.spawned = true

    local pad_options = {
        {
            name = 'secpad',
            label = 'Disable camera system',
            icon = 'fa-solid fa-video',
            canInteract = function(_, distance)
                return distance < 2.5 and powered
            end,
            onSelect = function()
                exports.ox_target:removeZone(camzone1)
                exports.ox_target:removeZone(camzone2)
            end
        }
    }
    exports.ox_target:addLocalEntity(camerapad.obj, pad_options)
end


RegisterCommand('bcam', function()
    spawncameras()
    spawncamerapad()
    spawncamerazoneoutside()
    spawncamerazoneinside()
end, false)