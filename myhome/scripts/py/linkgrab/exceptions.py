class LinkgrabException(Exception):
	pass

class DownloadError(LinkgrabException):
	pass

class NoMatch(LinkgrabException):
	pass

class DirectoryError(LinkgrabException):
	pass

class UnknowAction(LinkgrabException):
	pass


def assert_iterator_notempty(iterator):
	# WARNING: this is a hack

	import itertools

	# try to get a value from the iterator
	for i in iterator:
		# value found: we do not want to continue
		break
	else:
		# no value
		raise NoMatch()

	# single value iterator
	def mini_iter(value):
		yield value

	# rebuild the iterator by putting the value on top of the iterator
	return itertools.chain(mini_iter(i), iterator)
