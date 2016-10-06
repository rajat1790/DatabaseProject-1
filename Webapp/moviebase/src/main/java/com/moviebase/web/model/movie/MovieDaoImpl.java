package com.moviebase.web.model.movie;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

public class MovieDaoImpl implements MovieDao {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Override
	public void insert(Movie movie) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO movies "
				+ "(name, year, duration, certificate, summary, director, imdb_rating, poster) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			byte[] poster = movie.getPoster();

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, movie.getName());
			ps.setInt(2, movie.getYear());
			ps.setString(3, movie.getDuration());
			ps.setString(4, movie.getCertificate());
			ps.setString(5, movie.getSummary());
			ps.setString(6, movie.getDirector());
			ps.setDouble(7, movie.getRating());
			ps.setBytes(8, poster);
			ps.executeUpdate();
			int movie_id = 0;
			ResultSet generatedKeys = ps.getGeneratedKeys();
			if (generatedKeys.next()) {
				movie_id = generatedKeys.getInt(1);
			} else {
				throw new SQLException("No ID obtained in Movie.");
			}

			String[] actors = movie.getActors();
			for (int i = 0; i < actors.length; i++) {
				sql = "INSERT INTO actors (name) VALUES (?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, actors[i]);
				ps.executeUpdate();
			}

			List<Integer> actorIds = new ArrayList<Integer>();
			ResultSet generatedActorKeys = ps.getGeneratedKeys();
			if (generatedActorKeys.next()) {
				actorIds.add(generatedActorKeys.getInt(1));
			} else {
				throw new SQLException("No ID obtained in Actor.");
			}

			for (int i = 0; i < actorIds.size(); i++) {
				sql = "INSERT INTO movie_actors (movie_id, actor_id) VALUES (?, ?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, movie_id);
				ps.setInt(2, actorIds.get(i));
				ps.executeUpdate();
			}

			String[] genres = movie.getGenres();
			List<Integer> genreIds = new ArrayList<Integer>();
			for (int i = 0; i < genres.length; i++) {
				sql = "SELECT genre_id FROM genre WHERE name = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, genres[i]);
				ResultSet resultSet = ps.executeQuery();
				while (resultSet.next()) {
					int genreId = resultSet.getInt("genre_id");
					genreIds.add(genreId);
				}
			}

			for (int i = 0; i < genreIds.size(); i++) {
				sql = "INSERT INTO movie_genres (movie_id, genre_id) VALUES (?, ?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, movie_id);
				ps.setInt(2, genreIds.get(i));
				ps.executeUpdate();
			}

			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);

		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}

	}

	@Override
	public Movie findById(int id) {
		String sql = "SELECT * FROM movies WHERE id = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			Movie movie = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				movie = new Movie();
				movie.setId(rs.getInt("id"));
				movie.setName(rs.getString("name"));
				movie.setYear(rs.getInt("year"));
				movie.setDuration(rs.getString("duration"));
				movie.setCertificate(rs.getString("certificate"));
				movie.setSummary(rs.getString("summary"));
				movie.setDirector(rs.getString("director"));
				movie.setRating(rs.getDouble("imdb_rating"));
				Blob poster = rs.getBlob("poster");
				if (poster != null) {
					movie.setPoster(rs.getBlob("poster").getBytes(1, (int) poster.length()));
				}
				movie.setSrc("data:image/jpg;base64," + Base64.encode(movie.getPoster()));
			}
			rs.close();
			ps.close();
			return movie;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	@Override
	public List<Movie> findByName(String movieName) {
		String sql = "SELECT * FROM movies WHERE name LIKE ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + movieName + "%");
			// Movie movie = null;
			List<Movie> movies = new ArrayList<Movie>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Movie movie = new Movie();
				movie.setId(rs.getInt("id"));
				movie.setName(rs.getString("name"));
				movie.setYear(rs.getInt("year"));
				movie.setDuration(rs.getString("duration"));
				movie.setCertificate(rs.getString("certificate"));
				movie.setSummary(rs.getString("summary"));
				movie.setDirector(rs.getString("director"));
				movie.setRating(rs.getDouble("imdb_rating"));
				Blob poster = rs.getBlob("poster");
				if (poster != null) {
					movie.setPoster(rs.getBlob("poster").getBytes(1, (int) poster.length()));
				}
				movie.setSrc("data:image/jpg;base64," + Base64.encode(movie.getPoster()));
				movies.add(movie);
			}

			rs.close();
			ps.close();
			return movies;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	@Override
	public List<Movie> findByYear(int year) {
		String sql = "SELECT * FROM movies WHERE year = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, year);
			// Movie movie = null;
			List<Movie> movies = new ArrayList<Movie>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Movie movie = new Movie();
				movie.setId(rs.getInt("id"));
				movie.setName(rs.getString("name"));
				movie.setYear(rs.getInt("year"));
				movie.setDuration(rs.getString("duration"));
				movie.setCertificate(rs.getString("certificate"));
				movie.setSummary(rs.getString("summary"));
				movie.setDirector(rs.getString("director"));
				movie.setRating(rs.getDouble("imdb_rating"));
				Blob poster = rs.getBlob("poster");
				if (poster != null) {
					movie.setPoster(rs.getBlob("poster").getBytes(1, (int) poster.length()));
				}
				movie.setSrc("data:image/jpg;base64," + Base64.encode(movie.getPoster()));
				movies.add(movie);
			}

			rs.close();
			ps.close();
			return movies;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	@Override
	public List<Movie> findByDirector(String director) {
		String sql = "SELECT * FROM movies WHERE director LIKE ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + director + "%");
			// Movie movie = null;
			List<Movie> movies = new ArrayList<Movie>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Movie movie = new Movie();
				movie.setId(rs.getInt("id"));
				movie.setName(rs.getString("name"));
				movie.setYear(rs.getInt("year"));
				movie.setDuration(rs.getString("duration"));
				movie.setCertificate(rs.getString("certificate"));
				movie.setSummary(rs.getString("summary"));
				movie.setDirector(rs.getString("director"));
				movie.setRating(rs.getDouble("imdb_rating"));
				Blob poster = rs.getBlob("poster");
				if (poster != null) {
					movie.setPoster(rs.getBlob("poster").getBytes(1, (int) poster.length()));
				}
				movie.setSrc("data:image/jpg;base64," + Base64.encode(movie.getPoster()));
				movies.add(movie);
			}

			rs.close();
			ps.close();
			return movies;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	@Override
	public List<Movie> findByGenre(int genre) {
		String sql =   "SELECT * FROM movies AS m INNER JOIN movie_genres g "
				+ "ON g.genre_id = ? AND g.movie_id = m.id";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, genre);
			// Movie movie = null;
			List<Movie> movies = new ArrayList<Movie>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Movie movie = new Movie();
				movie.setId(rs.getInt("id"));
				movie.setName(rs.getString("name"));
				movie.setYear(rs.getInt("year"));
				movie.setDuration(rs.getString("duration"));
				movie.setCertificate(rs.getString("certificate"));
				movie.setSummary(rs.getString("summary"));
				movie.setDirector(rs.getString("director"));
				movie.setRating(rs.getDouble("imdb_rating"));
				Blob poster = rs.getBlob("poster");
				if (poster != null) {
					movie.setPoster(rs.getBlob("poster").getBytes(1, (int) poster.length()));
				}
				movie.setSrc("data:image/jpg;base64," + Base64.encode(movie.getPoster()));
				movies.add(movie);
			}

			rs.close();
			ps.close();
			return movies;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	@Override
	public List<Movie> getFiftyMovies() {
		String sql = "SELECT * FROM movies LIMIT 10";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			// Movie movie = null;
			List<Movie> movies = new ArrayList<Movie>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Movie movie = new Movie();
				movie.setId(rs.getInt("id"));
				movie.setName(rs.getString("name"));
				movie.setYear(rs.getInt("year"));
				movie.setDuration(rs.getString("duration"));
				movie.setCertificate(rs.getString("certificate"));
				movie.setSummary(rs.getString("summary"));
				movie.setDirector(rs.getString("director"));
				movie.setRating(rs.getDouble("imdb_rating"));
				Blob poster = rs.getBlob("poster");
				if (poster != null) {
					movie.setPoster(rs.getBlob("poster").getBytes(1, (int) poster.length()));
				}
				movies.add(movie);
				movie.setSrc("data:image/jpg;base64," + Base64.encode(movie.getPoster()));
			}

			rs.close();
			ps.close();
			return movies;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

}
