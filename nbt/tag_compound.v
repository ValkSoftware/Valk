module nbt

pub struct TagCompound {
	name	string
	data	[]NBTTag
}

pub fn (mut n NBTReader) read_tag_compound() TagCompound {

	compound_name := n.read_string()
	
	

	return TagCompound{compound_name}
}

pub fn (mut n NBTWriter) write_tag_compound() {

}