#from lxml import html
#from lxml.cssselect import CSSSelector
import requests
#from lxml import etree
import time
import os
import sys
import io
from bs4 import BeautifulSoup

def scrape_summary_links(base_url):
    try:
        dir_made = False
        page = requests.get(base_url)
        #print(" Base Url: " + str(base_url))
        html = BeautifulSoup(page.text)
        movie_summary = html.find("p", {"class": "plotSummary"})
        #print("Movie Text: " + str(movie_summary))
        print("Movie Text: " + movie_summary.text)
        
    except Exception as e:
        print(e)
        return

        
#scrape_review_links('http://www.imdb.com/title/tt2199711/plotsummary?ref_=adv_pl')




