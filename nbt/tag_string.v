module nbt

pub struct TagString {
	name	string
	data	string
}

pub fn (mut n NBTReader) read_tag_string() TagString {
	return TagString {
		name: n.read_string()
		data: n.read_string()
	}
}

pub fn (mut n NBTWriter) write_tag_string(name string, value string) {
	n.write_id(byte(0x08))
	n.write_string(name)
	n.write_string(value)
}