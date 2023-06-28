local debug = CG.debug
local Inventory = exports.ox_inventory

lib.callback.register('mifh:give:securitycard', function(source)
    Inventory:AddItem(source, 'bank_case', 1)
end)