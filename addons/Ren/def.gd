extends Node

const _VAR		= preload("ren_var.gd")
const _CHR		= preload("nodes/character.gd")
const _QUEST	= preload("RPGSystem/quest.gd")
const _SUBQ		= preload("RPGSystem/subquest.gd")

func get_type(variable):
	var type = "str"
		
	if variable is bool:
		type = "bool"
	
	elif variable is int:
		type = "int"
	
	elif variable is float:
		type = "float"
	
	return type

func define_from_str(variables, var_name, var_str, var_type):
	if var_type == "str":
		define(variables, var_name, var_str, "text")
	
	elif var_type == "bool":
		define(variables, var_name, bool(var_str), "var")
	
	elif var_type == "int":
		define(variables, var_name, int(var_str), "var")
	
	elif var_type == "float":
		define(variables, var_name, float(var_str), "var")

func define(variables, var_name, var_value = null, var_type = null):
	if var_value != null && var_type == null:
		var_type = "var"
		var type = typeof(var_value)

		if type is String:
			var_type = "text"
		
		elif type is Dictionary:
			var_type = "dict"
		
		elif type is Array:
			var_type = "list"
		
		elif type is NodePath:
			var_type = "node"
			var_value = get_node(var_value)

	
	if var_type == "quest":
		var new_quest = _QUEST.new()
		new_quest.quest_id = var_name
		if type is Dictionary:
			new_quest.dict2quest(var_value)
		variables[var_name] = new_quest
		return new_quest
	
	if var_type == "subquest":
		var new_subquest = _SUBQ.new()
		new_subquest.quest_id = var_name
		if var_value is Dictionary:
			new_subquest.dict2subquest(var_value)
		variables[var_name] = new_subquest
		return new_subquest
	
	if var_type == "character":
		var new_character
		if var_value is Node:
			new_character = var_value

		else:
			new_character = _CHR.new()
			new_character.character_id = var_name
			if var_value is Dictionary:
				new_character.dict2character(var_value)
		variables[var_name] = new_character
		return new_character
	
	else:
		var new_var = _VAR.new()
		new_var._type = var_type
		new_var._value = var_value
		variables[var_name] = new_var
		return new_var

		
	
	