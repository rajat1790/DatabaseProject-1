package main.java;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class DBConnect {
	static Connection conn = null;

	public static void main(String[] args) {

		try {
			String host = "jdbc:mysql://database-new.cs.tamu.edu:3306/rhljain08-db";
			String uName = "rhljain08";
			String uPass = "Q@werty123";

			conn = DriverManager.getConnection(host + "?useUnicode=true&characterEncoding=UTF-8", uName, uPass);
			System.out.println(conn);
			start();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}

	public static void start() {
		String path = "C:\\Users\\Rajat\\Desktop\\Courses\\Fall 2016\\Database\\Project-1\\Movies";
		File dir = new File(path);
		listFilesForFolder(dir);
		System.out.println("DONEEEEEEEEEEE");
	}

	public static void listFilesForFolder(final File folder) {
		List<MovieInfo> movies = new ArrayList<MovieInfo>();
		for (final File fileEntry : folder.listFiles()) {
			if (fileEntry.isDirectory()) {
				File[] movieInfo = fileEntry.listFiles();
				MovieInfo movie = null;
				File poster = null;
				System.out.println("Came in list files");
				for (int i = 0; i < movieInfo.length; i++) {

					if (movieInfo[i].getName().equals("movie_info.txt")) {
						movie = getMovieInfo(movieInfo[i]);

					} else if (movieInfo[i].getName().equals("poster.jpg")) {
						poster = movieInfo[i];
					}
				}
				movie.setPoster(poster);
				movies.add(movie);
			}
		}
		insertIntoDB(movies);
	}

	public static void insertIntoDB(List<MovieInfo> movies) {
		Set<String> listActor = new HashSet<String>();
		Set<String> listGenre = new HashSet<String>();

		for (int i = 0; i < movies.size(); i++) {
			String[] actors = movies.get(i).getActors();
			String[] genres = movies.get(i).getGenre();

			for (int j = 0; j < actors.length; j++) {
				listActor.add(actors[j].trim());
			}
			for (int j = 0; j < genres.length; j++) {
				listGenre.add(genres[j].trim());
			}
		}
		System.out.println(listActor.size());
		System.out.println(listGenre.size());
		for (String a : listActor) {
			try { // Statement st = conn.createStatement();
				String q = "INSERT INTO actors(name) VALUES (?)";
				PreparedStatement st = conn.prepareStatement(q);
				System.out.println("Query : " + q);
				st.setString(1, a.trim());
				st.executeUpdate();
			} catch (SQLException e) { // TODO Auto-generated catch block
				System.out.println(e.getMessage());
				e.printStackTrace();
			}

		}

		/*
		 * for (String g : listGenre) { try { // Statement st =
		 * conn.createStatement(); String q =
		 * "INSERT INTO genre(name) VALUES (?)"; PreparedStatement st =
		 * conn.prepareStatement(q); st.setString(1, g.trim());
		 * st.executeUpdate(); } catch (SQLException e) { // TODO Auto-generated
		 * catch block e.printStackTrace(); }
		 * 
		 * }
		 */

		for (int i = 0; i < movies.size(); i++) {

			String q = "Insert into movies (name, year, duration, certificate, summary, director, imdb_rating, poster) values(?,?,?,?,?,?,?,?)";
			PreparedStatement st;
			try {
				st = conn.prepareStatement(q);

				File poster = movies.get(i).getPoster();
				FileInputStream fis = new FileInputStream(poster);
				st.setString(1, movies.get(i).getName());
				st.setInt(2, movies.get(i).getRelease_year());
				st.setString(3, movies.get(i).getDuration());
				st.setString(4, movies.get(i).getCertificate());
				st.setString(5, movies.get(i).getDescription());
				st.setString(6, movies.get(i).getDirectors()[0]);
				System.out.println("Rating : " + movies.get(i).getRating());
				st.setDouble(7, movies.get(i).getRating());
				st.setBinaryStream(8, fis, (int) poster.length());

				st.executeUpdate();

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}

	public static MovieInfo getMovieInfo(File file) {
		MovieInfo movie = new MovieInfo();
		int index = 0;
		String line;
		try {
			BufferedReader br = null;
			System.out.println("File : " + file.getAbsolutePath());
			br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
			while ((line = br.readLine()) != null) {
				line.trim();
				String[] key_value = line.split(":", 2);

				switch (index) {
				case 0:
					// Get movie Name
					movie.setName(key_value[1].trim());
					break;
				case 1:
					// Get movie Year
					movie.setRelease_year(Integer.parseInt(key_value[1].trim()));
					break;
				case 2:
					// Get Total Reviews
					movie.setCertificate(key_value[1].trim());
					break;
				case 3:
					// Get Rank of the movie
					movie.setDuration(key_value[1].trim());
					break;
				case 4:
					// Get Total movies in the group
					line = br.readLine();
					movie.setGenre(line.split(","));
					break;
				case 5:
					// Get Address of the movie
					movie.setRating(Double.parseDouble(key_value[1].trim()));
					break;
				case 6:
					// Get Address of the movie
					movie.setDirectors(key_value[1].split(","));
					break;
				case 7:
					// Get Address of the movie
					movie.setActors(key_value[1].split(","));
					break;
				case 8:
					line = br.readLine();
					movie.setDescription(line);
					break;
				default:
					// Get Address of the movie
					movie.setDescription(movie.getDescription() + line);
					break;
				}

				index++;
			}
			br.close();
			// SolrService.insert(movie, Cores.movie);
			System.out.println(movie.getName());
			/*
			 * BufferedWriter out = new BufferedWriter(new
			 * FileWriter("/Users/Rahul/Documents/output.txt"));
			 * out.write(movie.toString()); out.newLine(); out.newLine();
			 * out.close();
			 */
		} catch (IOException e) {
			e.printStackTrace();
		}
		return movie;
	}
}
