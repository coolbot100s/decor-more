-- recipes.lua
decor_recipes = {
    {{{"bench", 1}, {"planks2", 2}}, MOD_NAME .. "_wood_stool", 1, 1},
    {{{"bench", 1}, {"planks2", 3}}, MOD_NAME .. "_wood_chair", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_comfy_chair", 1, 1},
    {{{"sticks2", 3}, {"planks2", 1}}, MOD_NAME .. "_table_lamp", 1, 1},
    {{{"sticks2", 3}, {"planks2", 1}}, MOD_NAME .. "_paint_brush", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_globe", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_small_table", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_night_stand", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_pen_and_parchment", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_plant_a", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_plant_b", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_plant_c", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_plant_d", 1, 2},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_plant_e", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_plant_f", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_phonograph", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_rotary_phone", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_teddy_bear", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_sink", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_stove", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_swatch", 1, 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_big_clock", 1, 2},
    {{{MOD_NAME .. "_painting_easle", 1}, {"planks2", 2}}, MOD_NAME .. "_painting_blank", 1, 2},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_painting_easle", 1, 2}
}

function define_recipes(recipes)
    for i = 1,#recipes do
        dw_define_recipe(recipes[i][1],recipes[i][2],recipes[i][3],recipes[i][4])
    end
end