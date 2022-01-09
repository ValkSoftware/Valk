module nbt

pub struct TagEnd {}

pub fn (mut n NBTReader) read_tag_end() TagEnd {
	n.read_byte()
	return TagEnd{}
}

pub fn (mut n NBTWriter) write_tag_end() {
	n.write_byte(0x00)
}