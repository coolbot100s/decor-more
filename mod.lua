-- https://github.com/coolbot100s/decor-more
MOD_NAME = "decor&more"

function register()
    return {
        name = MOD_NAME,
        hooks = {},
        modules = {"helpers"}
    }    
end
function init()
    api_log("init", "ayo we did it")
    register_variated_objects()
    return "Success"
end

COLORS = {"red","blue","yellow","green","orange","purple","black","white","gold","turqoise","lime","pink","brown"}

variated_objects_generics = {{}} --contains object deifinitions for things that should recieve color variations

function register_variated_objects() -- these could be one function? idk this might look better.
    for i = 1,#variated_objects_generics do
        make_variated(variated_objects_generics[i])
    end
end
function make_variated(obj) -- pass a normal object definition
    for i = 1,#COLORS do
        obj["id"] = COLORS[i] .. "_" .. obj["id"]
        obj["name"] = up(COLORS[i]) .. " " .. obj["name"]
        api_define_object(obj, "sprites/" .. obj[id .. "_sheet.png"])
    end
end