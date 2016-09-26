from bs4 import BeautifulSoup
import requests
import bs4
import os
import sys
import io
import scrape_summary
import time
import urllib.request

try:
    #get movie genre links
    f = open("3Links.txt", 'r')
    links = f.readlines()
    f.close()

    dir_made = False
    main_dir_name =  os.getcwd() +"/Movies/"

    #link = "http://www.imdb.com/search/title?genres=action&sort=user_rating,desc&title_type=feature&num_votes=25000,&pf_rd_m=A2FGELUUNOQJNL&pf_rd_p=2406822102&pf_rd_r=1V7DV4GMZZC0JECQET8S&pf_rd_s=right-6&pf_rd_t=15506&pf_rd_i=top&ref_=chttp_gnr_1"
    for genre_link in links:
        page = requests.get(genre_link)
        html = BeautifulSoup(page.text)
        #next_page_links = html.findAll("div", {"class": "nav"}).find("div", {"class": "desc"})
        #next_page = next_page_links[0].find("a")
        #next_page = "http://www.imdb.com" + next_page['href']
        #print("Next Page : "+next_page)
        movie_links = html.findAll("div", {"class": "lister-item mode-advanced"})
        for movie in movie_links:
            movie_name_sub = ""
            movie_name = movie.find("div", {"class": "lister-item-content"}).find("h3", {"class": "lister-item-header"}).find("a").text

            movie_year = movie.find("div", {"class": "lister-item-content"}).find("h3", {"class": "lister-item-header"}).find("span", {"class": "lister-item-year text-muted unbold"})
            if movie_year is None :
                print("Movie Year is null")
                #file.write("Movie Year: \n")
            else :
                movie_year = movie_year.text
                m_year = movie_year.split(' ')
                if len(m_year) == 1:
                    movie_year = movie_year[1:-1]
                elif len(m_year) == 2:
                    movie_year = m_year[1]
                    movie_year = movie_year[1:-1]
                    movie_name_sub = m_year[0]
                    movie_name_sub = movie_name_sub[1:-1]
                

            
            mod_movie_name = movie_name.replace('/','-')
            mod_movie_name = mod_movie_name.replace(':','-')
            mod_movie_name = mod_movie_name + " " + movie_name_sub
            dir_name =  main_dir_name + mod_movie_name
            try:
               os.makedirs(dir_name)
               os.chdir(dir_name)
               dir_made = True
               file = io.open("movie_info.txt",'w', encoding="utf8")
     
            except Exception as e:
               print("Directory could not be formed:",e)
               continue


            print("Movie Name: " + movie_name +" "+ movie_name_sub)
            print("Movie Year: " + movie_year)

            file.write("Movie Name: " + movie_name +" "+ movie_name_sub+"\n")
            file.write("Movie Year: " + movie_year+"\n")

            
            movie_description = movie.find("div", {"class": "lister-item-content"}).findAll("p", {"class": "text-muted"})
            #print("Movie description : " +str(movie_description))
            movie_certificate = movie_description[0].find("span", {"class": "certificate"})
            if movie_certificate is None :
                print("Movie Certificate is null")
                file.write("Movie Certificate: \n")
            else :
                movie_certificate = movie_certificate.text
                print("Movie Certificate: " + movie_certificate)
                file.write("Movie Certificate: " + movie_certificate+"\n")
            movie_duration = movie_description[0].find("span", {"class": "runtime"})
            if movie_certificate is None :
                print("Movie Duration is null")
                file.write("Movie Duration: \n")
            else :
                movie_duration = movie_duration.text
                print("Movie Duration: " + movie_duration)
                file.write("Movie Duration: " + movie_duration+"\n")
            movie_genre = movie_description[0].find("span", {"class": "genre"})
            if movie_genre is None :
                print("Movie Genre is null")
                file.write("Movie Genre: \n")
            else :
                movie_genre = movie_genre.text
                print("Movie Genre: " + movie_genre)
                file.write("Movie Genre: " + movie_genre+"\n")
            movie_rating = movie.find("div", {"class": "lister-item-content"}).find("div", {"class": "inline-block ratings-imdb-rating"}).find('strong').string
            if movie_rating is None :
                print("Movie Rating is null")
                file.write("Movie Rating : \n")
            else :
                print("Movie Rating : " + movie_rating)
                file.write("Movie Rating : " + movie_rating+"\n")
            movie_dir_actors = movie.find("div", {"class": "lister-item-content"}).findAll("p", {"class":""})
            #print("Movie Dir  Actor : " + str(movie_dir_actors[1]))
            directors = []
            actors = []
            for s in movie_dir_actors[1].children:
                if "Dir" in s:
                    state = 'dir'
                    #print("Found a Dir : "+ s.text)
                elif "Stars" in s:
                    state = 'act'
                    #print("Found an Actor : "+ s.text)
                elif type(s) is bs4.element.Tag:
                    if state is 'dir':
                        directors.append(s.text)
                    elif state is 'act':
                        actors.append(s.text)
            print("Directors : ",end="")
            file.write("Directors : ")
            for d in directors[0:-1]:
                print(d,", ",end="")
                file.write(d+",")
            print("\n")
            file.write("\nActors : ")
            print("Actors : ",end="")
            for a in actors:
                print(a, ", ",end="")
                file.write(a+",")
            print("\n")
            file.write("\n")
            substring = "See full summary"
            if movie_description[1].text is None :
                print("Movie Text is null")
                file.write("Movie Text is null \n")
            else :
                if substring in movie_description[1].text :
                    movie_text = movie_description[1].find("a")
                    #print("Sumary Link :"+ movie_text['href'])
                    scrape_summary.scrape_summary_links("http://www.imdb.com" + movie_text['href'],file)
                else :
                    movie_text = movie_description[1].text
                    print("Movie Text: " + movie_text)
                    file.write("Movie Text: " + movie_text+"\n")

            movie_poster = movie.find("div", {"class": "lister-item-image float-left"}).find("img")
            movie_poster_link = movie_poster['loadlate']
            movie_poster_link = movie_poster_link.replace("67", "182")
            movie_poster_link = movie_poster_link.replace("98", "268")
            print("Movie Poster : "+ movie_poster_link)
            urllib.request.urlretrieve(movie_poster_link, "poster.jpg")

            file.close()

        

except Exception as e:
    print(e)
