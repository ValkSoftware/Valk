module nbt

pub struct TagIntArray {
pub:
	name	string
	data	[]int
}

pub fn (mut n NBTReader) read_tag_int_array() TagIntArray {
	return TagIntArray{
		name: n.read_string()
		data: n.read_int_array(n.read_int())
	}
}

pub fn (mut n NBTWriter) write_tag_int_array(name string, value []int) {
	n.write_id(0xb)
	n.write_string(name)
	n.write_int_array(value)
}