package com.moviebase.web.model.genre;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

@Repository
public class GenreDaoImpl implements GenreDao {
	
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Override
	public Genre getGenreById(int id) {
		String sql = "SELECT * FROM genre WHERE genre_id = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			Genre genre = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				genre = new Genre();
				genre.setId(rs.getInt("genre_id"));
				genre.setName(rs.getString("name"));
				
			}
			rs.close();
			ps.close();
			return genre;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
				conn.close();
				} catch (SQLException e) {}
			}
		}
	}

	@Override
	public Genre getGenreByName(String name) {
		String sql = "SELECT * FROM genre WHERE name = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,name);
			Genre genre = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				genre = new Genre();
				genre.setId(rs.getInt("genre_id"));
				genre.setName(rs.getString("name"));
				
			}
			rs.close();
			ps.close();
			return genre;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
				conn.close();
				} catch (SQLException e) {}
			}
		}
	}

	@Override
	public List<Genre> getAllGenres() {
		String sql = "SELECT * FROM genre";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			List<Genre> genrelist = new ArrayList<Genre>();
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Genre genre = new Genre();
				genre.setId(rs.getInt("genre_id"));
				genre.setName(rs.getString("name"));
				genrelist.add(genre);
				
			}
			rs.close();
			ps.close();
			return genrelist;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
				conn.close();
				} catch (SQLException e) {}
			}
		}
	}

}
