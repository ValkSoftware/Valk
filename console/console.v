module console

import command
import readline

pub fn console_setup() {
	command.register_command('stop', command.console_exit)
	command.register_command_alias('stop', 'exit')
	command.register_command('about', command.console_about)
	command.register_command('version', command.console_version)
	command.register_command('uptime', command.console_get_uptime)
	command.register_command('help', command.console_help)
	console_read()
}

fn console_read() {
	mut r := readline.Readline{}
	for {
		console_respond(r.read_line('> ') or { '' }) 
	}
}

fn console_respond(comm string) {

	com := comm.trim_space()
	args := com.split(' ')

	name := args[0]

	mut command_args := []string{}
	if args.len > 1 { command_args = args[1..args.len] } 
	else { command_args = []string{} }

	no_errors := command.run_command_fn(command.Command{
		command_args,	// actual arguments
		name			// name of command
	})

	if !no_errors {
		logger.error('something went wrong running command: $com')
	}
}