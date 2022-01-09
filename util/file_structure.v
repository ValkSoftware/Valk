module util

import os
import runtime

pub const (
	root_folder_win = os.executable().all_before('valk.exe')
	root_folder_nix = os.executable().all_before_last('valk')
	os = os.uname()
	cpus = runtime.nr_cpus()
)

pub fn setup_file_structure() bool {
	return setup_config() || license()
}