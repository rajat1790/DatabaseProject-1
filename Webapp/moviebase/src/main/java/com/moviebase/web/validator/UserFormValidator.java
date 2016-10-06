package com.moviebase.web.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.moviebase.web.model.user.User;
import com.moviebase.web.model.user.UserDao;

@Component
public class UserFormValidator implements Validator {

	@Autowired
	@Qualifier("emailValidator")
	EmailValidator emailValidator;

	@Autowired
	public UserDao userDao;

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;

		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "Name is required!");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "Email is required!");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "Username is required!");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "Password is required!");

		if (!emailValidator.valid(user.getEmail())) {
			System.out.println("Invalid email type");
			errors.rejectValue("email", "Invalid Email format!");
		}

		if (user.getGenreId() == null || user.getGenreId().size() < 1) {
			errors.rejectValue("genreName", "Please select at least one genre!");
		}

		if (user.getUsername() != null && userDao.findIdByUsername(user.getUsername()) != -1) {
			errors.rejectValue("username", "Username already exists!");
		}

	}

}