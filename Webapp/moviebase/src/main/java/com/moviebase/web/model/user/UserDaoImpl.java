package com.moviebase.web.model.user;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.moviebase.web.model.user.User;

@Repository
public class UserDaoImpl implements UserDao{
	
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Override
	public void insert(User user) {
		// TODO Auto-generated method stub
		System.out.println("New User:"+ user.toString());
		String sql = "INSERT INTO user " +
				"(name, username, email, password,dob, pic) VALUES (?, ?, ?, ?, ?, ?)";
		Connection conn = null;

		try {
			//File pic = user.getImage();
			//FileInputStream fis = new FileInputStream(pic);

			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, user.getName());
			ps.setString(2, user.getUsername());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getPassword());
			ps.setDate(5, user.getDob());
			ps.setBytes(6, user.getPic());
			//ps.setBinaryStream(6, fis, (int) pic.length());
			ps.executeUpdate();
			int user_id = 0;
			ResultSet generatedKeys = ps.getGeneratedKeys();
			if (generatedKeys.next()) {
				user_id = generatedKeys.getInt(1);
			} else {
				throw new SQLException("No ID obtained in User.");
			}
			
			List<Integer> genreIds = user.getGenreId();
			for (int i = 0; i < genreIds.size(); i++) {
				sql = "INSERT INTO user_genre_choices (user_id, genre_id) VALUES (?, ?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, user_id);
				ps.setInt(2, (int)genreIds.get(i));
				ps.executeUpdate();
			}
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);

		} catch(Exception e) {
			throw new RuntimeException(e);
		}finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {}
			}
		}
	}

	@Override
	public User findById(int id) {
		String sql = "SELECT * FROM User WHERE id = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			User user = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setDob(rs.getDate("dob"));
				user.setName(rs.getString("name"));
				user.setUsername(rs.getString("username"));
				user.setPic(rs.getBlob("pic").getBytes(1, (int)rs.getBlob("pic").length()));
			}
			rs.close();
			ps.close();
			return user;
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
	public User findByUsername(String username) {
		String sql = "SELECT * FROM user WHERE username = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			User user = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setDob(rs.getDate("dob"));
				user.setName(rs.getString("name"));
				user.setUsername(rs.getString("username"));
				Blob pic = rs.getBlob("pic");
				if (pic != null) {
					user.setPic(pic.getBytes(1, (int)pic.length()));
				}
				
			}
			rs.close();
			ps.close();
			return user;
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
