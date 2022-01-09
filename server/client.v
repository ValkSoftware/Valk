module server

import net

pub enum State {
	handshake
	status
	login
	play
}

[heap]
pub struct Client {
pub:
	addr	net.Addr	
pub mut:
	conn	net.TcpConn
	u_name	string
	uuid	string
	state	State
}