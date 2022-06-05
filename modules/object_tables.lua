-- object_tables.lua
COLORS = {"red","blue","yellow","green","orange","purple","black","white","gold","turquoise","lime","pink","brown"}
dyeid_color = {"dye1", "red", "dye2", "blue", "dye3", "yellow", "dye4", "green", "dye5", "orange", "dye6", "purple", "dye7", "black", "dye8", "white", "dye12", "gold", "dye13", "turqoise", "dye14", "lime", "dye15", "pink", "dye16", "brown"}

colorables = {
    {
        id = "wood_chair",
        name = "Wood Chair",
        category = "Furniture",
        tooltip = "A comfy(ish) wooden chair!",
        tools = {"hammer1"},
        item_sprite = sprite_path("icon_" .. "wood_chair", "icons")
    },
--    {
--        id = "comfy_chair",
--        name = "Comfy Chair",
--        category = "Furniture",
--        tooltip = "A comfy chair!",
--        tools = {"hammer1"}
--    },
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
    },
--    {
--        id = "standing_lamp",
--        name = "Standing Lamp",
--        category = "Furniture",
--        tooltip = "Big boi",
--        tools = {"hammer1"},
--        item_sprite = sprite_path("icon_" .. "standing_lamp", "icons")
--    },
    {
        id = "paint_brush",
        name = "Paint Brush",
        category = "Decoration",
        tooltip = "You get the feeling this might be useful later",
        singular = true,
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
        id = "night_stand",
        name = "Night Stand",
        category = "Furniture",
        tooltip = "A bedside cubboard",
        tools = {"hammer1"}
    },
    {
        id = "painting_blank",
        name = "Empty Canvas",
        category = "Decoration",
        tooltip = "If only you had some paints...",
        tools = {"hammer1"}
    },
    {
        id = "painting_mona",
        name = "Classical Art",
        category = "Decoration",
        tooltip = "This looks oddly familiar.",
        tools = {"hammer1"}
    },
    {
        id = "painting_starry",
        name = "Classical Art",
        category = "Decoration",
        tooltip = "This looks oddly familiar.",
        tools = {"hammer1"}
    },
    {
        id = "painting_easle",
        name = "Easle",
        category = "Decoration",
        tooltip = "Even more blank than an empty canvas.",
        tools = {"hammer1"}
    },
    {
        id = "painting_blank",
        name = "Empty Canvas",
        category = "Decoration",
        tooltip = "If only you had some paints...",
        tools = {"hammer1"}
    },
    {
        id = "pen_and_parchment",
        name = "Pen N' Parchment",
        category = "Decoration",
        tooltip = "You feel compelled to write a love letter when holding this.",
        tools = {"hammer1"}
    },
    {
        id = "plant_a",
        name = "Decorative Plant",
        category = "Decoration",
        tooltip = "Makes me feel happy when it's in the room :)",
        tools = {"hammer1"},
        item_sprite = sprite_path("icon_" .. "plant_a", "icons")
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
        id = "plant_e",
        name = "Decorative Plant",
        category = "Decoration",
        tooltip = "Pretty and Purple",
        tools = {"hammer1"}
    },
    {
        id = "plant_f",
        name = "Decorative Plant",
        category = "Decoration",
        tooltip = "This plant is actually safe to eat... if only you could eat things.",
        tools = {"hammer1"}
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
    },
    {
        id = "sink",
        name = "Sink",
        category = "Furniture",
        tooltip = "Every kitchen needs at least one.",
        tools = {"hammer1"}
    },
    {
        id = "stove",
        name = "Stove",
        category = "Furniture",
        tooltip = "Careful! it's hot.",
        tools = {"hammer1"}
    },
    {
        id = "swatch",
        name = "Swatch",
        category = "Decoration",
        tooltip = "You feel creative holding these.",
        tools = {"hammer1"}
    }
}
