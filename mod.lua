-- https://github.com/coolbot100s/decor-more
MOD_NAME = "decornmore"

COLORS = {"red","blue","yellow","green","orange","purple","black","white","gold","turquoise","lime","pink","brown"}
colorables = {
    {
        id = "wood_chair",
        name = "Wood Chair",
        category = "Furniture",
        tooltip = "A comfy wooden chair!",
        tools = {"hammer1"}
    },
    {
        id = "wood_stool",
        name = "Wood Stool",
        category = "Furniture",
        tooltip = "Great for your feet or your butt!",
        tools = {"hammer1"}
    },
    {
        id = "table_lamp",
        name = "Tabmle Lamp",
        category = "Furniture",
        tooltip = "",
        tools = {"hammer1"}
    }
}

function register()
    return {
        name = MOD_NAME,
        hooks = {},
        modules = {"helpers"}
    }
end
function init()
    api_log("init", "ayo we did it")
    mass_define_variations(colorables, COLORS)
    return "Success"
end

-- Defines objects from a list of "originals" and a list of desired variations. no tooltip modification, sprites should be located in a subfolder named after hte original items item_id.
function mass_define_variations(bases, variations)
    for i = 1,#bases do
        folder = bases[i]["id"]
        variated = make_variated(bases[i], variations, folder, false)
        for i = 1,#variated do
            api_define_object(variated[i][1], variated[i][2])
        end
        api_define_object(bases[i], sprite_path(bases[i]["id"], folder))
    end
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
        api_log("debug", cur["id"])
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

-- Intended to use the return of make_variated() to define objects.
function define_from_variation_list(variation_list)
    for i = 1,#variation_list do
        api_define_object(variation_list[i][1], variation_list[i][2])
    end
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