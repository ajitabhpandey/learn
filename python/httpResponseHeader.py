#!/usr/bin/python

import urllib2
import sys

def print_http_respose_header(url):
	try:
		response = urllib2.urlopen(url)
		for key, value in response.info().items():
			print key + ' => ' + value
	except:
		print 'error message'

def main():
	print_http_respose_header(sys.argv[1])

if __name__ == '__main__':
	main()
