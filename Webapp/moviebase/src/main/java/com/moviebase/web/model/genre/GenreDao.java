package com.moviebase.web.model.genre;

import java.util.List;

public interface GenreDao {
	
	public Genre getGenreById(int id);
	public Genre getGenreByName(String name);
	public List<Genre> getAllGenres();

}
