package com.moviebase.web.model.userMovieList;

import java.sql.Date;

public class UserMovieList {
	int userID;
	int movieID;
	boolean wishOrWatch;
	int rating;
	String comment;
	Date watchDate;
	
	@Override
	public String toString() {
		return "UserList [userID=" + userID + ", movieID=" + movieID + ", wishOrWatch=" + wishOrWatch + ", rating="
				+ rating + ", comment=" + comment + ", watchDate=" + watchDate + "]";
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public int getMovieID() {
		return movieID;
	}
	public void setMovieID(int movieID) {
		this.movieID = movieID;
	}
	public boolean isWishOrWatch() {
		return wishOrWatch;
	}
	public void setWishOrWatch(boolean wishOrWatch) {
		this.wishOrWatch = wishOrWatch;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getWatchDate() {
		return watchDate;
	}
	public void setWatchDate(Date watchDate) {
		this.watchDate = watchDate;
	}
	

}
