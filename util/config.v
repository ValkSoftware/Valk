module util

import os
import toml

const (
	//this is the correct way to use constants... right?
	config_content = 
'# this is the main configuration file for Valk.
# https://github.com/Valksoteric/valk
# to find out what the configuration options do, head over to the wiki!
# you can find the wiki at https://github.com/Valksoteric/valk/wiki

[net]
port = 25565

[server]
motd = "This server is running on Valk!"
icon = "sample_image_name.png"
max_players = 20

[world]
seed = ""
enable_end = true
enable_nether = true'
)

pub fn get_config() toml.Doc {

	mut conf := ''
	
	$if windows { conf = os.read_file('${root_folder_win}config.toml') or { panic('failed to load config') } } 
	$else { conf = os.read_file('${root_folder_nix}config.toml') or { panic('failed to load config') } }
	
	return toml.parse_text(conf) or { panic('failed to decode config, check if you\'ve not accidentally made a typo!') }
}

fn setup_config() bool {

	mut config_path := ''

	$if windows { config_path = '${root_folder_win}config.toml' } 
	$else { config_path = '${root_folder_nix}config.toml' }

	if !os.exists(config_path) {
		os.create(config_path) or { panic('could not create config') }
		os.write_file(config_path, config_content) or { panic('could not write to config') }
		return true
	}
	return false
}