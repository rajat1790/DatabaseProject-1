package com.moviebase.web.model.userMovieList;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.moviebase.web.model.movie.Movie;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

public class UserMovieListDaoImpl implements UserMovieListDao {
	
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Override
	public boolean insertMovie(UserMovieList userMovie) {
		// TODO Auto-generated method stub
		
		// TODO Auto-generated method stub
				System.out.println("New Movie:" + userMovie.toString());
				String sql = "INSERT INTO user_movie_list (user_id, movie_id, wish_or_watch,"
						+ " rating, comment, watch_date) VALUES (?, ?, ?, ?, ?, ?)";
				Connection conn = null;

				try {
					// File pic = user.getImage();
					// FileInputStream fis = new FileInputStream(pic);

					conn = dataSource.getConnection();
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setInt(1, userMovie.getUserID());
					ps.setInt(2, userMovie.getMovieID());
					ps.setBoolean(3, userMovie.isWishOrWatch());
					ps.setInt(4, userMovie.getRating());
					ps.setString(5, userMovie.getComment());
					ps.setDate(6, userMovie.getWatchDate());
					
					// ps.setBinaryStream(6, fis, (int) pic.length());
					int success = ps.executeUpdate();
					
					ps.close();
					return success > 0;

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
	public List<Movie> getMovieListOfUser(int userId) {
		String sql = "SELECT * FROM movies AS m INNER JOIN user_movie_list u "
				+ "ON u.user_id = ? AND u.movie_id = m.id";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
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

	@Override
	public void deleteMovie(int userId, int movieId) {
		String sql = "DELETE FROM user_movie_list WHERE user_id = ? AND movie_id = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, movieId);
			ps.executeUpdate();
			ps.close();
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
	public boolean updateMovie(UserMovieList userMovie) {
		String sql = "UPDATE user_movie_list "
				+ " SET wish_or_watch= ?, rating = ?, comment = ?, watch_date = ?"
				+ "WHERE user_id = ? AND movie_id = ?";
		Connection conn = null;

		try {

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1, userMovie.isWishOrWatch());
			ps.setInt(2, userMovie.getRating());
			ps.setString(3, userMovie.getComment());
			ps.setDate(4, userMovie.getWatchDate());
			ps.setInt(5, userMovie.getUserID());
			ps.setInt(6, userMovie.getMovieID());
			
			int success = ps.executeUpdate();
			
			ps.close();
			return success > 0;

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
	public UserMovieList findByIds(int userId, int movieId) {
		String sql = "SELECT * FROM user_movie_list WHERE user_id = ? AND movie_id = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, movieId);
			UserMovieList userMovie = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				userMovie = new UserMovieList();
				userMovie.setUserID(rs.getInt("user_id"));
				userMovie.setMovieID(rs.getInt("movie_id"));
				userMovie.setWishOrWatch(rs.getBoolean("wish_or_watch"));
				userMovie.setRating(rs.getInt("rating"));
				userMovie.setComment(rs.getString("comment"));
				userMovie.setWatchDate(rs.getDate("watch_date"));
			}
			rs.close();
			ps.close();
			return userMovie;
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
