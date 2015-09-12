import sys
import re
from threading import Thread, Lock
from time import sleep

from linkgrab.exceptions import *

actions = []
done = []
threads = []
lock = Lock()
associations = []
settings = {'download_dir': '.'}

def get_func(url):
	"""Return the handler for the given url"""
	for regex,func in associations:
		if re.match(regex, url):
			return func
	else:
		raise UnknowAction("cannot find out what to do with '{}'".format(url))

def associate(assocs):
	"""
	Associate urls to their handler.
	assocs is a list of {regex, function} tuples.

		>>> def func:
		...     print('hello')
		>>> associate([{'^www.example.com', func}])
		>>> handler = get_func('www.example.com/foo')
		>>> handler()
		hello
	"""
	for r, f in assocs:
		associations.append( (re.compile(r), f) )

def add(**kwds):
	"""Add an action to pending list"""
	with lock:
		if not kwds in done:
			actions.append(kwds)

def exception_handler(func):
	"""Wrapper to handle exception thrown by a thread"""
	def handled(**kwargs):
		try:
			func(**kwargs)
		except LinkgrabException as e:
			print('Error: {}'.format(e))
	return handled

def grab():
	"""Main loop: execute all actions requested"""
	continue_grabbing = True
	while continue_grabbing:
		while True:
			with lock:
				if not actions:
					break
				req = actions.pop()
				done.append(req)
			sleep(0.4)
			try:
				func = req.pop('func')
				t = Thread(target=func, kwargs=req)
				threads.append(t)
				t.start()
			except KeyError:
				try:
					func = get_func(req['url'])
					t = Thread(target=exception_handler(func), kwargs=req)
					threads.append(t)
					t.start()
				except KeyError:
					raise UnknowAction("request without url nor function\n{}".format(req))
		for t in threads:
			t.join()
			with lock:
				continue_grabbing = (len(actions) > 0)
