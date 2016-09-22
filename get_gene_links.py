from bs4 import BeautifulSoup
import requests
import scrape_summary
import time
import urllib.request

try:
    #get hotel links
    f = open("Links.txt", 'r')
    links = f.readlines()
    f.close()

    #link = "http://www.imdb.com/search/title?genres=action&sort=user_rating,desc&title_type=feature&num_votes=25000,&pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=2406822102&pf_rd_r=1V7DV4GMZZC0JECQET8S&pf_rd_s=right-6&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_gnr_1"
    for genre_link in links:
        page = requests.get(genre_link)
        html = BeautifulSoup(page.text)
        movie_links = html.findAll("div", {"class": "lister-item mode-advanced"})
        for movie in movie_links:
            #print("Movie:" + str(movie))
            movie_poster = movie.find("div", {"class": "lister-item-image float-left"}).find("img")
            movie_poster_link = movie_poster['loadlate']
            movie_poster_link = movie_poster_link.replace("67", "182")
            movie_poster_link = movie_poster_link.replace("98", "268")
            print("Movie Poster : "+ movie_poster_link)
            urllib.request.urlretrieve(movie_poster_link, "poster.jpg")
            movie_name = movie.find("div", {"class": "lister-item-content"}).find("h3", {"class": "lister-item-header"}).find("a").text
            print("Movie Name: " + movie_name)
            movie_year = movie.find("div", {"class": "lister-item-content"}).find("h3", {"class": "lister-item-header"}).find("span", {"class": "lister-item-year text-muted unbold"})
            if movie_year is None :
                print("Movie Year is null")
            else :
                movie_year = movie_year.text
                print("Movie Year: " + movie_year)
            movie_description = movie.find("div", {"class": "lister-item-content"}).findAll("p", {"class": "text-muted"})
            #print("Movie description : " +str(movie_description))
            movie_certificate = movie_description[0].find("span", {"class": "certificate"})
            if movie_certificate is None :
                print("Movie Certificate is null")
            else :
                movie_certificate = movie_certificate.text
                print("Movie Certificate: " + movie_certificate)
            movie_duration = movie_description[0].find("span", {"class": "runtime"})
            if movie_certificate is None :
                print("Movie Duration is null")
            else :
                movie_duration = movie_duration.text
                print("Movie Duration: " + movie_duration)
            movie_genre = movie_description[0].find("span", {"class": "genre"})
            if movie_genre is None :
                print("Movie Genre is null")
            else :
                movie_genre = movie_genre.text
                print("Movie Genre: " + movie_genre)
            #print("Movie description : " +str(movie_description[1]))
            substring = "See full summary"
            if movie_description[1].text is None :
                print("Movie Text is null")
            else :
                if substring in movie_description[1].text :
                    movie_text = movie_description[1].find("a")
                    #print("Sumary Link :"+ movie_text['href'])
                    scrape_summary.scrape_summary_links("http://www.imdb.com" + movie_text['href'])
                else :
                    movie_text = movie_description[1].text
                    print("Movie Text: " + movie_text)

except Exception as e:
    print(e)
