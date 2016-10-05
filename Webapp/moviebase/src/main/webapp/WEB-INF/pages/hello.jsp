<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<jsp:include page="./header.jsp" />
<body>

	<jsp:include page="./navbar.jsp" />
	
	<sec:authorize access="hasRole('ROLE_USER')">
		<!-- For login user -->
		<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
		<script>
			function formSubmit() {
				document.getElementById("logoutForm").submit();
			}
		</script>

		<c:if test="${pageContext.request.userPrincipal.name != null}">
			<h2>
				User : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
		</c:if>
	</sec:authorize>
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