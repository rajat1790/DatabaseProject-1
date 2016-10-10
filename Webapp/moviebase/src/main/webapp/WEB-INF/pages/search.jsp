<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<html>
<head>
<title>Search Results</title>
<jsp:include page="./header.jsp" />
<style>
@import "http://fonts.googleapis.com/css?family=Roboto:300,400,500,700";

.container {
	margin-top: 20px;
}

.mb20 {
	margin-bottom: 20px;
}

hgroup {
	padding-left: 15px;
	border-bottom: 1px solid #ccc;
}

hgroup h1 {
	font: 500 normal 1.625em "Roboto", Arial, Verdana, sans-serif;
	color: #2a3644;
	margin-top: 0;
	line-height: 1.15;
	text-align: center;
}

hgroup h2.lead {
	font: normal normal 1.125em "Roboto", Arial, Verdana, sans-serif;
	color: #2a3644;
	margin: 0;
	padding-bottom: 10px;
	text-align: center;
}

.search-result .thumbnail {
	border-radius: 0 !important;
}

.search-result:first-child {
	margin-top: 0 !important;
}

.search-result {
	margin-top: 20px;
}

.search-result .col-md-2 {
	border-right: 1px dotted #ccc;
	min-height: 140px;
}

.search-result ul {
	padding-left: 0 !important;
	list-style: none;
}

.search-result ul li {
	font: 400 normal .85em "Roboto", Arial, Verdana, sans-serif;
	line-height: 30px;
}

.search-result ul li i {
	padding-right: 5px;
}

.search-result .col-md-8 {
	position: relative;
}

.search-result h3 {
	font: 500 normal 1.375em "Roboto", Arial, Verdana, sans-serif;
	margin-top: 0 !important;
	margin-bottom: 10px !important;
}

.search-result h3>a, .search-result i {
	color: #248dc1 !important;
}

.search-result p {
	font: normal normal 1.125em "Roboto", Arial, Verdana, sans-serif;
}

.search-result span.plus {
	position: absolute;
	right: 0;
	top: 126px;
}

.search-result span.plus a {
	background-color: #248dc1;
	padding: 5px 5px 3px 5px;
}

.search-result span.plus a:hover {
	background-color: #414141;
}

.search-result span.plus a i {
	color: #fff !important;
}

.search-result span.border {
	display: block;
	width: 97%;
	margin: 0 15px;
	border-bottom: 1px dotted #ccc;
}

.pagination>a, .pagination>span {
	border-radius: 50% !important;
	margin: 0 5px;
}
</style>
</head>
<body>
	<jsp:include page="./navbar.jsp" />
	<div class="container">


		<hgroup class="mb20">
			<h1>Search Results</h1>
			<h2 class="lead">
				<strong class="text-danger">${numResults}</strong> results were
				found for the search for <strong class="text-danger">${searchTerm}</strong>
			</h2>
		</hgroup>

		<input type="hidden" name="search_param" value="${searchBy} }" /> <input
			type="hidden" name="search_term" value="${searchTerm} }" />


		<%--For displaying Page numbers. 
        The when condition does not display a link for the current page--%>
		<table cellpadding="5" cellspacing="5" align="center">
			<col align="center">
			<tr align="center">
				<c:choose>
					<c:when test="${currentPage - 10 lt '1'}">
						<c:set var="b" value="1" />
					</c:when>
					<c:otherwise>
						<c:set var="b" value="${currentPage - 10}" />
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${currentPage + 10 lt noOfPages}">
						<c:set var="e" value="${currentPage + 10}" />
					</c:when>
					<c:otherwise>
						<c:set var="e" value="${noOfPages}" />
					</c:otherwise>
				</c:choose>

				<c:if test="${currentPage != 1}">
					<td class="pagination"><a
						href="./search?page=${currentPage - 1}&search_param=${searchBy}&search_term=${searchTerm}">Previous</a></td>
				</c:if>

				<c:forEach begin="${b}" end="${e}" var="i">
					<c:choose>
						<c:when test="${currentPage eq i}">
							<td>${i}</td>
						</c:when>
						<c:otherwise>
							<td class="pagination" align="center"><a
								href="./search?page=${i}&search_param=${searchBy}&search_term=${searchTerm}">${i}</a></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${currentPage lt noOfPages}">
					<td class="pagination"><a
						href="./search?page=${currentPage + 1}&search_param=${searchBy}&search_term=${searchTerm}">Next</a></td>
				</c:if>
			</tr>
		</table>



		<section class="col-xs-12 col-sm-6 col-md-12">
			<c:forEach items="${movieResults}" var="movie" varStatus="ctr">
				<article class="search-result row">
					<div class="col-xs-12 col-sm-12 col-md-2">
						<img src="${movie.src}" style="width: 152px; height: 182px;"
							align="middle" class="thumbnail" /><br />
					</div>
					<div class="col-xs-12 col-sm-12 col-md-2">
						<ul class="meta-search">
							<li><i class="glyphicon glyphicon-calendar"></i> <span>${movie.year}</span></li>
							<li><i class="glyphicon glyphicon-time"></i> <span>${movie.duration}</span></li>
							<li><i class="glyphicon glyphicon-star-empty"></i> <span>${movie.rating}</span></li>
							<li><i class="glyphicon glyphicon-certificate"></i> <span>${movie.certificate}</span></li>
						</ul>
					</div>
					<div class="col-xs-12 col-sm-12 col-md-8 excerpet">
						<h3>${movie.name}</h3>
						<p>${movie.summary}</p>
						<ul class="meta-search">
							<li><i class="glyphicon glyphicon-facetime-video"></i> <span>${movie.director}</span></li>
							<li><i class="glyphicon glyphicon-user"></i> <c:forEach
									items="${movie.actors}" var="actor" varStatus="count">
									<span>${actor}&nbsp; &nbsp;</span>
								</c:forEach></li>
						</ul>
						<c:url value="/addtolist" var="url">
							<c:param name="id" value="${movie.id}"></c:param>
						</c:url>
						<span class="btn btn-primary btn-success" ><a href="${url}"
							title="Add to List">Add to my list <i
								class="glyphicon glyphicon-plus"></i>
						</a></span>
					</div>
					<span class="clearfix borda"></span>
				</article>
			</c:forEach>
		</section>

		<table cellpadding="5" cellspacing="5" align="center">
			<col align="center">
			<tr align='center'>
				<c:choose>
					<c:when test="${currentPage - 10 lt '1'}">
						<c:set var="b" value="1" />
					</c:when>
					<c:otherwise>
						<c:set var="b" value="${currentPage - 10}" />
					</c:otherwise>
				</c:choose>

				<c:choose>
					<c:when test="${currentPage + 10 lt noOfPages}">
						<c:set var="e" value="${currentPage + 10}" />
					</c:when>
					<c:otherwise>
						<c:set var="e" value="${noOfPages}" />
					</c:otherwise>
				</c:choose>
				<c:if test="${currentPage != 1}">
					<td class="pagination"><a
						href="./search?page=${currentPage - 1}&search_param=${searchBy}&search_term=${searchTerm}">Previous</a></td>
				</c:if>
				<c:forEach begin="${b}" end="${e}" var="i">
					<c:choose>
						<c:when test="${currentPage eq i}">
							<td class="pagination">${i}</td>
						</c:when>
						<c:otherwise>
							<td class="pagination" align="center"><a
								href="./search?page=${i}&search_param=${searchBy}&search_term=${searchTerm}">${i}</a></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>



				<c:if test="${currentPage lt noOfPages}">
					<td class="pagination"><a
						href="./search?page=${currentPage + 1}&search_param=${searchBy}&search_term=${searchTerm}">Next</a></td>
				</c:if>
			</tr>
		</table>

	</div>
</body>
</html>