module login

// serverbound login packet 0x00
pub struct SB_Handshake {
pub:
	protocol_ver	int		// protocol version as int
	server_addr		string  // e.g. localhost, play.monkegame.online etc
	server_port		u16	 	// 0 to 65535
	next_state		int 	// 1 for status ping, 2 for continue with login
}

// serverbound login packet 0x00
pub struct SB_LoginStart {
pub:
	name	string
}

// serverbound login packet 0x01
pub struct SB_EncryptResp {
pub:
	secret_length	int
	secret			[]byte
	verify_length	int
	verify_token	[]byte
}