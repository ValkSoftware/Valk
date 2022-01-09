module main

import os
import log

import util
import server
import console

import packetutil

__global logger = log.Log{
		level: log.Level.info
		output_target: log.LogTarget.console
	}

fn main() {

	println('          _ _')
	println('__ ____ _| | |__')
	println('\\ V / _` | | / /')
	println(' \\_/\\__,_|_|_\\_\\')
	println('------------------')

	logger.info('starting up...')
	util.check_update_startup(mut &logger)
	logger.info('----( basic system diagnostics )----')
	logger.info('current os: $util.os.sysname $util.os.release')
	logger.info('os architecture: $util.os.machine')
	logger.info('available CPU cores: $util.cpus')
	logger.info('------------------------------------')
	logger.info('check if all files exist...')
	if util.setup_file_structure() { logger.info('created files!') } 
	logger.info('looks good! starting server...')

	mut serv := server.create_new(mut logger)
	uptime.start()

	logger.info('listening on port $serv.port')
	logger.info('welcome to valk!')

	//TODO: handle incoming traffic correctly
	go packetutil.accept_conn(mut &serv, mut &logger)
	console.console_setup()
	logger.info('exiting, BYE!')
}