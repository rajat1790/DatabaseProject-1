package com.moviebase.web.model.movie;

import java.util.Arrays;
import java.util.List;

public class Movie {
	int id;
	String name;
	int year;
	String duration;
	String certificate;
	String summary;
	String director;
	Double rating;
	byte[] poster;
	List<String> genres;
	List<String> actors;
	String src;

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public List<String> getGenres() {
		return genres;
	}

	public void setGenres(List<String> genres) {
		this.genres = genres;
	}

	public List<String> getActors() {
		return actors;
	}

	public void setActors(List<String> actors) {
		this.actors = actors;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getCertificate() {
		return certificate;
	}

	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public byte[] getPoster() {
		return poster;
	}

	public void setPoster(byte[] poster) {
		this.poster = poster;
	}

	@Override
	public String toString() {
		return "Movie [id=" + id + ", name=" + name + ", year=" + year + ", duration=" + duration + ", certificate="
				+ certificate + ", summary=" + summary + ", director=" + director + ", rating=" + rating + ", poster="
				+ Arrays.toString(poster) + ", genres=" + genres + ", actors=" + actors + ", src=" + src + "]";
	}

}
