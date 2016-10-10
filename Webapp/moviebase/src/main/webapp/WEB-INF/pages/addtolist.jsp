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
						</div>
					</div>

				</div>
			</div>
			<c:choose>
			<c:when test="${viewDetails == false}">
			<div class="container-fluid">
				<div class="col-md-12 product-info">
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade in active" id="service-one">
							<section class="container product-info">
								<form:form id="addToListForm" class="form-horizontal"
									role="form" modelAttribute="addMovieForm"
									action="./addtolist?${_csrf.parameterName}=${_csrf.token}"
									method="POST">
									<form:hidden path="movieID" val="${movie.id}" />

									<spring:bind path="comment">
										<div class="form-group">
											<label for="comment" class="col-md-3 control-label">Your
												View:</label>
											<div class="col-md-9">
												<form:textarea path="comment" class="form-control"
													name="comment" placeholder="Your View..." />
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
											</div>
										</div>
									</spring:bind>


									<spring:bind path="wishOrWatch">
										<div class="form-group">
											<label for="wishOrWatch" class="col-md-3 control-label">Add
												To:</label>
											<div class="col-md-9">
												<form:select path="wishOrWatch" name="wishOrWatch" value="wishOrWatch"
													class="form-control">
													<option id="0" value=0 >Wishlist</option>
													<c:choose>
														<c:when test="${not empty isWatched}">
															<option id="1" value=1 selected>Watched</option>
														</c:when>
														<c:otherwise>
															<option id="1" value=1 >Watched</option>
														</c:otherwise>
													</c:choose>
													
												</form:select>
											</div>
										</div>
									</spring:bind>

									<spring:bind path="rating">
										<div class="form-group">
											<label for="rating" class="col-md-3 control-label">Your
												Rating:</label>
											<div class="col-md-9">
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
			</c:when>
			</c:choose>
		</div>
	</div>
</body>
</html>