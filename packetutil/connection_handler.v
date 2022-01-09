module packetutil

import log

import server
//import packetutil.packetio
//import packetutil

pub fn accept_conn(mut serv server.Server, mut logger &log.Log) {
	for {
		mut conn := serv.tcp.accept() or {
			logger.error('could not receive connection')
			continue
		}
		conn.set_blocking(true) or { panic('could not set connection to blocking') }
		addr := conn.addr() or { panic('unable to get address from connection') }
		mut client := &server.Client{conn: conn, addr: addr}
		serv.clients << client
		logger.info('connection received from $addr')
		go handle_conn(mut client, mut serv, mut logger)
	}
}

[manualfree]
fn handle_conn(mut client server.Client, mut serv server.Server, mut logger log.Log) {
	mut buf := []byte{len: 2097151}
	mut byte_counter := 0
	mut pr := PacketReader{}
	for {
		byte_counter = client.conn.read(mut buf) or { 
			logger.info('client<$client.addr|$client.u_name> has disconnected')				
			serv.clients.delete(0)
			client.conn.close() or { break }
			break
		}

		if byte_counter == 0 {
			client.conn.close() or { break }
			break
		}
		
		pr = create_packet_reader(buf[..byte_counter])
		logger.info('read: ${buf[..byte_counter].str()} | size of ${byte_counter-1} bytes')

		pack_size := pr.read_varint()
		pack_id := pr.read_varint()

		mut pack := GenericPacket{}
		if pack_size == 1 {
			pack = GenericPacket{ pack_size, pack_id, []byte{} }
		} else {
			pack = GenericPacket{ pack_size, pack_id, buf[pr.index..pack_size] }
		}

		if pack.pack_size == 0 || pack.pack_size > buf.len {
			client.conn.close() or { break }
			break
		}
		packetutil.handle_packet(pack, mut &pr, mut client, mut &serv)
	}
	
	unsafe { 
		free(buf)
		free(pr)
		free(client)
	}

}