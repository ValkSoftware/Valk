module nbt

// the type ID is in the comment
pub enum NBTTagType {
	tag_end			//0 only ever used at the end of tag_compound
	tag_byte		//1 i8
	tag_short		//2	i16
	tag_int			//3 int
	tag_long		//4 i64
	tag_float		//5 f32
	tag_double		//6 f64
	tag_byte_array	//7	[]i8
	tag_string		//8	string prefixed by a u16 which defines its length
	tag_list		//9	list of nameless (name = '') tags of the same type
	tag_compound	//10 a list of NAMED tags
	tag_int_array	//11 []int
	tag_long_array	//12 []i64
}

// these are added in no particular order since it doesn't matter :D
pub type NBTTag = TagString | TagByte | TagShort | TagCompound | TagLong | TagInt | TagByteArray | TagFloat | TagDouble | TagLongArray | TagIntArray | TagEnd | TagList
pub type NBTData = string | i8 | i16 | int | i64 | f32 | f64 | []i8 | []int | []i64