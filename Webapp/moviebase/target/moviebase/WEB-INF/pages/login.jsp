<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<html>
<head>
<title>Login Page</title>
<script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

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

<link href="$../../resources/css/mylogin.css" rel="stylesheet" type="text/css"/>

</head>
<body>
	<div class="container">
		<div id="loginbox" style="margin-top: 50px;"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign In</div>
				</div>

				<div style="padding-top: 30px" class="panel-body">
					<c:if test="${not empty error}">
						<!--  Invalid Username Password -->
						<div class="error">${error}</div>
					</c:if>
					<c:if test="${not empty msg}">
						<!--  Logged out successfully -->
						<div class="msg">${msg}</div>
					</c:if>
					<div style="display: none" id="login-alert"
						class="alert alert-danger col-sm-12"></div>

					<form id="loginform" class="form-horizontal" role="form"
						name="loginform"
						action="<c:url value='/j_spring_security_check' />" method='POST'>

						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-user"></i></span> <input id="login-username"
								type="text" class="form-control" name="username" value=""
								placeholder="username">
						</div>

						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-lock"></i></span> <input id="login-password"
								type="password" class="form-control" name="password"
								placeholder="password">
						</div>

						<div style="margin-top: 10px" class="form-group">
							<div class="col-sm-12 controls">
								<input class="btn btn-success" id="btn-login" name="submit"
									type="submit" value="LOG IN" /> <input type="hidden"
									name="${_csrf.parameterName}" value="${_csrf.token}" />
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-12 control">
								<div
									style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
									Don't have an account! <a href="#"
										onClick="$('#loginbox').hide(); $('#signupbox').show()">
										Sign Up Here </a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div id="signupbox" style="display: none; margin-top: 50px"
			class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign Up</div>
				</div>
				<div class="panel-body">
					<form:form id="signupform" class="form-horizontal" role="form"  modelAttribute="userForm"
						action="./adduser?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" method="POST">
						<div id="signupalert" style="display: none"
							class="alert alert-danger">
							<p>Error:</p>
							<span></span>
						</div>

						<form:hidden path="id" />

						<spring:bind path="name">
							<div class="form-group">
								<label for="name" class="col-md-3 control-label">Name</label>
								<div class="col-md-9">
									<form:input path="name" type="text" class="form-control"
										name="name" placeholder="Name" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="email">
							<div class="form-group">
								<label for="email" class="col-md-3 control-label">Email</label>
								<div class="col-md-9">
									<form:input path="email" type="text" class="form-control"
										name="email" placeholder="Email Address" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="username">
							<div class="form-group">
								<label for="username" class="col-md-3 control-label">Username</label>
								<div class="col-md-9">
									<form:input path="username" type="text" class="form-control"
										name="username" placeholder="Username" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="password">
							<div class="form-group">
								<label for="password" class="col-md-3 control-label">Password</label>
								<div class="col-md-9">
									<form:input path="password" type="password"
										class="form-control" name="passwd" placeholder="Password" />
								</div>
							</div>
						</spring:bind>

						<spring:bind path="dob">
							<div class="form-group">
								<label for="date" class="col-md-3 control-label">Date of
									Birth</label>
								<div class="col-md-9">
									<form:input path="dob" type="date" name="bday"
										class="form-control" />
								</div>
							</div>
						</spring:bind>
						<%-- <spring:bind path="image"> --%>
							<div class="form-group">
								<label for="pic" class="col-md-3 control-label">Profile
									Picture</label>
								<div class="col-md-9">
									<input type="file" name="image" class="form-control" />
								</div>
							</div>
						<%-- </spring:bind> --%>

						<spring:bind path="genreName">
							<div class="form-group">
								<label for="genre" class="col-md-3 control-label">Favorite
									Genres</label>
								<div class="col-md-9">
									<!-- <input type="file" name="pic" class="form-control"> -->
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
									Already have an account? <a id="signinlink" href="#"
										onClick="$('#signupbox').hide(); $('#loginbox').show()">
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