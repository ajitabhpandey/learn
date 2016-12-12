#!/usr/bin/python
import re, urllib
from urlparse import urlparse

# maximum depth the web crawler travels from seed url
maxDepth = 1

# unique urls retrieved while crawling the web
urls = []

# stores the urls of web pages visited to avoid duplicates
visitedUrls = []

def crawl(baseUrl, urlsCollected, depth=0):
	urlComponents = urlparse(baseUrl)
	baseHost = urlComponents.netloc

	# return if either the depth is greater than max depth or
	# the URL has already been visited before
	if depth > maxDepth:
		return
	elif baseUrl in visitedUrls:
		return

	try:
		pageContent = urllib.urlopen(baseUrl).read()	
		visitedUrls.append(baseUrl)
	except:
		e = sys.exc_info()[0]
		print "Error: ", e
		return
	# extract all urls (href tag values) from the page
	for url in re.findall(r'href=[\'"]?([^\'" >]+)', pageContent):
		# validate that the url is not already present and 
		# then write it to the file
		if url not in urls and url != None:
			urls.append(url)
			urlsCollected.write(url + '\n')

	for url in urls:
		crawl(url, urlsCollected, depth + 1)
def main():
	seedUrl = 'http://ajitabhpandey.info'
	urlsCollected = open('urls_collected', 'w')
	crawl(seedUrl, urlsCollected)
	urlsCollected.close()

if __name__ == "__main__":
	main()

