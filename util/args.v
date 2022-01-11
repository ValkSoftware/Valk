module util

import log
import os
import time

pub fn parse_args() {
	if os.args.len >= 2 {
		if os.args[1].starts_with('--') {

			flag := os.args[1].all_after('--')

			match flag {
				'debug' { debug_mode() } // turn on debug mode
				'china' { china_mode() } // enable 冰淇淋 mode
				else { usage() }
			} 

		} else if os.args[1].starts_with('-') {

			println('how are you too lazy to type the full flag?')

			flag := os.args[1].all_after('-')
			time.sleep(time.second * 5)
			match flag {
				'd' { debug_mode() }
				'c'	{ china_mode() }
				else { usage() }
			}
		} else {
			usage()
		}
	}
}

fn debug_mode() { 
	logger.set_output_level(log.Level.debug)
	logger.debug('debug mode: enabled')
}

fn china_mode() { } // wip

fn usage() {
	eprintln('unrecognized option! head to the wiki for more info.')
	exit(1)
}