<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<html>
<jsp:include page="./header.jsp" />
<head>
<title>Sign-Up Page</title>

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous">
	
</script>

<link href="$../../resources/css/mylogin.css" rel="stylesheet"
	type="text/css" />

</head>

<body>

	<div class="container">
		<div id="signupbox"
			margin-top: 50px"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign Up</div>
				</div>
				<div class="panel-body">
					<form:form data-toggle="validator" id="signupform"
						class="form-horizontal" role="form" modelAttribute="userForm"
						action="./adduser?${_csrf.parameterName}=${_csrf.token}"
						enctype="multipart/form-data" method="POST">

						<c:if test="${not empty errors}">
							<div id="signupalert" class="alert alert-danger">
								<p>Error:
									<p>${errors}</p>
								</p>
							</div>
						</c:if>

						<form:hidden path="id" />

						<spring:bind path="name">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="name" class="col-md-3 control-label">Name</label>
								<div class="col-md-9">
									<form:input path="name" type="text" data-minlength="6"
										class="form-control" name="name" placeholder="Name" />
									<form:errors path="name" class="control-label" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="email">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="email" class="col-md-3 control-label">Email</label>
								<div class="col-md-9">
									<form:input path="email" type="text" class="form-control"
										name="email" placeholder="Email Address" />
									<form:errors path="name" class="control-label" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="username">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="username" class="col-md-3 control-label">Username</label>
								<div class="col-md-9">
									<form:input path="username" type="text" class="form-control"
										name="username" placeholder="Username" />
									<form:errors path="name" class="control-label" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="password">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="password" class="col-md-3 control-label">Password</label>
								<div class="col-md-9">
									<form:input path="password" type="password"
										class="form-control" name="passwd" placeholder="Password" />
									<form:errors path="name" class="control-label" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="dob">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="date" class="col-md-3 control-label">Date of
									Birth</label>
								<div class="col-md-9">
									<form:input path="dob" type="date" name="bday"
										class="form-control" />
								</div>
							</div>
						</spring:bind>
						<div class="form-group ${status.error ? 'has-error' : ''}">
							<label for="pic" class="col-md-3 control-label">Profile
								Picture</label>
							<div class="col-md-9">
								<input type="file" name="image" class="form-control" />
							</div>
						</div>
						<spring:bind path="genreName">
							<div class="form-group ${status.error ? 'has-error' : ''}">
								<label for="genre" class="col-md-3 control-label">Favorite
									Genres</label>
								<div class="col-md-9">
									<form:select multiple="true" path="genreId" name="genreNames"
										class="form-control">
										<c:forEach items="${genres}" var="genre" varStatus="ctr">
											<option id="${genre.id}" value="${genre.id}">${genre.name}</option>
										</c:forEach>
									</form:select>
								</div>
							</div>
						</spring:bind>

						<div class="form-group">
							<!-- Button -->
							<div class="col-md-offset-3 col-md-9">
								<input class="btn btn-info" id="tn-signup" name="submit"
									type="submit" value="Sign Up" />
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-12 control">
								<div
									style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
									Already have an account? <a id="signinlink" href="./login">
										Sign In </a>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>