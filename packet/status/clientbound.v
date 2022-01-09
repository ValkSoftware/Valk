module status

//import util
import server

// clientbound status packet 0x00
pub struct CB_StatusResponse {
pub:
	resp	string	// json response, contains motd n stuff
}

// clientbound status packet 0x01
pub struct CB_Pong {
	l	i64		// must be the same as sent in the serverbound packet
}

pub fn create_status_response(serv &server.Server) CB_StatusResponse {
	return CB_StatusResponse { 
		'{"version":{"name":"valk 1.17.1","protocol": 756 },"players":{"max":992,"online":320},"description":{"text":"$serv.motd"},"favicon":"data:image/png;base64,$serv.icon"}'
	}
}