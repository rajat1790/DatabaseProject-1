<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<jsp:include page="./header.jsp" />
<body>

	<jsp:include page="./navbar.jsp" />
	
	<div class="container">

		<c:if test="${not empty msg}">
			<div class="alert alert-${css} alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<strong>${msg}</strong>
			</div>
		</c:if>
		<c:if test="${not empty emptymsg }">
			<div class="row text-center">
		        <div class="col-sm-6 col-sm-offset-3">
		        <br><br> <h3 style="color:#0fad00">OOPS!!</h3>
		        <p style="font-size:20px;color:#5C5C5C;">${emptymsg}</p>
		    	<br><br>
		        </div>
		   </div>
		</c:if>



		<table class="table table-striped">

			<c:forEach items="${movies}" var="movie" varStatus="count">
				<c:if test="${(count.index) % 3 == 0}">
					<tr>
				</c:if>

				<td>
					<div>
						<img src="${movie.src}" style="width: 182px; height: 268px;" align="middle" /><br />
						<c:out value="${movie.name}" />
						<br />
						<c:url value="/viewmovie" var="viewURL">
  							<c:param name="id" value="${movie.id}"></c:param>
  						</c:url>
						<button class="btn btn-info" onclick="location.href='${viewURL}'">View</button>
						<c:url value="/addtolist" var="updateUrl">
  							<c:param name="id" value="${movie.id}"></c:param>
  						</c:url>
						<button class="btn btn-primary"
							onclick="location.href='${updateUrl}'">Update</button>
						<c:url value="/deletemovie" var="deleteUrl">
  							<c:param name="id" value="${movie.id}"></c:param>
  						</c:url>
						<button class="btn btn-danger"
							onclick="location.href='${deleteUrl}'">Delete</button>

					</div>
				</td>

				<c:if test="${(count.index) % 3 == 2}">
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</div>

</body>
</html>