module login

// clientbound login packet 0x00
pub struct CB_Disconnect {
	reason		string	// chat component
}

// clientbound login packet 0x01
pub struct CB_EncryptRequest {
	srv_id		string
	pubkey_len	int
	pubkey_dat	[]byte
	vertok_len	int
	vertok_dat	[]byte
}

// clientbound login packet 0x02
pub struct CB_LoginSuccess {
	uuid	string
	u_name	string
}