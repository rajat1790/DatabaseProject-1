package com.moviebase.web.model.movie;

import java.util.List;

public interface MovieDao {
	public void insert(Movie movie);

	public List<Movie> getFiftyMovies();

	public Movie findById(int id);

	public List<Movie> findByName(String movieName);

	public List<Movie> findByYear(int year);

	public List<Movie> findByDirector(String director);

}
