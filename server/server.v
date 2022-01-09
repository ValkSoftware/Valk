module server

import os
import log
import net
import toml
import encoding.base64

import util

[heap]
pub struct Server {
//mut:
pub:
	port		int
	icon		string
	conf		toml.Doc
pub mut:
	tcp			net.TcpListener
	clients		[]Client
	motd		string
}

const (
	bad_file_name = 'can\'t find your server icon! check if you typed the file name correct and included the file extension!'
)

pub fn create_new(mut logger log.Log) Server {
	conf := util.get_config()

	port := conf.value('net.port').int()
	motd := conf.value('server.motd').string()

	return Server{
		port: port
		icon: hash_image_to_base64(conf.value('server.icon').string(), mut logger) or {""}
		conf: conf
		tcp: net.listen_tcp(net.AddrFamily.ip, '0.0.0.0:$port') or { 
			logger.fatal('could not start to listen on port $port, check if a different program is using this port!')
			panic(err)
		} 
		motd: motd
	}
}

fn hash_image_to_base64(img_name string, mut logger log.Log) ?string {
	if img_name != '' {
		mut img := []byte{}
		if os.user_os() == 'windows' { 
			img = os.read_bytes('${util.root_folder_win}$img_name') or { 
				logger.error(bad_file_name)
				return none
			} 
		} else { 
			img = os.read_bytes('${util.root_folder_nix}$img_name') or { 
				logger.error(bad_file_name) 
				return none
			} 
		}
		return base64.encode(img)
	}
	return none
}