package com.moviebase.web.model.userMovieList;

import java.util.List;

import com.moviebase.web.model.movie.Movie;

public interface UserMovieListDao {
	
	public boolean insertMovie(UserMovieList userMovie);
	public List<Movie> getMovieListOfUser(int userId);
	public void deleteMovie(int userId, int movieId);
	public boolean updateMovie(UserMovieList userMovie);
	public UserMovieList findByIds(int userId, int movieId);

}
