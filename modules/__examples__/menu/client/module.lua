-- Copyright (c) Jérémie N'gadi
--
-- All rights reserved.
--
-- Even if 'All rights reserved' is very clear :
--
--   You shall not use any piece of this software in a commercial product / service
--   You shall not resell this software
--   You shall not provide any facility to install this particular software in a commercial product / service
--   If you redistribute this software, you must link to ORIGINAL repository at https://github.com/ESX-Org/es_extended
--   This copyright should appear in every part of the project code

-- The module file contains every module specific methods
local utils = M("utils")

module.onNuiReady = function()
    -- we instanciate a new menu with name ' test_menu ' and title ' Test Menu '
    module.menu = Menu('test_menu', {
        title = 'Test menu',
        float = 'top|left', -- not needed, default value
        items = {
            {name = 'superSlider', label = 'Slide me, indeed, I\'m a slider', type = 'slider'},
            {name = 'superChecker', label = 'Ready to check this one ?', type = 'check'},
            {name = 'superText', label = 'It could be a super long text, maybe', type = 'text'},
            {name = 'superSecretBind', label = 'I\'m changing if you type upper and check the box', type = 'text'},
            {name = 'superDefaultType', label = 'What\'s my type'}, -- type will be default
            {name = 'superColor', label = 'What fancy color ?', type = 'color'},
            {name = 'superSumbitButton', label = '>> Submit <<', type = 'button'}
        }
    })

    -- Menu events
    module.menu:on('ready', module.onMenuReady)
    -- bind item change with module specific method onItemChanged
    module.menu:on('item.change', module.onItemChanged)
    -- bind item click with module specific method onItemClicked
    module.menu:on('item.click', module.onItemClicked)
end

module.onMenuReady = function()
  -- data binding with the DOM
  module.menu.items[1].label = 'TEST';
end

module.onItemChanged = function(item, prop, val, index)

    if (item.name == 'superSlider') and (prop == 'value') then
        item.label = 'Dynamic label ' .. tostring(val)
    end

    if (item.name == 'superChecker') and (prop == 'value') then
        
        -- util function to get items table with key "name" and value "value" (of the input)
        local itemsValues = module.menu:kvp('name', 'value')

        -- print(utils.table.dump(itemsValues))

        -- get the value of the superText input
        local textItemValue = itemsValues['superText']
        
        -- change the superSecretBind value based on what superText value is
        module.menu.items[4].value = 'Dynamic text ' .. tostring(textItemValue);
    end

end

module.onItemClicked = function(item, index)
  print('index', index)
end
