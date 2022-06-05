command_list = {
    {
        command_name = "/decornmore_info",
        command_script = "decornmore_command",
        mod_id = MOD_NAME,
        desc = "Get Info about " .. MOD_TITLE,
        parameters = "",
        parameters_desc = ""
    },
    {
        command_name = "/mg",
        command_script = "my_give_command",
        mod_id = MOD_NAME,
        desc = "quickly give an item from my mod",
        parameters = "{item} {count}",
        parameters_desc = "{item} - the oid to be appended by your mod_id {count} - how many of the item, defualts to one"
    }
}
command_count = #command_list

function my_give_command(item, count)
    api_log("ahhh", MOD_NAME .. "_" .. item)
    if tonumber(count) > 0 then
        api_give_item(MOD_NAME .. "_" .. item, count)
    else
        api_give_item(MOD_NAME .. "_" .. item, 1)
    end
end

function decornmore_command()
    api_log("HELP", MOD_TITLE .. " Coded by coolbot100s and spreites by Kchem. https://github.com/coolbot100s/decor-more")
end

function define_commands()
    for i = 1,command_count do
        local cur = command_list[i]
        api_define_command(cur["command_name"], cur["command_script"])
    end
end



-- DevmodePlus compatibility
function add_to_dmp()
    if api_mod_exists("devmodeplus") then
        api_mod_call("devmodeplus", "add_my_commands", {MOD_NAME, command_list} )
    end
end