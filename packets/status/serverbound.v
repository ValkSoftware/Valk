module status

// status request packet 0x00
pub struct SB_Request { } // this packet has no fields

// status request packet 0x01
pub struct SB_Ping {
	l 	i64		// value we need to send back in CB_Pong
}