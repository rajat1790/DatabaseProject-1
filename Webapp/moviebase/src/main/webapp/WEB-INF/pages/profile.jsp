<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<html>
<head>
<title>Search Results</title>
<jsp:include page="./header.jsp" />
<link href="resources/css/user.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="./navbar.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
				<div class="well profile">
					<div class="col-sm-12">
						<div class="col-xs-12 col-sm-8">
							<h2>${user.name}</h2>
							<p>
								<strong>Email: </strong> ${user.email}
							</p>
							<p>
								<strong>Username: </strong> ${user.username}
							</p>
							<p>
								<strong>Date of Birth: </strong> ${user.dob}
							</p>
							<p>
								<strong>Favorite Genres: </strong>
								<c:forEach items="${user.genreName}" var="genre" varStatus="ctr">
									<span class="tags">${genre}</span>
								</c:forEach>
                    </p>
                </div>             
                <div class="col-xs-12 col-sm-4 text-center">
                    <figure>
                        <img src="${user.src}" alt="" class=" img-circle img-profile" width="150" height="150">
							</figure>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>