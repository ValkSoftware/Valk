module nbt

pub struct TagList {
pub:
	name	string
	data	[]NBTData
}

pub fn (mut n NBTReader) read_tag_list() TagList {
	name := n.read_string()
	
	list_type := n.read_byte()
	mut data := []NBTData{cap: n.read_int()}
	match list_type {
		// end
		0x00 {
			for mut i in data {
				unsafe { *i = n.read_byte() }
			}
		}
		// byte
		0x01 {
			for mut i in data {
				unsafe { *i = n.read_byte() }
			}	
		}
		// short
		0x02 {
			for mut i in data {
				unsafe { *i = n.read_short() }
			}
		}
		// int
		0x03 {
			for mut i in data {
				unsafe { *i = n.read_int() }
			}
		}
		// long
		0x04 {
			for mut i in data {
				unsafe { *i = n.read_long() }
			}
		}
		// float
		0x05 {
			for mut i in data {
				unsafe { *i = n.read_float() }
			}
		}
		// double
		0x06 {
			for mut i in data {
				unsafe { *i = n.read_double() }
			}
		}
		// byte array
		0x07 {
			for mut i in data {
				unsafe { *i = n.read_byte_array(n.read_int()) }
			}
		}
		// string
		0x08 {
			for mut i in data {
				unsafe { *i = n.read_string() }
			}
		}
		// compound
		// 0x09 {
		// 	for mut i in data {
		// 		unsafe { *i = n.read_compound() }
		// 	}
		// }
		// int array
		0x0b {
			for mut i in data {
				unsafe { *i = n.read_int_array(n.read_int()) }
			}
		}
		// long array
		0x0c {
			for mut i in data {
				unsafe { *i = n.read_long_array(n.read_int()) }
			}
		}
		else {}
	}

	return TagList {
		name: name
		data: data
	}

}

pub fn (mut n NBTWriter) write_tag_list(name string, listdata []NBTTag) {

}