module nbt

pub struct TagLongArray {
pub:
	name	string
	data	[]i64
}

pub fn (mut n NBTReader) read_tag_long_array() TagLongArray {
	return TagLongArray{
		name: n.read_string()
		data: n.read_long_array(n.read_int())
	}
}

pub fn (mut n NBTWriter) write_tag_long_array(name string, value []i64) {
	n.write_id(0x0c)
	n.write_string(name)
	n.write_long_array(value)
}