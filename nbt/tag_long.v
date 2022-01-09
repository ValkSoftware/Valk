module nbt

pub struct TagLong {
pub:
	name	string
	data	i64
}

pub fn (mut n NBTReader) read_tag_long() TagLong {
	return TagLong{
		name: n.read_string()
		data: n.read_long()
	}
}

pub fn (mut n NBTWriter) write_tag_long(name string, value i64) {
	n.write_id(byte(0x04))
	n.write_string(name)
	n.write_long(value)
}