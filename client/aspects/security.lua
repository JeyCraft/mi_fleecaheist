local debug = CG.debug
--local chosenbank = FH.chosenbank

local function spawnsecpadzone()
    local coords = BK.banks.alta.secsystem.loc
    local head = BK.banks.alta.secsystem.head
    local size = BK.banks.alta.secsystem.size
    exports.ox_target:addBoxZone({
        coords = coords,
        size = size,
        rotation = head,
        debug = debug,
        options = {
            {
                name = 'secpad_hack',
                icon = 'fa-solid fa-laptop-file',
                label = 'Hack Securitypad',
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
                name = 'secpad_card',
                icon = 'fa-solid fa-id-card-clip',
                label = 'Use Manager\'s card',
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
        }
    })
end

RegisterCommand('bsec', function()
    spawnsecpadzone()
end, false)