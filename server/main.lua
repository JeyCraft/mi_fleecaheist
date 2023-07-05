local debug = CG.debug
local Inventory = exports.ox_inventory

lib.callback.register('mifh:give:securitycard', function(source)
    Inventory:AddItem(source, BK.banks.key, 1)
end)

lib.callback.register('mifh:give:moneybag', function(source)
    Inventory:AddItem(source, BK.banks.money, 1)
end)

lib.callback.register('mifh:remove:drill', function(source)
    Inventory:RemoveItem(source, BK.banks.drill, 1)
end)

lib.callback.register('mifh:remove:key', function(source)
    Inventory:RemoveItem(source, BK.banks.key, 1)
end)