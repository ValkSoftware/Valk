module nbt

pub struct TagInt {
pub:
	name	string
	data	int
}

pub fn (mut n NBTReader) read_tag_int() TagInt {
	return TagInt{
		name: n.read_string()
		data: n.read_int()
	}
}

pub fn (mut n NBTWriter) write_tag_int(name string, value int) {
	n.write_id(byte(0x03))
	n.write_string(name)
	n.write_int(value)
}