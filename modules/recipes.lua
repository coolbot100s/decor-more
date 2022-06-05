decor_recipes = {
    {{{"bench", 1}, {"planks2", 2}}, MOD_NAME .. "_wood_stool", 1},
    {{{"bench", 1}, {"planks2", 3}}, MOD_NAME .. "_wood_chair", 1},
    {{{"sticks2", 3}, {"planks2", 1}}, MOD_NAME .. "_table_lamp", 1},
    {{{"sticks2", 3}, {"planks2", 1}}, MOD_NAME .. "_paint_brush", 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_globe", 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_small_table", 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_big_clock", 1},
    {{{"sticks2", 3}, {"planks2", 2}}, MOD_NAME .. "_plant_a", 1},
}

function define_recipes(recipes)
    for i = 1,#recipes do
        dw_define_recipe(recipes[i][1],recipes[i][2],recipes[i][3])
    end
end