COLORS = {"red","blue","yellow","green","orange","purple","black","white","gold","turquoise","lime","pink","brown"}
dyeid_color = {"dye1", "red", "dye2", "blue", "dye3", "yellow", "dye4", "green", "dye5", "orange", "dye6", "purple", "dye7", "black", "dye8", "white", "dye12", "gold", "dye13", "turqoise", "dye14", "lime", "dye15", "pink", "dye16", "brown"}

colorables = {
    {
        id = "wood_chair",
        name = "Wood Chair",
        category = "Furniture",
        tooltip = "A comfy wooden chair!",
        tools = {"hammer1"},
        item_sprite = sprite_path("icon_" .. "wood_chair", "icons")
    },
    {
        id = "wood_stool",
        name = "Wood Stool",
        category = "Furniture",
        tooltip = "Great for your feet or your butt!",
        tools = {"hammer1"}
    },
    {
        id = "table_lamp",          -- TODO add the ability to turn on / off as a light source
        name = "Table Lamp", --rip tabmle
        category = "Furniture",
        tooltip = "Perfect for your nightstand",
        tools = {"hammer1"}
    }
}




-- pretty much all non variated items will go here methinks
decor = {
    {
        id = "big_clock",           --  TODO add the ability to see time.
        name = "Big Clock",
        category = "Furniture",
        tooltip = "",
        tools = {"hammer1"},
        item_sprite = sprite_path("icon_" .. "big_clock", "icons")
    },
    {
        id = "plant_a",
        name = "Decorative Plant",
        category = "Decoration",
        tooltip = "Makes me feel happy when it's in the room :)",
        tools = {"hammer1"}
    },
    {
        id = "plant_b",
        name = "Decorative Plant",
        category = "Decoration",
        tooltip = "Pretty and Pink",
        tools = {"hammer1"}
    },
    {
        id = "plant_c",
        name = "Decorative Plant",
        category = "Decoration",
        tooltip = "?",
        tools = {"hammer1"},
        item_sprite = sprite_path("icon_" .. "plant_c", "icons")
    },
    {
        id = "plant_d",
        name = "Decorative Plant",
        category = "Decoration",
        tooltip = "What a big boi",
        tools = {"hammer1"},
        item_sprite = sprite_path("icon_" .. "plant_d", "icons")
    },
    {
        id = "globe", -- TODO Add the ability to spin the glone and see an animation
        name = "Globe",
        category = "Decoration",
        tooltip = "It's weird I can never find the places I've been on this thing.",
        tools = {"hammer1"}
    },
    {
        id = "small_table",
        name = "Small Table",
        category = "Furniture",
        tooltip = "A small wooden table with a glass top.",
        tools = {"hammer1"}
    },
    {
        id = "phonograph",
        name = "Phonograph",
        category = "Decoration",
        tooltip = "If you put your ear up to it you can hear the ocean! once...",
        tools = {"hammer1"},
        item_sprite = sprite_path("icon_" .. "phonograph", "icons")
    },
    {
        id = "rotary_phone",
        name = "Rotary Phone",
        category = "Decoration",
        tooltip = "It keeps ringing but no one is ever on the other line.",
        tools = {"hammer1"}
    },
    {
        id = "teddy_bear",
        name = "Teddy Bear",
        category = "Best Friend",
        tooltip = "Someone to keep you company in this lonely world.",
        tools = {"hammer1"}
    }
}

decor_recipes = {
    {{{"bench", 1}, {"planks2", 2}}, MOD_NAME .. "_wood_stool", 1},
    {{{"bench", 1}, {"planks2", 3}}, MOD_NAME .. "_wood_chair", 1},
    {{{"sticks2", 3}, {"planks2", 1}}, MOD_NAME .. "_table_lamp", 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_globe", 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_small_table", 1}
}

function define_recipes(recipes)
    for i = 1,#recipes do
        dw_define_recipe(recipes[i][1],recipes[i][2],recipes[i][3])
    end
end
