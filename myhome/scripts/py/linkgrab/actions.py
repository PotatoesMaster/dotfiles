import re
from os.path import join, basename, exists
from os import makedirs
import urllib.request
from urllib.error import URLError
from urllib.parse import urlparse
from shutil import copyfileobj

from linkgrab.grabber import settings
from linkgrab.exceptions import *

_opener = urllib.request.build_opener()

def get_content(url):
	#print('get_content:', url)
	global _opener

	if not ('http://' in url or 'ftp://' in url):
		url = 'http://' + url

	try:
		with _opener.open(url) as r:
			data = r.read()
			try:
				return data.decode()
			except ValueError:
				return str(data)
	except ValueError:
		raise DownloadError("'{}' is not a valid url".format(url))
	except URLError:
		raise DownloadError("failed to retrieve '{}'".format(url))


def set_useragent(agent):
	global _opener
	_opener.addheaders = [('User-agent', agent), ('Accept', '*/*')]


def download(url, filename=None, dl_dir=settings['download_dir']):
	#print('download:', url)
	global _opener
	dry_run = settings.get('dry_run')
	def getFileName(url, openUrl):
		if 'Content-Disposition' in openUrl.info():
			# If the response has Content-Disposition, try to get filename from it
			cd = dict(map(
				lambda x: x.strip().split('=') if '=' in x else (x.strip(),''),
				openUrl.info().split(';')))
			if 'filename' in cd:
				filename = cd['filename'].strip("\"'")
				if filename: return filename
		# if no filename was found above, parse it out of the final URL.
		return basename(urlparse(openUrl.url)[2]) or basename(url)

	if not ('http://' in url or 'ftp://' in url):
		url = 'http://' + url

	if not exists(dl_dir):
		if not dry_run:
			try:
				makedirs(dl_dir, exist_ok=True)
			except OSError:
				raise FileError("cannot create directory '{}'".format(dl_dir))
		print('Directory', dl_dir, 'created.')

	try:
		if filename:
			if exists(join(dl_dir, filename)):
				print(filename, 'already exists.\nDownload canceled.')
				return
		with _opener.open(url) as r:
			filename = join(dl_dir, filename or getFileName(url,r))
			if exists(filename):
				print(filename, 'already exists.\nDownload canceled.')
			elif dry_run:
				print('Download', url, 'as', filename)
			else:
				print('Download started:', url)
				print('File name:', filename)
				with open(filename, 'wb') as f:
					copyfileobj(r,f)
				print('Successful operation')
	except ValueError:
		raise DownloadError("'{}' is not a valid url".format(url))
	except URLError:
		raise DownloadError("failed to download '{}'".format(url))


def match_text(regex, text):
	comp_regex = re.compile(regex)
	return re.finditer(comp_regex, text)


def match_page_data(regex, url):
	iterator = match_text(regex, get_content(url))
	try:
		iterator = assert_iterator_notempty(iterator)
	except:
		raise NoMatch("no match for {} at '{}'".format(repr(regex), url))
	return iterator
