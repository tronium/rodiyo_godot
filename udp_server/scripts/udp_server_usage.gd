# UDP server usage example
# Author: Ori Novanda
#
# Created for the RoDIYO group (https://www.facebook.com/groups/376640383160113/)
# Tested on Godot 3.0.6

extends Node

func _ready():
	var th = load("res://scripts/udp_server.gd")
	var svr = th.new("0.0.0.0", 8099)
	svr.connect("incoming", self, "consume")

var i = 0
func consume(s, m):

	var clientIP = s.get_packet_ip()
	var clientPort = s.get_packet_port()

	s.set_dest_address(clientIP, clientPort)
	var reply = "OK\n".to_ascii()
	s.put_packet(reply)

	print("count: ", i, " - data: ", m.get_string_from_ascii())
	i = i + 1

	#return

	if m.get_string_from_ascii() == "0":
		call_deferred("emulate_left_mouse_press")
	else:
		call_deferred("emulate_left_mouse_release")

func emulate_left_mouse_press():
	var mb = InputEventMouseButton.new()
	mb.set_button_index(1)
	mb.set_pressed(true)
	Input.parse_input_event(mb)

func emulate_left_mouse_release():
	var mb = InputEventMouseButton.new()
	mb.set_button_index(1)
	mb.set_pressed(false)
	Input.parse_input_event(mb)
