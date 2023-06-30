local debug = CG.debug
local resourceName = GetCurrentResourceName()
FH = {}
FH.chosenbank = nil
FH.inprogress = false
local bank = BK.banks

local function heiststartloc()
    exports.ox_target:addBoxZone({
        coords = CG.start.loc,
        size = CG.start.size,
        rotation = CG.start.head,
        debug = CG.debug,
        options = {
            {
                name = 'fleecastart',
                icon = 'fa-solid fa-ticket',
                label = 'Pick bank location',
                canInteract = function(_, distance)
                    return distance < 2.0 and not prog
                end,
                onSelect = function()
                    lib.showContext('fleecaheist_menu')
                    
                end,
            },
        }

    })
end


lib.registerContext({
    id = 'fleecaheist_menu',
    title = 'Darkweb: Fleeca Heist Plan',
    options = {
        {
            title = 'Fleeca: location #1',
            description = 'Los Santos, Alta St & Harwick Ave',
            icon = 'piggy-bank',
            onSelect = function()
                FH.inprogress = true
                FH.chosenbank = BK.banks.alta
                TriggerEvent('mifh:start:cameras', FH.chosenbank)
                TriggerEvent('mifh:start:mngr', FH.chosenbank)
                TriggerEvent('mifh:start:security', FH.chosenbank)
                TriggerEvent('mifh:start:vault', FH.chosenbank)
                TriggerEvent('mifh:start:trollys', FH.chosenbank)
            end,
        },
        {
            title = 'Fleeca: location #2',
            description = 'Los Santos, Mission Row & Straberry Ave',
            icon = 'piggy-bank',
            onSelect = function()
                FH.inprogress = true
                FH.chosenbank = BK.banks.legion
                TriggerEvent('mifh:start:cameras', FH.chosenbank)
                TriggerEvent('mifh:start:mngr', FH.chosenbank)
                TriggerEvent('mifh:start:security', FH.chosenbank)
                TriggerEvent('mifh:start:vault', FH.chosenbank)
                TriggerEvent('mifh:start:trollys', FH.chosenbank)
            end,
        },
        {
            title = 'Fleeca: location #3',
            description = 'Los Santos, Burton St & San Vitus Blvd',
            icon = 'piggy-bank',
            onSelect = function()
                FH.inprogress = true
                FH.chosenbank = BK.banks.legion
                TriggerEvent('mifh:start:cameras', FH.chosenbank)
                TriggerEvent('mifh:start:mngr', FH.chosenbank)
                TriggerEvent('mifh:start:security', FH.chosenbank)
                TriggerEvent('mifh:start:vault', FH.chosenbank)
                TriggerEvent('mifh:start:trollys', FH.chosenbank)
            end,
        },
      
    }
  })

Citizen.CreateThread(function()
    if resourceName == GetCurrentResourceName() then
        if not FH.inprogress then
            heiststartloc()
        else
            return end
        Citizen.Wait(1000)
    end
end)