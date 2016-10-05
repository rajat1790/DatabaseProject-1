package com.moviebase.web.model.user;

public interface UserDao {

	public void insert(User user);

	public User findById(int id);

	public User findByUsername(String username);
	
	public int findIdByUsername(String username);

}
