brush_mode = 0


function get_deco_brush_mode()
    if brush_mode > 0 then
        return COLORS[brush_mode]
    else
        return "none"
    end
end

function paint_brush_used()
    player = api_get_player_instance()
    hb_index = api_gp(player, "hotbar") + 1
    holding = api_get_slot(player, hb_index)
    if holding["item"] == "decornmore_furniture_brush" then                     -- if currently holding a furniture_brush
        highlighted = api_get_inst(api_get_highlighted("obj"))
        color = get_deco_brush_mode()
        if color == "none" then
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
                                apply_paint(highlighted["id"], new_oid, copy["x"],copy["y"])
                                -- use up dye of the selected color
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

function paint_brush_update()
    player = api_get_player_instance()
    hb_index = api_gp(player, "hotbar") + 1
    holding = api_get_slot(player, hb_index)
    api_log("holdin", holding)
    if holding["item"] == "decornmore_furniture_brush" then
        if brush_mode + 1 < #COLORS + 1 then
            brush_mode = brush_mode + 1
            api_play_sound("click")
        else
            brush_mode = 0
            api_play_sound("click")
        end
    end
    api_slot_set(holding, "decornmore_red_furniture_brush", 1)
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


brush = {
        id = "furniture_brush",
        name = "Furniture Brush",
        category = "Tool",
        tooltip = "Customize your furniture!",
        placable = false,
        singular = true,
        pickable = false
        }

function define_paintbrush()
    for i = 1,#COLORS do
        cur = table.shallow_copy(brush) --current obj
        cur["id"] = COLORS[i] .. "_" .. brush["id"]
        api_log("brush", cur["id"])
        cur["tooltip"] = "Use this to paint some furniture" .. " " .. cap(COLORS[i]) .. "! " .. "Right click to change colors."

        api_define_item(cur,sprite_path(cur["id"], "items/furniture_brush"))
    end
    api_define_item(brush, "sprites/items/furniture_brush/furniture_brush.png")
end