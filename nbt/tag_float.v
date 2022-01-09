module nbt

pub struct TagFloat {
pub:
	name	string
	data	f32
}

pub fn (mut n NBTReader) read_tag_float() TagFloat {
	return TagFloat{
		name: n.read_string()
		data: n.read_float()
	}
}

pub fn (mut n NBTWriter) write_tag_float(name string, value f32) {
	n.write_id(0x05)
	n.write_string(name)
	n.write_float(value)
}