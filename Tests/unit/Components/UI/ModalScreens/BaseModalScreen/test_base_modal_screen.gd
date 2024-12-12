extends GutTest

var sut: BaseModalScreen

func before_each():
    sut = BaseModalScreen.new()
    add_child_autofree(sut)

func test_is_showing_is_false_initially():
    assert_false(sut.is_showing())

func test_show_modal_screen_makes_it_visible():
    sut.show_modal_screen(true)
    assert_true(sut.is_showing())

func test_show_modal_screen_and_hide_modal_screen():
    sut.show_modal_screen(true)
    sut.show_modal_screen(false)
    assert_false(sut.is_showing())

func test_show_modal_disables_process_input():
    # initially it not shown and is not processing input
    assert_false(sut.is_processing_input())

    # show modal screen and it should be processing input
    sut.show_modal_screen(true)
    assert_true(sut.is_processing_input())

    # hide modal screen and it should not be processing input
    sut.show_modal_screen(false)
    assert_false(sut.is_processing_input())

func test_input_pressed_close_modal_screen():
    watch_signals(sut)

    sut.show_modal_screen(true)
    assert_true(sut.is_showing())

    var sender = InputSender.new(sut)
    sender.action_down("key_exit")

    assert_signal_emit_count(sut, 'on_closed', 1)

    sender.release_all()
    sender.clear()