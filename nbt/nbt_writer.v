module nbt

import math
import encoding.binary

pub struct NBTWriter {
pub mut:
	data	[]byte	
}

pub fn create_nbt_writer() NBTWriter {
	return NBTWriter{}
}

pub fn (mut n NBTWriter) write_string(value string) {
	mut tmp := []byte{len: 2}
	binary.big_endian_put_u16(mut tmp, u16(value.len))
	n.data << tmp
	n.data << value.bytes()
}

pub fn (mut n NBTWriter) write_id(value byte) {
	n.data << value
}

pub fn (mut n NBTWriter) write_byte(value i8) {
	n.data << byte(value)
}

pub fn (mut n NBTWriter) write_byte_array(value []i8) {
	n.write_int(value.len)
	for i in value {
		n.write_byte(i)
	}
}

pub fn (mut n NBTWriter) write_short(value i16) {
	mut tmp := []byte{len: 2}
	binary.big_endian_put_u16(mut tmp, u16(value))
	n.data << tmp
}

pub fn (mut n NBTWriter) write_int(value int) {
	mut tmp := []byte{len: 4}
	binary.big_endian_put_u32(mut tmp, u32(value))
	n.data << tmp
}

pub fn (mut n NBTWriter) write_int_array(value []int) {
	n.write_int(value.len)
	for i in value {
		n.write_int(i)
	}
}

pub fn (mut n NBTWriter) write_long(value i64) {
	mut tmp := []byte{len: 8}
	binary.big_endian_put_u64(mut tmp, u64(value))
	n.data << tmp
}

pub fn (mut n NBTWriter) write_long_array(value []i64) {
	n.write_int(value.len)
	for i in value {
		n.write_long(i)
	}
}

pub fn (mut n NBTWriter) write_float(value f32) {
	mut tmp := []byte{len: 4}
	binary.big_endian_put_u32(mut tmp, math.f32_bits(value))
	n.data << tmp
}

pub fn (mut n NBTWriter) write_double(value f64) {
	mut tmp := []byte{len: 8}
	binary.big_endian_put_u64(mut tmp, math.f64_bits(value))
	n.data << tmp
}