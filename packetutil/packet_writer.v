module packetutil

import encoding.binary
import math

import util

[heap]
pub struct PacketWriter {
pub mut:
	length	int
	pack_id	int
	data	[]byte
}

pub fn create_packet_writer(pack_id int) PacketWriter {
	mut pw := PacketWriter {
		pack_id: pack_id
	}
	pw.write_varint(pack_id)
	return pw
}

pub fn (mut p PacketWriter) write_varint(value int) {

	mut v := value
	mut arr := []byte{}
	mut v2 := byte(0)

	for {
		v2 = byte(v & 0x7F)
		v = v >> 7
		if v != 0 { v2 |= 0x80 }
		arr << v2
		if v == 0 { break } 
	}

	p.data << arr
	p.length += arr.len

}

pub fn (mut p PacketWriter) write_varlong(value i64) {

	mut v := value
	mut arr := []byte{}
	mut v2 := byte(0)

	for {
		v2 = byte(v & 0x7F)
		v = v >> 7
		if v != 0 { v2 |= 0x80 }
		arr << v2
		if v == 0 { break } 
	}

	p.data << arr
	p.length += arr.len

}

pub fn (mut p PacketWriter) write_byte(value i8) {
	p.write_ubyte(byte(value))
}

pub fn (mut p PacketWriter) write_ubyte(value byte) {
	p.data << value
	p.length++
}

pub fn (mut p PacketWriter) write_short(value i16) {
	p.write_ushort(u16(value))
}

pub fn (mut p PacketWriter) write_ushort(value u16) {
	mut tmp := []byte{len:2}
	binary.big_endian_put_u16(mut tmp, value)
	p.data << tmp
	p.length += 2
}

pub fn (mut p PacketWriter) write_int(value int) {
	p.write_uint(u32(value))
}

pub fn (mut p PacketWriter) write_uint(value u32) {
	mut tmp := []byte{len:4}
	binary.big_endian_put_u32(mut tmp, value)
	p.data << tmp
	p.length += 4
}

pub fn (mut p PacketWriter) write_long(value i64) {
	p.write_ulong(u64(value))
}

pub fn (mut p PacketWriter) write_ulong(value u64) {
	mut tmp := []byte{len:8}
	binary.big_endian_put_u64(mut tmp, value)
	p.data << tmp
	p.length += 8
}

pub fn (mut p PacketWriter) write_ubyte_array(arr []byte) {
	p.data << arr
}

pub fn (mut p PacketWriter) write_bool(value bool) {
	if value { p.data << 0x01 }
	else { p.data << 0x00 }
}

pub fn (mut p PacketWriter) write_float(value f32) {
    p.write_uint(math.f32_bits(value))
}

pub fn (mut p PacketWriter) write_double(value f64) {
    p.write_ulong(math.f64_bits(value))
}

pub fn (mut p PacketWriter) write_string(value string) {
	p.write_varint(value.len)
	p.data << value.bytes()
}

pub fn (mut p PacketWriter) write_uuid(value string) {
	p.data << util.uuid_v4_as_bytes(value)
	p.length += 16
}

pub fn (mut p PacketWriter) finish() []byte { 
	mut temp := p.data.clone()
	p.data.clear()
	p.write_varint(temp.len)
	p.data << temp
	return p.data
}