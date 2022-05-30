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

--- Returns a table of tables that contain object_definitions and sprites with desired variations that can then be used like so: api_define_object(returned_val[i][1], returned_val[i][2])
-- @param obj_def An object_definition that contains a non-variated version of the item.
-- @param variations List of variations as a table with strings, example: COLORS
-- @param folder A string with the name of the folder the spritesheets are found in.
-- @param edit_tooltip Bool to determine if the tooltip should be editid for each variation or not. If false tooltip will be the same for all variations
-- @param tooltip[opt] a dictionary containing 3 items "preface" "insert" "suffix". preface will come before the insert (changes on variation) part of the tooltip, "suffix" will come after. "insert" should contain a space on either side of the text you want to display, example: " Hello World " and NOT in preface or suffix. 
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
        sprite_path = folder .. "/" .. obj_def["id"] .. "/" .. obj_def["id"] .. "_sheet.png"
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

--EXAMPLE USAGE
function define_my_furniture()
    COLORS = {"red","blue","yellow","green","orange","purple","black","white","gold","turqoise","lime","pink","brown"}
    my_furniture_definition = {"object definition here"}
    tooltip = {preface = "This is a", suffix = "piece of furniture by Me"}
    define_from_variation_list(make_variated(my_furniture_definition, COLORS, "my_furniture", 1, tooltip))
end