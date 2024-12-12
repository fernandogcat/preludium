extends GutTest

var sut: Ship

var input_sender = InputSender.new(Input)

func before_each():
    sut = Ship.new()

func after_each():
    sut.free()

func test_ship_starts_without_shots():
    assert_eq(sut.num_shots, 0)


func test_perform_shoot_increases_num_shots():
    sut.perform_shoot()

    assert_gt(sut.num_shots, 0)

func test_check_shoot_no_input_no_shoots():
    input_sender.release_all()
    input_sender.clear()

    sut.check_input_shoot()

    assert_eq(sut.num_shots, 0)

func test_check_input_shoot_increases_num_shoots():
    input_sender.release_all()
    input_sender.clear()

    input_sender.action_down("shoot")
    sut.check_input_shoot()

    assert_gt(sut.num_shots, 0)
