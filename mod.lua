-- https://github.com/coolbot100s/decor-more
MOD_NAME = "decornmore"

function register()
    return {
        name = MOD_NAME,
        hooks = {},
        modules = {"helpers"}
    }    
end
function init()
    api_log("init", "ayo we did it")
    return "Success"
end

COLORS = {"red","blue","yellow","green","orange","purple","black","white","gold","turqoise","lime","pink","brown"}

variated_objects_generics = {{"object definition table goes here"}} --contains object deifinitions for things that should recieve color variations.

--- Returns a table of tables that contain obj_definitions and sprites with desired variations that can then be used like so: api_define_object(returned_val[i][1], returned_val[i][2])
---@param obj_def obj_definition An obj_definition that contains a non-variated version of the item.
---@param variations table List of variations as a table with strings, example: COLORS
---@param folder string Name of the folder the spritesheets are found in.
---@param edit_tooltip boolean If the tooltip should be editid for each variation or not. If false tooltip will be the same for all variations
---@param tooltip table [Optional] a dictionary containing 3 items "preface" "insert" "suffix". Preface will come before the insert (changes on variation) part of the tooltip, "suffix" will come after. "insert" should contain a space on either side of the text you want to display, example: " Hello World " and NOT in preface or suffix. 
function make_variated( obj_def, variations, folder, edit_tooltip, tooltip)
    variation_list = {}
    for i = 1,#variations do
        obj_def["id"] = variations[i] .. "_" .. obj_def["id"]               
        obj_def["name"] = up(variations[i]) .. " " .. obj_def["name"]
        if edit_tooltip == true then
            if tooltip["insert"] ~= nil then
                obj_def["tooltip"] = tooltip["preface"] .. tooltip["insert"] .. tooltip["suffix"]
            else
                obj_def["tooltip"] = tooltip["preface"] .. " " .. up(variations[i]) .. " " .. tooltip["suffix"]
            end
        sprite_path = "sprites/" .. folder .. "/" .. obj_def["id"] .. "_sheet.png"
        table.insert({obj_def, sprite_path})
        end
    return variation_list
    end
end

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
        return "sprites/" .. folder .. "/" .. name .. "_sheet.png"
    else
        return "sprites/" .. name "/" .. name .. "_sheet.png"
    end
end