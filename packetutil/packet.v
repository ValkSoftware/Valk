module packetutil

pub struct GenericPacket {
pub:
	pack_size 	int
	pack_id		int
	pack_data	[]byte
}