module util

import net.http
import x.json2
import os

// check if the license file exists
// if not, pull it and create a file.
pub fn license() bool {
	mut license_path := ''

	$if windows { license_path = '${root_folder_win}LICENSE' }
	$else { license_path = '${root_folder_nix}LICENSE' }

	if !os.exists(license_path) {
		os.create(license_path) or { panic('could not write LICENSE file') }
		resp := http.get('https://api.github.com/licenses/agpl-3.0') or { panic('could not make HTTP request to the GitHub API, check your firewall.') }

		resp_json := json2.raw_decode(resp.text) or { panic('failed to decode api response') }

		mapped_resp := resp_json.as_map()
		license := mapped_resp['body'] or { panic('no valid field found in GitHub\'s API response while getting license info')}
		os.write_file(license_path, license.str()) or { panic('failed to write LICENSE file') }

		return false

	}

	return true
}