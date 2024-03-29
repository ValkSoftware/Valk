module tests

import nbt

fn test_write_tag_byte() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_byte('v', 1)
	assert nw.data == [u8(0x01), 0x00, 0x01, 0x76, 0x01]
}

fn test_write_tag_short() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_short('v', 16)
	assert nw.data == [u8(0x02), 0x00, 0x01, 0x76, 0x00, 0x10]
}

fn test_write_tag_int() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_int('v', 16)
	assert nw.data == [u8(0x03), 0x00, 0x01, 0x76, 0x00, 0x00, 0x00, 0x10]
}

fn test_write_tag_long() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_long('v', 16)
	assert nw.data == [u8(0x04), 0x00, 0x01, 0x76, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10]
}

fn test_write_tag_float() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_float('v', f32(0.1))
	assert nw.data == [u8(0x05), 0x00, 0x01, 0x76, 0x3d, 0xcc, 0xcc, 0xcd]
}

fn test_write_tag_double() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_double('t', f64(0.1))
	assert nw.data == [u8(0x06), 0x00, 0x01, 0x74, 0x3f, 0xb9, 0x99, 0x99, 0x99, 0x99, 0x99, 0x9a]
}

fn test_write_tag_byte_array() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_byte_array('v', [i8(1), 1, 1, 16])
	assert nw.data == [u8(0x07), 0x00, 0x01, 0x76, 0x00, 0x00, 0x00, 0x04, 0x01, 0x01, 0x01, 0x10]
}

fn test_write_tag_string() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_string('v', 'lang')
	assert nw.data == [u8(0x08), 0x00, 0x01, 0x76, 0x00, 0x04, 0x6c, 0x61, 0x6e, 0x67]
}

fn test_write_tag_int_array() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_int_array('v', [int(1), 1])
	assert nw.data == [u8(0x0b), 0x00, 0x01, 0x76, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01]
}

fn test_write_tag_long_array() {
	mut nw := nbt.create_nbt_writer()
	nw.write_tag_long_array('v', [i64(1), 1])
	assert nw.data == [u8(0x0c), 0x00, 0x01, 0x76, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 0x01]
}