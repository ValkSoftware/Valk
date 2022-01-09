module nbt

pub struct TagShort {
pub: 
	name	string
	data	i16
}

pub fn (mut n NBTReader) read_tag_short() TagShort {
	return TagShort {
		name: n.read_string()
		data: n.read_short()
	}
}

pub fn (mut n NBTWriter) write_tag_short(name string, value i16) {
	n.write_id(byte(0x02))
	n.write_string(name)
	n.write_short(value)
}