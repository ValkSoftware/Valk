module util

import log
import net.http
import v.vmod
import x.json2

pub const (
	vmod_file = vmod.decode(@VMOD_FILE) or { panic(err) }
	server_build = vmod_file.version
)

pub fn check_update(mut logger log.Log) (bool, string) {
 
	resp := json2.raw_decode(http.get_text('https://api.github.com/repos/valksoteric/valk/releases/latest')) or { 
		logger.warn('could not pull version info! below info might not be true')
		return true, server_build
	}

	resp_map := resp.as_map()
	version_info := resp_map['tag_name'] or { server_build }.str()

	if version_info != server_build { return false, version_info }
	else { return true, server_build }

}

pub fn check_update_startup(mut logger log.Log) {
	is_latest, version := check_update(mut logger)

	if is_latest { 
		logger.info('this server is running the latest version')
		logger.info('current server version: $version')
	} else {
		logger.warn('you are running on an outdated version of valk!')
		logger.warn('latest: $version | current: $server_build')
	}
}