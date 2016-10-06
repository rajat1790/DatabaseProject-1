<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<html>
<head>
<title>Search Results</title>
<jsp:include page="./header.jsp" />
<link href="resources/css/addlist.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="./navbar.jsp" />
	<div class="container-fluid">
		<div class="content-wrapper">
			<div class="item-container">
				<div class="container">
					<div class="row">
						<div class="col-md-3">
							<div class="product service-image-right">
								<img src="${movie.src}" style="width: 182px; height: 268px;"
									align="middle" /><br />
								<!-- <img id="item-display" src="http://www.corsair.com/Media/catalog/product/g/s/gs600_psu_sideview_blue_2.png" alt=""></img>
					 -->
							</div>
						</div>

						<div class="col-md-9">
							<div class="product-title">${movie.name }</div>
							<div class="product-desc">${movie.summary }</div>
							<ul class="meta-search">
								<p><i class="glyphicon glyphicon-calendar"></i> <span>${movie.year}</span></p>
								<p><i class="glyphicon glyphicon-time"></i> <span>${movie.duration}</span></p>
								<p><i class="glyphicon glyphicon-star"></i> <span>${movie.rating}</span></p>
								<p><i class="glyphicon glyphicon-facetime-video"></i> <span>${movie.director}</span></p>
								<p><i class="glyphicon glyphicon-certificate"></i> <span>${movie.certificate}</span></p>
								<p><i class="glyphicon glyphicon-user"></i>
								
										<c:forEach items="${movie.actors}" var="actor"
											varStatus="count">

											<span >${actor}&nbsp; &nbsp;</span>

										</c:forEach>
									</p>
							</ul>
							<!-- <div class="btn-group cart">
						<button type="button" class="btn btn-success">
							Add to cart 
						</button>
					</div>
					<div class="btn-group wishlist">
						<button type="button" class="btn btn-danger">
							Add to wishlist 
						</button>
					</div> -->
						</div>
					</div>

				</div>
			</div>
			<div class="container-fluid">
				<div class="col-md-12 product-info">
					<!-- <ul id="myTab" class="nav nav-tabs nav_tabs">
						<li class="active"><a href="#service-one" data-toggle="tab">Your View</a></li>	
					</ul> -->
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade in active" id="service-one">
							<section class="container product-info">
								<form:form id="addToListForm" class="form-horizontal"
									role="form" modelAttribute="addMovieForm"
									action="./addtolist?${_csrf.parameterName}=${_csrf.token}"
									method="POST">
									<%-- <form id="addToListForm" class="form-horizontal" role="form"  
								action="./addToList?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" method="POST">
								 --%>
									<form:hidden path="movieID" val="${movie.id}" />

									<spring:bind path="comment">
										<div class="form-group">
											<label for="comment" class="col-md-3 control-label">Your
												View:</label>
											<div class="col-md-9">
												<%-- <form:input path="name" type="text" class="form-control"
										name="name" placeholder="Name" /> --%>
												<form:textarea path="comment" class="form-control"
													name="comment" placeholder="Your View..." />
												<!-- </textarea> -->
											</div>
										</div>
									</spring:bind>

									<spring:bind path="watchDate">
										<div class="form-group">
											<label for="watchDate" class="col-md-3 control-label">Watch
												Date:</label>
											<div class="col-md-9">
												<form:input path="watchDate" type="date" name="watchDate"
													class="form-control" />
												<!-- <input  type="date" name="watch" class="form-control" > -->
											</div>
										</div>
									</spring:bind>


									<spring:bind path="wishOrWatch">
										<div class="form-group">
											<label for="wishOrWatch" class="col-md-3 control-label">Add
												To:</label>
											<div class="col-md-9">
												<%-- <form:select multiple="true" path="genreId" name="genreNames"
										class="form-control"> --%>
												<form:select path="wishOrWatch" name="wishOrWatch"
													class="form-control">
													<option id="0" value=0>Wishlist</option>
													<option id="1" value=1>Watched</option>
												</form:select>
												<%-- </form:select> --%>
											</div>
										</div>
									</spring:bind>

									<spring:bind path="rating">
										<div class="form-group">
											<label for="rating" class="col-md-3 control-label">Your
												Rating:</label>
											<div class="col-md-9">
												<%-- <form:input path="name" type="text" class="form-control"
										name="name" placeholder="Name" /> --%>
												<form:input path="rating" type="number" min="0" max="5"
													class="form-control" name="rating" placeholder="Rating.." />
											</div>
										</div>
									</spring:bind>

									<input id="isUpdate" name="isUpdate" type="hidden"
										value="${isUpdate}" />
									<div class="form-group">
										<!-- Button -->
										<c:choose>
											<c:when test="${viewQuery == true}">
												<div class="btn-group col-md-offset-6 cart button-update">
													<input class="btn btn-success" type="submit" name="submit"
														value="Update" />
												</div>
												<c:url value="/deletemovie" var="deleteUrl">
													<c:param name="id" value="${movie.id}"></c:param>
												</c:url>
												<div class="btn-group wishlist">
													<button type="button"
														onclick="location.href='${deleteUrl}'"
														class="btn btn-danger">Delete</button>
												</div>
											</c:when>
											<c:otherwise>
												<c:set var="button_name" value="Add To List" />
												<c:if test="${isUpdate == true}">
													<c:set var="button_name" value="Update" />
												</c:if>
												<div class="col-md-offset-3 col-md-9">
													<input class="btn btn-info" id="tn-submit" name="submit"
														type="submit" value="${button_name }" />
												</div>
											</c:otherwise>
										</c:choose>


									</div>
								</form:form>
								<%-- </form> --%>
							</section>

						</div>
						<div class="tab-pane fade" id="service-two">

							<section class="container"></section>

						</div>
						<div class="tab-pane fade" id="service-three"></div>
					</div>
					<hr>
				</div>
			</div>
		</div>
	</div>
</body>
</html>