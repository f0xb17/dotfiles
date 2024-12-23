local awful = require("awful")

local client_module = {}

function client_module.focus_app(app_name)
    local clients = client.get()
    local found_client = nil

    for _, c in ipairs(clients) do
        if c.class:lower() == app_name:lower() then
            found_client = c
            break
        end
    end

    if found_client then
        client.focus = found_client
        found_client:raise()
        awful.screen.focus(found_client.screen)
        awful.tag.viewonly(found_client.first_tag)
    else
        awful.spawn(app_name)
    end
end

return client_module
