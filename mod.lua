-- decornmore mod.lua
-- https://github.com/coolbot100s/decor-more
MOD_NAME = "decornmore"
MOD_TITLE = "Decor N' More"

-- log strings
ITEM_REGISTRY = "ITEM REGISTRY"

function register()
    return {
        name = MOD_NAME,
        hooks = {"ready", "click"},
        modules = {"helpers", "object_tables", "commands", "crafting", "painting", "recipes"}
    }
end
function init()
    mass_define_variations(colorables, COLORS)
    define_from_table(decor, "furniture")
    define_commands()
    define_deco_workbench()
    dw_define_tabs(2)
    define_recipes(decor_recipes)
    return "Success"
end
function ready()
    add_to_dmp()
end


-- Defines objects from a list of "originals" and a list of desired variations. no tooltip modification, sprites should be located in a subfolder named after the original items item_id.
function mass_define_variations(bases, variations)
    for i = 1,#bases do
        folder = bases[i]["id"]
        variated = make_variated(bases[i], variations, folder, false)
        for i = 1,#variated do
            api_define_object(variated[i][1], variated[i][2])
        end
        api_define_object(bases[i], sprite_path(bases[i]["id"], folder))
    end
    api_log(ITEM_REGISTRY, MOD_TITLE .. " Defined " .. #bases .. " New objects and " .. #bases * #variations .. " Variants.")
end

--- Returns a table of tables that contain obj_definitions and sprites with desired variations that can then be used like so: api_define_object(returned_val[i][1], returned_val[i][2])
---@param obj_def obj_definition An obj_definition that contains a non-variated version of the item.
---@param variations table List of variations as a table with strings, example: COLORS
---@param folder string Name of the folder the spritesheets are found in.
---@param edit_tooltip boolean If the tooltip should be editid for each variation or not. If false tooltip will be the same for all variations
---@param tooltip table (Optional) a dictionary containing 3 items "preface" "insert" "suffix". Preface will come before the insert (changes on variation) part of the tooltip, "suffix" will come after. "insert" should contain a space on either side of the text you want to display, example: " Hello World " and NOT in preface or suffix. 
function make_variated(obj_def, variations, folder, edit_tooltip, tooltip)
    variation_list = {}
    for i = 1,#variations do
        cur = table.shallow_copy(obj_def) --current obj
        cur["id"] = variations[i] .. "_" .. obj_def["id"]
        cur["name"] = cap(variations[i]) .. " " .. obj_def["name"]
        if edit_tooltip == true then
            if tooltip["insert"] ~= nil then
                cur["tooltip"] = tooltip["preface"] .. tooltip["insert"] .. tooltip["suffix"]
            else
                cur["tooltip"] = tooltip["preface"] .. " " .. cap(variations[i]) .. " " .. tooltip["suffix"]
            end
        end
        table.insert(variation_list, {cur, sprite_path(cur["id"], folder)})
    end
    return variation_list
end

--- Generates and returns a path to the sprite of an object as a string
---@param name string typically object_definition["id"]
---@param folder string (Optional) Subfolder for the sprite, if none is given will use name instead.
function sprite_path(name, folder)
    if type(folder) == "string" then
        return "sprites/" .. folder .. "/" .. name .. ".png"
    else
        return "sprites/" .. name "/" .. name .. ".png"
    end
end

-- Intended to use the return of make_variated() to define objects.
function define_from_variation_list(variation_list)
    for i = 1,#variation_list do
        api_define_object(variation_list[i][1], variation_list[i][2])
    end
end

--- Define objects from a table
---@param table table List of object_definitions to be defined.
---@param folder string Folder where object sprites are located.
function define_from_table(table, folder)
    for i = 1,#table do
        cur = table[i]
        api_define_object(cur, sprite_path(cur["id"], folder))
    end
    api_log(ITEM_REGISTRY, MOD_TITLE .. " Defined " .. #table .. " New objects.")
end
-- Does this really need to exist? i could jsut use define_from_variation_list... eh

function click(button, click_type)
    if button == "LEFT" and click_type == "PRESSED" then
        dye_used()
    end
--    if button == "RIGHT" and click_type == "PRESSED" then
--        paint_brush_update()
--    end
end



