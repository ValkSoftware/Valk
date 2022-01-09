module nbt

pub struct TagDouble {
pub:
	name	string
	data	f64
}

pub fn (mut n NBTReader) read_tag_double() TagDouble {
	return TagDouble{
		name: n.read_string()
		data: n.read_double()
	}
}

pub fn (mut n NBTWriter) write_tag_double(name string, value f64) {
	n.write_id(0x06)
	n.write_string(name)
	n.write_double(value)
}