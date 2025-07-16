extends GutTest

var sut: Ship

func before_each():
    sut = Ship.new()

func after_each():
    sut.free()

func test_ship_starts_without_shots():
    assert_eq(sut.num_shots, 0)

func test_perform_shoot_increases_num_shots():
    sut.perform_shoot()

    assert_gt(sut.num_shots, 0)