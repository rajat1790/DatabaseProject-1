package com.moviebase.web.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.moviebase.web.model.userMovieList.UserMovieList;
import com.moviebase.web.model.userMovieList.UserMovieListDao;
import com.moviebase.web.validator.UserFormValidator;

@Controller
public class MainController {
	int userId;
	User loggedInUser = null;
	List<Genre> genreList = null;
	HashMap<String, Integer> genreKeyValue = new HashMap<String, Integer>();
	@Autowired
	public UserDao userDao;
	@Autowired
	public GenreDao genreDao;
	@Autowired
	public MovieDao movieDao;
	@Autowired
	public UserMovieListDao userMovieListDao;
	@Autowired
	UserFormValidator userFormValidator;

	String errors = "";

	@InitBinder("userForm")
	protected void initBinder(WebDataBinder binder) {
		binder.setValidator(userFormValidator);
	}

	@RequestMapping(value = { "/", "/welcome**" }, method = RequestMethod.GET)

	public ModelAndView defaultPage() {

		if (loggedInUser == null) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String username = auth.getName(); // get logged in username
			User user = userDao.findByUsername(username);
			userId = user.getId();
			loggedInUser = user;
		}

		List<Movie> movies = userMovieListDao.getMovieListOfUser(userId);
		ModelAndView model = new ModelAndView();
		model.addObject("genres", genreList);
		model.addObject("title", "Moviebase");
		model.addObject("message", "This is default page!");
		model.addObject("movies", movies);
		model.setViewName("hello");

		// System.out.println("get User Id:"+ user.getId());
		System.out.println("User Id:" + userId);
		// System.out.println(user.toString());
		return returnModel(model);

	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {

		ModelAndView model = new ModelAndView();
		model.addObject("title", "Moviebase");
		model.addObject("message", "This page is for ROLE_ADMIN only!");
		model.setViewName("admin");

		return returnModel(model);

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
		loggedInUser = null;
		// User user = new User();
		// model.addObject("userForm", user);

		model.setViewName("login");

		return returnModel(model);

	}

	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signup() {

		ModelAndView model = new ModelAndView();
		List<Genre> genreList = genreDao.getAllGenres();
		model.addObject("genres", genreList);
		User user = new User();
		model.addObject("errors", errors);
		model.addObject("userForm", user);

		model.setViewName("signup");

		return returnModel(model);

	}

	@RequestMapping(value = "/adduser", method = RequestMethod.POST)
	// public @ResponseBody
	public ModelAndView createUser(@ModelAttribute("userForm") @Validated User user, BindingResult result,
			@RequestParam("image") MultipartFile image) {

		ModelAndView model = new ModelAndView();
		System.out.println("error count : " + result.getAllErrors().size());
		if (result.getAllErrors().size() > 2) {
			List<ObjectError> e = result.getAllErrors();
			System.out.println(e.size());
			errors = "";
			for (int i = 2; i < e.size(); i++) {
				System.out.println(e.get(i).getCode());
				errors = errors + e.get(i).getCode() + "<br/>";
			}
			model.setViewName("redirect:/signup");
			return returnModel(model);
		} else {
			System.out.println("Came here");
			if (!image.isEmpty()) {
				try {
					user.setPic(image.getBytes());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			userDao.insert(user);
			model.setViewName("redirect:/login");
			return returnModel(model);
		}

	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	// public @ResponseBody
	public ModelAndView searchMovies(@RequestParam("search_param") String searchBy,
			@RequestParam(value = "search_term", required = false) String searchTerm) {

		// ModelAndView model = new ModelAndView();
		// model.setViewName("redirect:/");
		if (searchTerm.trim().length() == 0)
			return returnModel(new ModelAndView("redirect:/"));
		System.out.println("Search Term:" + searchTerm);
		if (searchBy.equals("genre")) {
			searchTerm = searchTerm.substring(1);
			System.out.println("Search Term Genre:" + searchTerm);
		} else {
			int index = searchTerm.lastIndexOf(',');
			searchTerm = searchTerm.substring(0, index);
			System.out.println("Search Term Inside:" + searchTerm);
		}
		System.out.println("Search By:" + searchBy);
		System.out.println("Search Term:" + searchTerm);
		ModelAndView model = new ModelAndView();
		List<Movie> movieResults = null;
		switch (searchBy) {
		case "moviename":
			movieResults = movieDao.findByName(searchTerm);
			break;
		case "actorname":
			break;
		case "genre":
			movieResults = movieDao.findByGenre(genreKeyValue.get(searchTerm));
			break;
		case "director":
			movieResults = movieDao.findByDirector(searchTerm);
			break;
		}
//		for (Movie movie : movieResults) {
//			System.out.println("movie:" + movie);
//		}
		model.addObject("numResults", movieResults.size());
		model.addObject("movieResults", movieResults);
		model.addObject("searchTerm", searchTerm);
		model.setViewName("search");
		return returnModel(model);

	}


	@RequestMapping(value = "/addtolist", method = RequestMethod.GET)
	// public @ResponseBody
	public ModelAndView addToList(@RequestParam("id") int movieId) {

		ModelAndView model = new ModelAndView();
		model.setViewName("addtolist");
		Movie movie = movieDao.findById(movieId);
		model.addObject("movie", movie);
		boolean update = false;
		UserMovieList userMovie = userMovieListDao.findByIds(userId, movieId);
		if (userMovie == null) {
			userMovie = new UserMovieList();
			userMovie.setMovieID(movieId);
		} else {
			update = true;
		}

		model.addObject("addMovieForm", userMovie);
		model.addObject("isUpdate", update);
		return returnModel(model);

	}

	@RequestMapping(value = "/viewmovie", method = RequestMethod.GET)
	// public @ResponseBody
	public ModelAndView viewMovie(@RequestParam("id") int movieId) {

		ModelAndView model = new ModelAndView();
		model.setViewName("addtolist");
		Movie movie = movieDao.findById(movieId);
		model.addObject("movie", movie);
		boolean update = true;
		UserMovieList userMovie = userMovieListDao.findByIds(userId, movieId);

		model.addObject("addMovieForm", userMovie);
		model.addObject("isUpdate", update);
		model.addObject("viewQuery", true);
		return returnModel(model);

	}

	@RequestMapping(value = "/addtolist", method = RequestMethod.POST)
	// public @ResponseBody
	public ModelAndView addToList(@ModelAttribute("addMovieForm") UserMovieList userMovie, BindingResult result,
			@RequestParam("isUpdate") boolean isUpdate) {

		// System.out.println("User Id:" + userId);
		userMovie.setUserID(userId);
		System.out.println("Came movie list insert/update:" + userMovie.toString());
		if (isUpdate) {
			userMovieListDao.updateMovie(userMovie);
		} else {
			userMovieListDao.insertMovie(userMovie);
		}
		return returnModel(new ModelAndView("redirect:/welcome"));

	}

	@RequestMapping(value = "/deletemovie", method = RequestMethod.GET)
	public ModelAndView deleteMovie(@RequestParam("id") int movieId) {

		userMovieListDao.deleteMovie(userId, movieId);
		return returnModel(new ModelAndView("redirect:/welcome"));

	}

	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	// public @ResponseBody
	public ModelAndView userProfile() {

		ModelAndView model = new ModelAndView();
		model.setViewName("profile");
		model.addObject("user", loggedInUser);
		System.out.println("SRC:"+ loggedInUser.getSrc());
		return returnModel(model);

	}

	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	// public @ResponseBody
	public ModelAndView calendar() {

		ModelAndView model = new ModelAndView();
		model.setViewName("calendar");
		// model.addObject("user", loggedInUser);
		return returnModel(model);

	}

	// for 403 access denied page

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detailPage() {

		List<Movie> movies = movieDao.getFiftyMovies();
		ModelAndView model = new ModelAndView();
		model.addObject("title", "Moviebase");
		model.addObject("message", "This is default page!");
		model.addObject("movies", movies);
		model.setViewName("detail");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName(); // get logged in username
		User user = userDao.findByUsername(username);
		System.out.println(user.toString());
		return returnModel(model);

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
		return returnModel(model);

	}
	
	public ModelAndView returnModel(ModelAndView model) {
		if (genreList == null) {
			genreList = genreDao.getAllGenres();
			for(Genre genre: genreList) {
				genreKeyValue.put(genre.getName(), genre.getId());
			}
		}
		model.addObject("genres", genreList);
		return model;
	}

}