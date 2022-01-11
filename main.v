module main

import log

import util
import runner

__global logger = log.Log{
		level: log.Level.info
		output_target: log.LogTarget.console
	}

fn main() {
	
	util.parse_args()

	runner.start()

	logger.info('exiting, BYE!')
}
