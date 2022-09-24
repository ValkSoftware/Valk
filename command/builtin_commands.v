module command

import util

fn console_about(args []string) bool {
	logger.info('-------')
	logger.info(' valk')
	logger.info(' https://github.com/ValkSoftware/Valk')
	logger.info('-------')
	return true
}

fn console_exit(args []string) bool {
	logger.info('exiting...')
	//initiate self destruc-- i mean, shutdown sequence
	exit(0)
}

fn console_version(args []string) bool {
	b, v := util.check_update(mut logger)
	logger.info('on latest: $b | latest: $v | current: $util.server_build')
	return true
}

fn console_get_uptime(args []string) bool {
	uptim3 := uptime.elapsed()
	if uptim3.seconds() < 60 { logger.info('valk has been running for ${u8(uptim3.seconds())} secs') } 
	else if uptim3.minutes() < 60{ logger.info('valk has been running for ${u8(uptim3.minutes())} mins') } 
	else { logger.info('valk has been running for ${i64(uptim3.hours())} hrs') }

	return true
}

fn console_help(args []string) bool {
	logger.info('everything is documented on the valk wiki.')
	return true
}