function dye_used()
    holding = get_held()
    api_log("debug", holding)
    if string.find(holding["item"], "dye") then                     -- if currently holding a dye
        dye_type = holding["item"]
        highlighted = api_get_inst(api_get_highlighted("obj"))
        if table.search(dyeid_color, dye_type) then 
            color = dyeid_color[table.search(dyeid_color, dye_type) + 1]
        else
            return
        end
        api_log("stuff", highlighted)

        if highlighted ~= nil then
            if string.find(highlighted["oid"], MOD_NAME) then                       -- If the clicked item is from decornmore
                for i = 1,#colorables do                                            --
                    if string.find(highlighted["oid"], colorables[i]["id"]) then    -- If the clicked item's oid is from the colorables list
                        copy = table.shallow_copy(highlighted)                      -- make a copy
                        for i = 1,#COLORS do                                         
                            if string.find(copy["oid"], COLORS[i]) ~= nil then      -- If it's colored..
                                if COLORS[i] == color then                          -- If it's the same color as the brush.
                                    return
                                end
                                new_oid = string.gsub(copy["oid"], COLORS[i], color, 1)        -- otherwise replace the color with the new color
                                apply_paint(highlighted["id"], new_oid, copy["x"],copy["y"])   -- use up dye of the selected color
                                return
                            end
                        end
                        new_oid = string.insert(copy["oid"], color .. "_", #MOD_NAME + 1)       -- otherwise insert the color we want into the oid
                        apply_paint(highlighted["id"], new_oid, copy["x"],copy["y"])
                        break
                    end
                end
            end
        end
    end
end

function apply_paint(destroy, new_oid, x,y)
    holding = get_held()
    if holding["count"] > 0 then
        api_destroy_inst(destroy)
        api_create_obj(new_oid, x, y)
        api_slot_decr(holding["id"], 1)
        api_play_sound("pop")
    else
        api_play_sound("error")
    end
end