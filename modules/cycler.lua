brush_mode = "red"


function get_deco_brush_mode()
    return brush_mode
end

function define_paintbrush()
    api_define_item(
        {
            id = "furniture_brush",
            name = "Furniture Brush",
            category = "Tool",
            tooltip = "Customize your furniture!",
            placable = false,
            singular = true,
            pickable = true
        }, "sprites/items/furniture_brush.png"
    )
end

function paint_brush_used()                 
    player = api_get_player_instance()
    api_log("debug", player)
    hb_index = api_gp(player, "hotbar") + 1
    api_log("debug", hb_index)
    holding = api_get_slot(player, hb_index)
    api_log("hi", holding["item"])
    if holding["item"] == "decornmore_furniture_brush" then                     -- if currently holding a furniture_brush
        api_log("is brush", "woo")
        highlighted = api_get_inst(api_get_highlighted("obj"))
        if string.find(highlighted["oid"], MOD_NAME) then                       -- If the clicked item is from decornmore
            api_log("from", "decornmore")
            for i = 1,#colorables do                                            --
                if string.find(highlighted["oid"], colorables[i]["id"]) then    -- If the clicked item's oid is from the colorables list
                    copy = table.shallow_copy(highlighted)
                    color = get_deco_brush_mode()                               -- make a copy
                    for i = 1,#COLORS do                                         
                        if string.find(copy["oid"], COLORS[i]) ~= nil then      -- If it's colored..
                            if COLORS[i] == color then                          -- If it's the same color as the brush.
                                api_log("already",  color)                      -- Do nothing
                                return
                            end
                            api_log("cur", COLORS[i])
                            api_log("hi", "is colored")
                            new_oid = string.gsub(copy["oid"], COLORS[i], color, 1)        -- otherwise replace the color with the new color
                            api_destroy_inst(highlighted["id"])                             -- kill the old obj
                            api_create_obj(new_oid, copy["x"], copy["y"])                   -- and replace it with the new painted version
                            api_log("AYO?", new_oid)
                            -- use up dye of the selected color
                            return
                        end
                    end
                    new_oid = string.insert(copy["oid"], color .. "_", #MOD_NAME + 1)       -- otherwise insert the color we want into the oid
                    api_log("AYO 2", new_oid)
                    api_destroy_inst(highlighted["id"])
                    api_create_obj(new_oid, copy["x"], copy["y"])
                    -- use of dye of the selected color
                    break
                end
            end
        end
    end
end

-- paint stripper?

