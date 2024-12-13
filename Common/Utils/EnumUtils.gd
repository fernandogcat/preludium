class_name EnumUtils

static func get_string_name_from_value(enum_type: Dictionary, value: int, is_enum_sequential:=false) -> String:
	if is_enum_sequential:
		return enum_type.keys()[value]
	else:
		for key in enum_type.keys():
			if enum_type[key] == value:
				return key
		assert(false, "EnumUtils.get_string_name_from_value: value not found in enum " + str(value))
		return ""

static func get_enum_by_string(enum_type: Dictionary, value: String) -> int:
	if enum_type.has(value):
		return enum_type[value]
	else:
		assert(false, "EnumUtils.get_enum_by_string: value not found in enum " + value)
		return -1