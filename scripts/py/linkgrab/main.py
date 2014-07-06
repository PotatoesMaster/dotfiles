#!/bin/env python
import sys
import os

import linkgrab.grabber as grabber
from linkgrab.exceptions import *

settings = grabber.settings

def parse_arguments():
	import argparse

	parser = argparse.ArgumentParser(
			description='linkgrab, a customizable downloader (version 0.0.2)')
	parser.add_argument(
			'urls', metavar='url', nargs='*', type=str,
			help='urls to operate onto')
	parser.add_argument(
			'-n', '--dry-run', action='store_true',
			help='Do not download files, only list them on standard output')
	parser.add_argument(
			'-l', '--show-loaded-plugins', action='store_true',
			help='Show loaded plugins')
	parser.add_argument(
			'-c', '--confdir', metavar='configdir', type=str,
			help='configuration directory to use')
	parser.add_argument(
			'-o', '--options', metavar='option', nargs='+', type=str,
			help='option pairs (eg. "dl_dir=~/download")')

	return parser.parse_args()


def load_plugins():
	try:
		plugindir = settings['confdir']
		plugins = [p[:-3] for p in os.listdir(plugindir) \
				if p.endswith('.py') and not p.startswith('_')]
	except:
		pass
	else:
		if not os.path.exists(os.path.join(plugindir, '__init__.py')):
			f = open(os.path.join(plugindir, '__init__.py'), 'w')
			f.close()

		for plugin in sorted(plugins):
			module = __import__(plugin)
			if settings['show_loaded_plugins']:
				print('Loaded', module)
			settings.update(module.plugin_settings)
			grabber.associate(module.plugin_associations)


def main():
	args = parse_arguments()

	confdir = args.confdir
	if not confdir:
		if 'XDG_CONFIG_HOME' in os.environ and os.environ['XDG_CONFIG_HOME']:
			confdir = os.environ['XDG_CONFIG_HOME'] + '/linkgrab'
		else:
			confdir = '/home/tharek/.config/linkgrab'

	sys.path.insert(0, confdir)

	settings['confdir'] = confdir
	settings['show_loaded_plugins'] = args.show_loaded_plugins

	if args.dry_run:
		settings['dry_run'] = True
		print('Dry-run mode: no file will be downloaded.')

	load_plugins()

	if args.options:
		for opt in args.options:
			split_opt = opt.split('=', 1)
			settings[split_opt[0]] = split_opt[1]

	if args.urls:
		for url in args.urls:
			grabber.add(url=url)
		try:
			grabber.grab()
		except LinkgrabException as e:
			print("{}: {}".format(e.__class__.__name__, e))
			os._exit(1)
	else:
		print('Nothing to do.')

if __name__ == '__main__':
	main()
