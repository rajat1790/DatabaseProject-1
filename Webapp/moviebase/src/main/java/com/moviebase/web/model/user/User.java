package com.moviebase.web.model.user;

import java.io.File;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;

public class User {
	int id;
	String username;
	String email;
	String password;
	String name;
	Date dob;
	byte[] pic;
	List<Integer> genreId;
	List<String> genreName;
	String src;
	
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public void setGenreName(List<String> genreName) {
		this.genreName = genreName;
	}
	File image;
	
	
	public File getImage() {
		return image;
	}
	public void setImage(File image) {
		this.image = image;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
	public byte[] getPic() {
		return pic;
	}
	public void setPic(byte[] pic) {
		this.pic = pic;
	}
	public List<Integer> getGenreId() {
		return genreId;
	}
	public void setGenreId(List<Integer> genreId) {
		this.genreId = genreId;
	}
	public List<String> getGenreName() {
		return genreName;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", email=" + email + ", password=" + password + ", name="
				+ name + ", dob=" + dob + ", pic=" + Arrays.toString(pic) + ", genreId=" + genreId + ", genreName="
				+ genreName + ", image=" + image + "]";
	}
		
}
