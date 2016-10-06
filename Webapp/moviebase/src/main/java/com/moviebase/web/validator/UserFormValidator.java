package com.moviebase.web.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.moviebase.web.model.user.User;

@Component
public class UserFormValidator implements Validator {

	@Autowired
	@Qualifier("emailValidator")
	EmailValidator emailValidator;

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		System.out.println("Check bhosda");
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

		if (user.getPic() != null && user.getPic().length > 10000000) {
			errors.rejectValue("pic", "Please select an image of less that 10MB in size");
		}

	}

}