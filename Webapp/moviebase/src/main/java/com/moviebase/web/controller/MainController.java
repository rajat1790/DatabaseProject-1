package com.moviebase.web.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.moviebase.web.model.genre.Genre;
import com.moviebase.web.model.genre.GenreDao;
import com.moviebase.web.model.movie.Movie;
import com.moviebase.web.model.movie.MovieDao;
import com.moviebase.web.model.user.User;
import com.moviebase.web.model.user.UserDao;

@Controller
public class MainController {

	@Autowired
	public UserDao userDao;
	@Autowired
	public GenreDao genreDao;
	@Autowired
	public MovieDao movieDao;

	@RequestMapping(value = { "/", "/welcome**" }, method = RequestMethod.GET)
	public ModelAndView defaultPage() {

		List<Movie> movies = movieDao.getFiftyMovies();
		ModelAndView model = new ModelAndView();
		model.addObject("title", "Moviebase");
		model.addObject("message", "This is default page!");
		model.addObject("movies", movies);
		model.setViewName("hello");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName(); // get logged in username
		User user = userDao.findByUsername(username);
		System.out.println(user.toString());
		return model;

	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {

		ModelAndView model = new ModelAndView();
		model.addObject("title", "Moviebase");
		model.addObject("message", "This page is for ROLE_ADMIN only!");
		model.setViewName("admin");

		return model;

	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			System.out.println(" error:" + error);
			model.addObject("error", "Invalid username and password!");
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}

		List<Genre> genreList = genreDao.getAllGenres();
		model.addObject("genres", genreList);

		User user = new User();
		model.addObject("userForm", user);

		model.setViewName("login");

		return model;

	}

	@RequestMapping(value = "/adduser", method = RequestMethod.POST)
	// public @ResponseBody
	public ModelAndView createUser(@ModelAttribute("userForm") User user, BindingResult result,
			@RequestParam("image") MultipartFile image) {

		// ModelAndView model = new ModelAndView();
		// model.setViewName("redirect:/");
		System.out.println("Came here");
		if (!image.isEmpty()) {
			try {
				user.setPic(image.getBytes());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		userDao.insert(user);
		return new ModelAndView("redirect:/admin");

	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	// public @ResponseBody
	public ModelAndView searchMovies(@RequestParam("search_param") String searchBy,
			@RequestParam("search_term") String searchTerm) {

		// ModelAndView model = new ModelAndView();
		// model.setViewName("redirect:/");
		if (searchTerm.trim().length() == 0)
			return new ModelAndView("redirect:/");

		ModelAndView model = new ModelAndView();
		List<Movie> movieResults = null;
		switch (searchBy) {
		case "moviename":
			movieResults = movieDao.findByName(searchTerm);
			break;
		case "actorname":
			break;
		case "genre":
			break;
		case "director":
			movieResults = movieDao.findByDirector(searchTerm);
			break;
		}
		for (Movie movie : movieResults) {
			System.out.println("movie:" + movie);
		}
		model.addObject("numResults", movieResults.size());
		model.addObject("movieResults", movieResults);
		model.addObject("searchTerm", searchTerm);
		model.setViewName("search");
		return model;

	}

	// for 403 access denied page
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();

		// check if user is login
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);

			model.addObject("username", userDetail.getUsername());

		}

		model.setViewName("403");
		return model;

	}

}