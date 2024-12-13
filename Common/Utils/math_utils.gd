class_name MathUtils

static func find_n_items_with_weights(items: Array, n_items: int, let_repeat_items := true) -> Array:
	assert(items.size() >= n_items, "Items must have at least n elements")
	assert("weight" in items[0], "Items must have property weight")
	# print("find_n_items_with_weights: ", items)
	var selected_items = Array()
	var possible_items = items.duplicate()
	MathUtils.array_shuffle(possible_items)
	var total_possible_items = possible_items.size()
	var total_weights := 0
	while selected_items.size() < n_items:
		if total_weights == 0 or total_possible_items != possible_items.size():
			# to avoid calculating total_weights every time if possible_items didn't change
			total_weights = possible_items.map(func(item):
				return item.weight
			).reduce(func(a, b):
				return a + b
			)
		# print("total_weights: ", total_weights, ", possible_items: ", possible_items, ", selected_items: ", selected_items)
		var random_weight_chosen = Globals.rng.randi() % total_weights
		var current_weight = 0
		var _item_idx = 0
		for item in possible_items:
			current_weight += item.weight
			if current_weight >= random_weight_chosen:
				selected_items.append(item)
				if !let_repeat_items:
					possible_items.erase(item)
				# print("selected_item_idx: ", _item_idx, ", with random_weight_chosen: ", random_weight_chosen, ", selected: ", selected_items)
				break
			_item_idx += 1
	# print("fetch_n_items_with_weights: ", selected_items)
	return selected_items

static func array_shuffle(array: Array):
	for i in array.size():
		var rand_idx = Globals.rng.randi_range(0, array.size() - 1)
		if rand_idx == i:
			pass
		else:
			var temp = array[rand_idx]
			array[rand_idx] = array[i]
			array[i] = temp

static func cartesian_distance_between_tiles(coord1: Vector2i, coord2: Vector2i) -> int:
	return abs(coord1.x - coord2.x) + abs(coord1.y - coord2.y)
