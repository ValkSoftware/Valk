module packetutil

import encoding.binary
import math

// all is mutable to reduce on object creations
// so yes, giving each connection a single packetreader
[heap]
pub struct PacketReader {
mut:
    data    []byte
    length  int
pub mut:    
    index   int
}

// the bulk of this was written with the help of the amazing
// LethalEthan. check out his github (https://github.com/LethalEthan)

pub fn create_packet_reader(data []byte) PacketReader {
    //ethan you may not PR a fix for this
    return PacketReader {
        data,
        data.len,
        0
    }
}

pub fn (mut p PacketReader) read_varint() int {

    if p.check_end() { return 9 } // 9 = nein

	mut value := 0
    mut bit_offset := 0
    mut current_byte := p.read_ubyte()

	for {
		if bit_offset == 5 { panic("varint is too big") }
        value |= (current_byte & 0b01111111) << bit_offset * 7
        bit_offset++
        if (current_byte & 0x80) == 0 { break }
        current_byte = p.read_ubyte()
	}

    return value
    
}

pub fn (mut p PacketReader) read_varlong() i64 {

    if p.check_end() { return 9 } // 9 = nein

	mut value := 0
    mut bit_offset := 0
    mut current_byte := p.read_ubyte()

	for {
		if bit_offset == 10 { panic("varlong is too big") }
        value |= (current_byte & 0b01111111) << bit_offset * 7
        bit_offset++
        if (current_byte & 0x80) == 0 { break }
        current_byte = p.read_ubyte()
	}

    return value
    
}

pub fn (mut p PacketReader) read_boolean() bool {
    return p.read_ubyte() > 0x00
}

pub fn (mut p PacketReader) read_ubyte() byte {
    if p.check_end_with_offset(1) { return 9 } // 9 = nein
    b := p.data[p.index]
    p.seek(1) or { panic('somehow the packet managed to slip past 2 checks') }
    return b
}

pub fn (mut p PacketReader) read_byte() i8 {
    return i8(p.read_ubyte())
}

pub fn (mut p PacketReader) read_ushort() u16 {
    if p.check_end_with_offset(2) { return 0 }
    us := binary.big_endian_u16(p.data[p.index..p.index+2])
    p.seek(2) or { panic('somehow the packet managed to slip past 2 checks') }
    return us
}

pub fn (mut p PacketReader) read_short() i16 {
    return i16(p.read_ushort())
}

pub fn (mut p PacketReader) read_uint() u32 {
    if p.check_end_with_offset(4) { return 0 }
    us := binary.big_endian_u32(p.data[p.index..p.index+4])
    p.seek(4) or { panic('somehow the packet managed to slip past 2 checks') }
    return us
}

pub fn (mut p PacketReader) read_int() int {
    return int(p.read_uint())
}

pub fn (mut p PacketReader) read_long() i64 {
    return i64(p.read_ulong())
}

pub fn (mut p PacketReader) read_ulong() u64 {
    if p.check_end_with_offset(8) { return 0 }
    us := binary.big_endian_u64(p.data[p.index..p.index+8])
    p.seek(8) or { panic('somehow the packet managed to slip past 2 checks') }
    return us
}

pub fn (mut p PacketReader) read_string() string {
	if p.check_end() { return '' }
	
	string_size:= p.read_varint()
	if p.check_end() { return '' }
	
	if string_size < 0 { return '' }

	if p.check_end_with_offset(string_size) { return '' }
	
	string_val := p.data[p.index..p.index+string_size].bytestr()

    p.seek(string_size) or { panic('Could not seek to stringsize! $string_size') }
	return string_val
}

pub fn (mut p PacketReader) read_ubyte_array(len int) []byte {
    if p.check_end_with_offset(len) || p.check_end() { return [byte(0),0] }
    arr := p.data[p.index..p.index+len]
    p.seek(len) or { return [byte(0),0] }
    return arr 
}

pub fn (mut p PacketReader) read_float() f32 {
    if p.check_end_with_offset(4) { return f32(0.0) }
    return math.f32_from_bits(u32(p.read_int()))
}

pub fn (mut p PacketReader) read_double() f64 {
    if p.check_end_with_offset(8) { return f64(0.0) }
    return math.f64_from_bits(u64(p.read_long()))
}

// check if the packetreader is at the end of packet
pub fn (mut p PacketReader) check_end() bool {
    return p.index > p.length
}

// seek forward by `offset` bytes.
// returns true if it reaches (past) the end.
pub fn (mut p PacketReader) check_end_with_offset(offset int) bool {
    if offset > 0 { return p.index + offset > p.length }
    return true
}

// increases the index by offsest
pub fn (mut p PacketReader) seek(offset int) ? {
    if !p.check_end_with_offset(offset) {
        p.index += offset
        return
    }
    return error('could not seek further')
}