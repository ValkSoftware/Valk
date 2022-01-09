module command

pub struct Command {
pub:
	args	[]string
	name	string
}

__global command_map = map[string]fn (args []string) bool

// registers a command.
// `name` - the name of the command
// `exec_fn` - name of the function to be ran when your command is called. 
// should take a []string as argument and return a bool.
pub fn register_command(name string, exec_fn fn (args []string) bool) {
	command_map[name] = exec_fn
}

// registers an alias for a command. requires the command to be registered already.
// `name` - the name of the command to be aliased
// `alias` - the alias
pub fn register_command_alias(name string, alias string) {
	command_map[alias] = command_map[name]
}

pub fn run_command_fn(c Command) bool {
	// if the command is not found, return false so we know something went wrong
	command_fn := command_map[c.name] or { 
		logger.error('unknown command.')
		return false
	}
	return command_fn(c.args) 
}