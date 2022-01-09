module nbt

pub struct TagByteArray {
pub:
	name	string
	data	[]i8
}

pub fn (mut n NBTReader) read_tag_byte_array() TagByteArray {
	return TagByteArray {
		name: n.read_string()
		data: n.read_byte_array(n.read_int())
	}
}

pub fn (mut n NBTWriter) write_tag_byte_array(name string, value []i8) {
	n.write_id(0x07)
	n.write_string(name)
	n.write_byte_array(value)
}