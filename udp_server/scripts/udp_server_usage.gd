# UDP server usage example
# Author: Ori Novanda
#
# Created for the RoDIYO group (https://www.facebook.com/groups/376640383160113/)
# Tested on Godot 3.0.6

extends Node

func _ready():
	var th = load("res://udp_server.gd")
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
