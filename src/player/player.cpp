#include "player.hpp"
#include "godot_cpp/classes/sprite2d.hpp"
#include "godot_cpp/core/print_string.hpp"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/input.hpp>

using namespace godot;

void Player::_bind_methods() {
    // expose to editor/scripting if needed later, e.g.:
    // ClassDB::bind_method(D_METHOD("get_speed"), &Player::get_speed);
}

Player::Player() {}
Player::~Player() {}


void Player::_ready() {
	sprite = get_node<Sprite2D>("Sprite2D");
	print_line("ready is working good");
}


void Player::_physics_process(double delta) {
    Input *input = Input::get_singleton();

    Vector2 velocity = Vector2();
    velocity.x = input->get_axis("ui_left", "ui_right");
    velocity.y = input->get_axis("ui_up", "ui_down");

	if (velocity.x != 0){
		sprite->set_flip_h(velocity.x < 0);
		print_line(velocity.x);
	}

    if (velocity.length() > 0) {
        velocity = velocity.normalized() * speed;
    }

    set_velocity(velocity);
    move_and_slide();
}

