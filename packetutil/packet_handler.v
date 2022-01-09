module packetutil

import rand

import server
// packet imports
//import packetutil.packetio
import packet.login
import packet.status

pub fn handle_packet(pack GenericPacket, mut pr PacketReader, mut client &server.Client, mut serv &server.Server) {

	match client.state {

		.handshake {

			match pack.pack_id {

				0x00 {
					p := login.SB_Handshake {
						pr.read_varint(),
						pr.read_string(),
						pr.read_ushort(),
						pr.read_varint()
					}
					match p.next_state {
						1 { client.state = server.State.status }
						2 { client.state = server.State.login }
						else { /*return*/ }
					}
					return
				}
				else { /*return*/ }
			}
		}

		.status {
			
			match pack.pack_id {

				0x00 {
					mut pw := packetutil.create_packet_writer(0x00)
					pw.write_string(status.create_status_response(serv).resp)
					client.conn.write(pw.finish()) or { panic('could not send json response') }
					return
				}

				0x01 {
					mut pw := packetutil.create_packet_writer(0x01)
					pw.write_long(pr.read_long())
					client.conn.write(pw.finish()) or { panic('could not send pong') }
					return
				}

				else { }

			}

		}

		.login {

			match pack.pack_id {

				0x00 {
					p := login.SB_LoginStart {
						pr.read_string()
					}
					client.u_name = p.name
					client.uuid = rand.uuid_v4()
					client.state = server.State.play

					mut pw := packetutil.create_packet_writer(0x02) // login success, offline mode for now :nauseated_face:
					pw.write_uuid(client.uuid)
					pw.write_string(client.u_name)
					client.conn.write(pw.finish()) or { panic('failed to send login success') }
					//println('client<$client.addr> has username: $client.u_name')
					//return
				}
				
				else { /*return*/ }
			}

		}

		.play {

		}
	}

}