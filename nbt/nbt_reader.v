module nbt

import math
import encoding.binary

pub struct NBTReader {
pub mut:
	index	int
	length	int
	data	[]byte
}

pub fn create_nbt_reader(data []byte) NBTReader {
	return NBTReader {
		0
		data.len
		data
	}
}

pub fn (mut n NBTReader) read_ubyte() byte {
    if n.check_end_with_offset(1) { return 9 } // 9 = nein
    b := n.data[n.index]
    n.seek(1) or { panic('somehow the packet managed to slip past 2 checks') }
    return b
}

pub fn (mut n NBTReader) read_byte() i8 {
    return i8(n.read_ubyte())
}

pub fn (mut n NBTReader) read_ushort() u16 {
    if n.check_end_with_offset(2) { return 0 }
    us := binary.big_endian_u16(n.data[n.index..n.index+2])
    n.seek(2) or { panic('somehow the packet managed to slip past 2 checks') }
    return us
}

pub fn (mut n NBTReader) read_short() i16 {
    return i16(n.read_ushort())
}

pub fn (mut n NBTReader) read_int() int {
    if n.check_end_with_offset(4) { return 0 }
    us := binary.big_endian_u32(n.data[n.index..n.index+4])
    n.seek(4) or { panic('somehow the packet managed to slip past 2 checks') }
    return int(us)
}

pub fn (mut n NBTReader) read_int_array(len int) []int {
    mut tmp := []int{cap: len}
    for _ in tmp {
        tmp << n.read_int()
    }
    return tmp
}

pub fn (mut n NBTReader) read_long() i64 {
    if n.check_end_with_offset(8) { return 0 }
    us := binary.big_endian_u64(n.data[n.index..n.index+8])
    n.seek(8) or { panic('somehow the packet managed to slip past 2 checks') }
    return i64(us)
}

pub fn (mut n NBTReader) read_long_array(len int) []i64 {
    mut tmp := []i64{cap: len}
    for _ in tmp {
        tmp << n.read_long()
    }
    return tmp
}

pub fn (mut n NBTReader) read_string() string {
	if n.check_end() { return '' }
	
	string_size:= n.read_ushort()

	if n.check_end() { return '' }
	if string_size < 0 { return '' }
	if n.check_end_with_offset(string_size) { return '' }

	string_val := n.data[n.index..n.index+string_size].bytestr()

    n.seek(string_size) or { panic('Could not seek to stringsize! $string_size') }
	return string_val
}

pub fn (mut n NBTReader) read_byte_array(len int) []i8 {
    mut temp := []i8{cap: len}
    for x in n.data[n.index..n.index+len] {
        temp << i8(x)
    }
    return temp
}

pub fn (mut n NBTReader) read_float() f32 {
    if n.check_end_with_offset(4) { return f32(0.0) }
    return math.f32_from_bits(u32(n.read_int()))
}

pub fn (mut n NBTReader) read_double() f64 {
    if n.check_end_with_offset(8) { return f64(0.0) }
    return math.f64_from_bits(u64(n.read_long()))
}

// check if the packetreader is at the end of packet
pub fn (mut n NBTReader) check_end() bool {
    return n.index > n.length
}

// seek forward by `offset` bytes.
// returns true if it reaches (past) the end.
pub fn (mut n NBTReader) check_end_with_offset(offset int) bool {
    if offset > 0 { return n.index + offset > n.length }
    return true
}

// increases the index by offsest
pub fn (mut n NBTReader) seek(offset int) ? {
    if !n.check_end_with_offset(offset) {
        n.index += offset
        return
    }
    return error('could not seek further')
}