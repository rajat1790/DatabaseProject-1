package com.moviebase.web.model.movie;

import java.util.List;

public interface MovieDao {
	public void insert(Movie movie);

	public List<Movie> getFiftyMovies();

	public Movie findById(int id);

	public List<Movie> findByName(String movieName, int offset, int recordsPerPage);

	public List<Movie> findByYear(int year);

	List<Movie> findByActor(String actorName, int offset, int recordsPerPage);

	public List<Movie> findByDirector(String director, int offset, int recordsPerPage);

	public List<Movie> findByGenre(int genre, int offset, int recordsPerPage);

	public int getNoOfRecords();

}
