module nbt

pub struct TagByte {
pub: 
	name	string
	data	i8
}

pub fn (mut n NBTReader) read_tag_byte() TagByte {
	return TagByte {
		name: n.read_string()
		data: n.read_byte()
	}
}

pub fn (mut n NBTWriter) write_tag_byte(name string, data i8) {
	n.write_id(byte(0x01))
	n.write_string(name)
	n.write_byte(data)
}