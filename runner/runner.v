module runner

import console
import packetutil
import server
import util

pub fn start() {

	println('-------------------------------------------')
	println('   █ █')
	println('  ██ ██    Valk Software\'s valk.')
	println('  █   █    Eagle-eyed perfection.')
	println(' ██ █ ██')
	println('  █   █    © 2021-2022 Valk Software')
	println('  ██ ██    This program is licensed under the AGPLv3 license.')
	println('   █ █     A copy of it should have come with this release.')
	println('-------------------------------------------')

	logger.info('starting up...')

	util.check_update_startup(mut &logger)

	logger.info('----( basic system diagnostics )----')
	logger.info('current os: $util.os.sysname $util.os.release')
	logger.info('os architecture: $util.os.machine')
	logger.info('available CPU cores: $util.cpus')
	logger.info('------------------------------------')
	logger.debug('check if all files exist...')

	if util.setup_file_structure() { logger.debug('created files!') }
	logger.info('starting server...')

	mut serv := server.create_new(mut logger)
	uptime.start()

	logger.info('listening on port $serv.port')
	logger.info('welcome to valk!')

	go packetutil.accept_conn(mut &serv, mut &logger)
	console.console_setup()
}
