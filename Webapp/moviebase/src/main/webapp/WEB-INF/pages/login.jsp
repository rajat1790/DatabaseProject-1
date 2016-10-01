<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<jsp:include page="./header.jsp" />
<head>
<title>Login Page</title>

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
					<c:if test="${not empty error}"> <!--  Invalid Username Password -->
						<div class="error">${error}</div>
					</c:if>
					<c:if test="${not empty msg}"> <!--  Logged out successfully -->
						<div class="msg">${msg}</div>
					</c:if>
					<div style="display: none" id="login-alert"
						class="alert alert-danger col-sm-12"></div>

					<form id="loginform" class="form-horizontal" role="form" name="loginform"
						action="<c:url value='/j_spring_security_check' />" method='POST'>

						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
							<input id="login-username" type="text" class="form-control" name="username" 
								value="" placeholder="username">
						</div>

						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
							<input id="login-password" type="password" class="form-control" name="password"
								placeholder="password">
						</div>

						<div style="margin-top: 10px" class="form-group">
							<div class="col-sm-12 controls">
								<input class="btn btn-success" id="btn-login" name="submit"
									type="submit" value="LOG IN" /> 
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-12 control">
								<div style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
									Don't have an account! 
									<a href="#"onClick="$('#loginbox').hide(); $('#signupbox').show()">
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
					<form id="signupform" class="form-horizontal" role="form">
						<div id="signupalert" style="display: none"
							class="alert alert-danger">
							<p>Error:</p>
							<span></span>
						</div>
						
						<div class="form-group">
							<label for="name" class="col-md-3 control-label">Name</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="name" placeholder="Name">
							</div>
						</div>

						<div class="form-group">
							<label for="email" class="col-md-3 control-label">Email</label>
							<div class="col-md-9">
								<input type="text" class="form-control" name="email"
									placeholder="Email Address">
							</div>
						</div>

						<div class="form-group">
							<label for="password" class="col-md-3 control-label">Password</label>
							<div class="col-md-9">
								<input type="password" class="form-control" name="passwd"
									placeholder="Password">
							</div>
						</div>

						<div class="form-group">
							<label for="date" class="col-md-3 control-label">Date of Birth</label>
							<div class="col-md-9">
								<input type="date" name="bday" class="form-control">
							</div>
						</div>
						
						<div class="form-group">
							<label for="pic" class="col-md-3 control-label">Profile Picture</label>
							<div class="col-md-9">
								<input type="file" name="pic" class="form-control">
							</div>
						</div>
						
						<div class="form-group">
							<label for="genre" class="col-md-3 control-label">Favorite Genres</label>
							<div class="col-md-9">
								<!-- <input type="file" name="pic" class="form-control"> -->
								<select name="skills" multiple="" class="form-control">
									<c:forEach items="${genres}" var="genre" varStatus="ctr">
										<option id="${genre.id}" value="${genre.name}">${genre.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group">
							<!-- Button -->
							<div class="col-md-offset-3 col-md-9">
								<button id="btn-signup" type="button" class="btn btn-info">
									<i class="icon-hand-right"></i> &nbsp Sign Up
								</button>
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-12 control">
								<div style="border-top: 1px solid #888; padding-top: 15px; font-size: 85%">
									Already have an account? 
									<a id="signinlink" href="#"onClick="$('#signupbox').hide(); $('#loginbox').show()">
										Sign In </a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>