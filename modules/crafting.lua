-- crafting.lua
-- thanks beecubed! https://github.com/APICO-Modders/APICO-Community-Decorations/blob/crafting_tables/modules/crafting.lua
-- commit e1cf2e2

DECO_WORKBENCH_RECIPES = {}
DECO_WORKBENCH_RECIPE_INDEX = {}
RECIPE_SLOT_AMOUNT = 5
SLOT_SPR = -1
RECIPE_SPR = -1
ARROW_SPR = -1
PLUS_SPR = -1
TABS_SPR = {}
TABS_SELECTED_SPR = {}
CAN_CRAFT_SPR = -1
CANT_CRAFT_SPR = -1
WHITE_NUMBERS_SPR = -1
RED_NUMBERS_SPR = -1
SPR_REF = {}

-- defines recipes (used by other scripts)
--[[
TEMPLATE :
dw_define_recipe({{"item1", 1}, {"item2", 3}}, "output_item", 3)
]]--
function dw_define_recipe(input_table, output, num, tab)
	--DECO_WORKBENCH_RECIPES[tab][#DECO_WORKBENCH_RECIPES[tab]+1] = {input_table, {output, num}}
	table.insert(DECO_WORKBENCH_RECIPES[tab], {input_table, {output, num}})
	DECO_WORKBENCH_RECIPE_INDEX[tab][output] = #DECO_WORKBENCH_RECIPES[tab]
	for i=1,#input_table do
		SPR_REF[input_table[i][1]] = api_get_sprite("sp_" .. input_table[i][1])
	end
	SPR_REF[output] = api_get_sprite("sp_" .. output)
end

function dw_define_tabs(num)
	for i=1, num do
		table.insert(DECO_WORKBENCH_RECIPES, {})
		table.insert(DECO_WORKBENCH_RECIPE_INDEX, {})
	end
end

function prep_deco_workbench()
	SLOT_SPR = api_define_sprite("dw_item_slot", "sprites/crafting/dw_item_slot.png", 2)
	RECIPE_SPR = api_define_sprite("dw_recipe_slot", "sprites/crafting/dw_recipe_slot.png", 1)
	ARROW_SPR = api_define_sprite("dw_arrow", "sprites/crafting/dw_arrow.png", 1)
	PLUS_SPR = api_define_sprite("dw_plus", "sprites/crafting/dw_plus.png", 1)
	CAN_CRAFT_SPR = api_define_sprite("dw_craft", "sprites/crafting/dw_craft.png", 2)
	CANT_CRAFT_SPR = api_define_sprite("dw_craft_error", "sprites/crafting/dw_craft_error.png", 2)
	for i=1,5 do
		TABS_SPR[i] = api_define_sprite("dw_tab_" .. i, "sprites/crafting/dw_tab_" .. i .. ".png", 2)
		TABS_SELECTED_SPR[i] = api_define_sprite("dw_tab_" .. i .. "_s", "sprites/crafting/dw_tab_" .. i .. "_selected.png", 2)
	end
	WHITE_NUMBERS_SPR = api_define_sprite("white_numbers_sprite", "sprites/crafting/white_numbers.png", 13)
	RED_NUMBERS_SPR = api_define_sprite("red_numbers_sprite", "sprites/crafting/red_numbers.png", 13)
end

function define_deco_workbench()
	prep_deco_workbench()
    api_define_menu_object({
        id = "decoration_workbench",
        name = "Decoration Workbench",
        category = "Crafting",
        tooltip = "Used for crafting items from the Community Decorations mod.",
        shop_key = false,
        shop_buy = 0,
        shop_sell = 0,
        layout = {},
        buttons = {"Help", "Close"},
        info = {},
        tools = {"mouse1", "hammer1"},
    	placeable = true
    }, "sprites/crafting/decoration_workbench.png", "sprites/crafting/decoration_workbench_gui.png", {
        define = "deco_workbench_define",
		draw = "deco_workbench_draw"
		--tick = "deco_workbench_tick"
    }, nil)
end

function deco_workbench_define(menu_id)
	api_dp(menu_id, "tab", 1)
	api_dp(menu_id, "selected_item", nil)
	api_dp(menu_id, "selected_recipe", nil)
	api_dp(menu_id, "invalid", false)
	api_dp(menu_id, "ingredient1", nil)
	api_dp(menu_id, "ingredient1_amount", nil)
	api_dp(menu_id, "ingredient2", nil)
	api_dp(menu_id, "ingredient3", nil)
	api_dp(menu_id, "craft_amount", 1)

	-- tabs
	api_define_button(menu_id, "tab1", 6, 16, "1", "dw_tab_click", "sprites/crafting/dw_tab_1_selected.png")
	for i=2,#DECO_WORKBENCH_RECIPES do
		api_define_button(menu_id, "tab" .. i, 6 + 21 * (i - 1), 16, tostring(i), "dw_tab_click", "sprites/crafting/dw_tab_" .. i .. ".png")
	end
	for i=1,20 do
		api_define_button(menu_id, "recipe" .. i, 8 + 21 * ((i - 1) % 5), 30 + 21 * ((i - 1) // 5), "", "dw_recipe_click", "sprites/crafting/dw_slot.png")
	end
	api_log("dw", "defining tab 1 recipes ...")
	tab = api_gp(menu_id, "tab")
	for i=1,#DECO_WORKBENCH_RECIPES[tab] do
		api_sp(api_gp(menu_id, "recipe" .. i), "text", DECO_WORKBENCH_RECIPES[tab][i][2][1])
	end
	api_log("dw", "defining other buttons ...")
	api_define_button(menu_id, "decrease_results", 113, 92, "decrease_results", "dw_decrease_results", "sprites/crafting/dw_result_minus.png")
	api_define_button(menu_id, "increase_results", 164, 92, "increase_results", "dw_increase_results", "sprites/crafting/dw_result_plus.png")
	api_define_button(menu_id, "craft_button", 182, 92, "Craft!", "dw_craft_click", "sprites/crafting/dw_craft.png")
	api_define_button(menu_id, "craft_amount_display", 131, 92, "1", "dw_do_nothing", "sprites/crafting/dw_craft_amount.png")
end

function deco_workbench_draw(menu_id)
	cam = api_get_cam()
	--api_log("dw", "drawing tabs ...")
	for i=1,#DECO_WORKBENCH_RECIPES do
		api_draw_button(api_gp(menu_id, "tab" .. i), false)
		api_draw_button(api_gp(menu_id, "tab" .. i), false)
	end
	--api_log("dw", "drawing other buttons ...")
	api_draw_button(api_gp(menu_id, "decrease_results"), false)
	api_draw_button(api_gp(menu_id, "increase_results"), false)
	api_draw_button(api_gp(menu_id, "craft_amount_display"), true)
	-- the rest of this function draws the sprites to choose recipes
	--api_log("dw", "finding tab ...")
	tab = api_gp(menu_id, "tab")
	--api_log("dw", "drawing recipes ...")
	for i=1,#DECO_WORKBENCH_RECIPES[tab] do
		recipe = api_gp(menu_id, "recipe" .. i)
		recipe_oid = api_gp(recipe, "text")
		api_draw_button(recipe, false)
		api_draw_sprite(SPR_REF[recipe_oid], 0, api_gp(recipe, "x") - cam["x"], api_gp(recipe, "y") - cam["y"])
	end
	--api_log("dw", "drawing selected recipe ...")
	if api_gp(menu_id, "selected_item") ~= nil then
		recipe = api_gp(menu_id, "selected_recipe")
		recipe_length = #recipe[1]
		ingredient1 = recipe[1][1]
		ingredient2 = nil
		ingredient3 = nil
		output = recipe[2][1]
		offset = 0
		ox = api_gp(menu_id, "x") - cam["x"]
		oy = api_gp(menu_id, "y") - cam["y"]
		amt = api_gp(menu_id, "craft_amount")
		draw_recipe(menu_id, ox, oy, amt)
	end
end

function draw_recipe(menu_id, ox, oy, amt)
	inv_amts = check_inventory(menu_id)
	can_craft_slots = inv_amts[2]
	inv_amts = inv_amts[1]
	-- set the colors for numbers (white if craftable, red if not)
	can_craft_color = {}
	for i=1,#can_craft_slots do
		if can_craft_slots[i] == false then
			can_craft_color[i] = "RED"
		elseif can_craft_slots[i] == true then
			can_craft_color[i] = "WHITE"
		end
	end
	if recipe_length == 1 then
		-- draw middle sprite
		api_draw_sprite(SLOT_SPR, 0, ox + 158, oy + 20)
		api_draw_sprite(SPR_REF[ingredient1[1]], 0, ox + 160, oy + 22)
		draw_numbers(ox + 158, oy + 37, tostring(inv_amts[1]), tostring(ingredient1[2] * amt), can_craft_color[1])
	elseif recipe_length == 2 then
		ingredient2 = recipe[1][2]
		-- draw the left sprite
		api_draw_sprite(SLOT_SPR, 0, ox + 158 - 19, oy + 20)
		api_draw_sprite(SPR_REF[ingredient1[1]], 0, ox + 160 - 19, oy + 22)
		draw_numbers(ox + 158 - 19, oy + 37, tostring(inv_amts[1]), tostring(ingredient1[2] * amt), can_craft_color[1])
		-- draw the right sprite
		api_draw_sprite(SLOT_SPR, 0, ox + 158 + 19, oy + 20)
		api_draw_sprite(SPR_REF[ingredient2[1]], 0, ox + 160 + 19, oy + 22)
		draw_numbers(ox + 158 + 19, oy + 37, tostring(inv_amts[2]), tostring(ingredient2[2]), can_craft_color[2])

		-- draw the plus
		api_draw_sprite(PLUS_SPR, 0, ox + 166, oy + 28)
	else
		ingredient2 = recipe[1][2]
		ingredient3 = recipe[1][3]
		-- draw the left sprite
		api_draw_sprite(SLOT_SPR, 0, ox + 158 - 39, oy + 20)
		api_draw_sprite(SPR_REF[ingredient1[1]], 0, ox + 160 - 39, oy + 22)
		draw_numbers(ox + 158 - 39, oy + 37, tostring(inv_amts[1]), tostring(ingredient1[2] * amt), can_craft_color[1])
		-- draw middle sprite
		api_draw_sprite(SLOT_SPR, 0, ox + 158, oy + 20)
		api_draw_sprite(SPR_REF[ingredient2[1]], 0, ox + 160, oy + 22)
		draw_numbers(ox + 158, oy + 37, tostring(inv_amts[2]), tostring(ingredient2[2]), can_craft_color[2])
		-- draw the right sprite
		api_draw_sprite(SLOT_SPR, 0, ox + 158 + 39, oy + 20)
		api_draw_sprite(SPR_REF[ingredient3[1]], 0, ox + 160 + 39, oy + 22)
		draw_numbers(ox + 158 + 39, oy + 37, tostring(inv_amts[3]), tostring(ingredient3[2]), can_craft_color[3])

		-- draw the pluses
		api_draw_sprite(PLUS_SPR, 0, ox + 146, oy + 28)
		api_draw_sprite(PLUS_SPR, 0, ox + 185, oy + 28)
	end
	-- draw arrow
	api_draw_sprite(ARROW_SPR, 0, ox + 166, oy + 44)
	-- draw recipe output
	api_draw_sprite(SLOT_SPR, 1, ox + 158, oy + 57)
	api_draw_sprite(SPR_REF[output], 0, ox + 160, oy + 59)
	draw_number(ox + 158 + 21, oy + 59 + 15, tostring(amt), "WHITE", "RIGHT")

	-- draw craft button
	api_draw_button(api_gp(menu_id, "craft_button"), true)
end

function check_inventory(menu_id)
	if api_gp(menu_id, "open") == true then
		-- check that the player + other menus have enough items
		recipe = api_gp(menu_id, "selected_recipe")
		if recipe ~= nil then
			recipe_length = #recipe[1]
			recipe_multi = api_gp(menu_id, "craft_amount")
			recipe[1][1][2] = recipe[1][1][2] * recipe_multi
			recipe[2][2] = recipe[2][2] * recipe_multi
			i1amt = api_use_total(recipe[1][1][1])
			out = {i1amt}
			can_craft = i1amt >= recipe[1][1][2]
			can_craft_out = {can_craft}
			if recipe_length >= 2 then
				i2amt = api_use_total(recipe[1][2][1])
				out[2] = i2amt
				recipe[1][2][2] = recipe[1][2][2] * recipe_multi
				can_craft_out[2] = i2amt >= recipe[1][2][2]
				can_craft = can_craft and can_craft_out[2]
			end
			if recipe_length >= 3 then
				i3amt = api_use_total(recipe[1][3][1])
				out[3] = i3amt
				recipe[1][3][2] = recipe[1][3][2] * recipe_multi
				can_craft_out[3] = i3amt >= recipe[1][3][2]
				can_craft = can_craft and can_craft_out[3]
			end

			-- set the crafting button to the proper sprite
			if can_craft then
				api_sp(menu_id, "invalid", false)
				api_sp(api_gp(menu_id, "craft_button"), "sprite_index", CAN_CRAFT_SPR)
			else
				api_sp(menu_id, "invalid", true)
				api_sp(api_gp(menu_id, "craft_button"), "sprite_index", CANT_CRAFT_SPR)
			end
			return {out, can_craft_out}
		end
	end
end

-- actually crafts the item
function dw_craft_click(menu_id)
	-- double check that the player has the proper items
	can_craft = api_use_total(recipe[1][1][1]) >= recipe[1][1][2]
	if recipe_length >= 2 then
		can_craft = can_craft and api_use_total(recipe[1][2][1]) >= recipe[1][2][2]
	end
	if recipe_length >= 3 then
		can_craft = can_craft and api_use_total(recipe[1][3][1]) >= recipe[1][3][2]
	end
	if can_craft then
		api_use_item(recipe[1][1][1], recipe[1][1][2])
		if recipe_length >= 2 then
			api_use_item(recipe[1][2][1], recipe[1][2][2])
		end
		if recipe_length >= 3 then
			api_use_item(recipe[1][3][1], recipe[1][3][2])
		end
		api_give_item(recipe[2][1], recipe[2][2])
	end
	
end

function dw_recipe_click(menu_id, button_id)
	button_id = api_get_highlighted("ui")
	recipe_item = api_gp(button_id, "text")
	if recipe_item ~= "" then
		api_sp(menu_id, "selected_item", api_gp(button_id, "text"))
		api_sp(menu_id, "selected_recipe", DECO_WORKBENCH_RECIPES[tab][DECO_WORKBENCH_RECIPE_INDEX[tab][api_gp(button_id, "text")]])
	end
end

function dw_tab_click(menu_id, button_id)
	tab = api_gp(button_id, "text")
	if tab ~= "" then
		tab = tonumber(tab)
		api_sp(menu_id, "tab", tab)
		for i=1,10 do
			if i <= #DECO_WORKBENCH_RECIPES[tab] then
				api_sp(api_gp(menu_id, "recipe" .. i), "text", DECO_WORKBENCH_RECIPES[tab][i][2][1])
			else
				api_sp(api_gp(menu_id, "recipe" .. i), "text", "")
			end
		end
		for i=1, #DECO_WORKBENCH_RECIPES do
			api_sp(api_gp(menu_id, "tab" .. i), "sprite_index", TABS_SPR[i])
		end
		api_sp(api_gp(menu_id, "tab" .. tab), "sprite_index", TABS_SELECTED_SPR[tab])
	end
end

function dw_increase_results(menu_id)
	amt = api_gp(menu_id, "craft_amount")
	api_sp(menu_id, "craft_amount", amt + 1)
	update_amount_display(menu_id, amt + 1)
end

function dw_decrease_results(menu_id)
	amt = api_gp(menu_id, "craft_amount")
	if amt > 1 then
		api_sp(menu_id, "craft_amount", amt - 1)
		update_amount_display(menu_id, amt -1)
	end
end

function update_amount_display(menu_id, amt)
	api_sp(api_gp(menu_id, "craft_amount_display"), "text", amt)
end

function draw_numbers(x, y, n1, n2, color, justify)
	justify = "CENTER" or justify
	offset = 4
	start = 0
	if justify == "CENTER" then
		start = -((#n1 + #n2 - 3) * offset / 2) + 10
	elseif justify == "RIGHT" then
		start = -((#n1 + #n2 - 3) * offset)
	end
	drawn = 0
	if color == "WHITE" then 
		numbers = WHITE_NUMBERS_SPR
	else
		numbers = RED_NUMBERS_SPR
	end
	for i=1, #n1 - 2 do
		api_draw_sprite(numbers, tonumber(string.sub(n1, i, i)), x + drawn * offset + start, y)
		drawn = drawn + 1
	end
	api_draw_sprite(numbers, 11, x + drawn * offset + start, y)
	drawn = drawn + 1
	for i=1, #n2 - 2 do
		api_draw_sprite(numbers, tonumber(string.sub(n2, i, i)), x + drawn * offset + start, y)
		drawn = drawn + 1
	end
end

function draw_number(x, y, n1, color, justify)
	justify = justify or "CENTER"
	offset = 4
	start = 0
	if justify == "CENTER" then
		start = -((#n1 - 2) * offset / 2) + 10
	elseif justify == "RIGHT" then
		start = -((#n1 - 2) * offset)
	end
	drawn = 0
	if color == "WHITE" then 
		numbers = WHITE_NUMBERS_SPR
	else
		numbers = RED_NUMBERS_SPR
	end
	-- draw n1 (limited to three chars)
	for i=1, #n1 - 2 do
		api_draw_sprite(numbers, tonumber(string.sub(n1, i, i)), x + drawn * offset + start, y)
		drawn = drawn + 1
	end
end

function dw_do_nothing(menu_id)
	-- hello !
	-- if you've made it this far, good job, and i apologize for my code
	-- good luck !
	-- this function does nothing
end