module main

import log

import runner

__global logger = log.Log{
		level: log.Level.info
		output_target: log.LogTarget.console
	}

fn main() {

	println('-------------------------------------------')
	println('   █ █')
	println('  ██ ██    Valk Software\'s valk.')
	println('  █   █    Eagle-eyed perfection.')
	println(' ██ █ ██')
	println('  █   █    © 2021-2022 Valk Software')
	println('  ██ ██    This program is licensed under the AGPL license.')
	println('   █ █     A copy of it should have come with this release.')
	println('-------------------------------------------')
	
	runner.start()

	logger.info('exiting, BYE!')
}
