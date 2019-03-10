# UDP server example
# Author: Ori Novanda
#
# Created for the RoDIYO group (https://www.facebook.com/groups/376640383160113/)
# Tested on Godot 3.0.6

extends SceneTree

var thread
var toClose = false
signal incoming(socket, data)

func _init(ip, port):
	thread = Thread.new()
	var args = [ip, port]
	thread.start(self, "listener", args)

func listener(args):
	var ip = args[0]
	var port = args[1]

	var socket = PacketPeerUDP.new()
	if(socket.listen(port, ip) != OK):
		print("Unable to listen on ", ip, ":", port)
		toClose = true;
	else:
		print("Listening on ", ip, ":", port)

	while(toClose != true):
		if(socket.get_available_packet_count() > 0):
			var data = socket.get_packet()
			emit_signal("incoming", socket, data)
	socket.close()        
