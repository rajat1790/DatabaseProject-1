<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<jsp:include page="./header.jsp" />
<style>

.pagination>a, .pagination>span {
	border-radius: 50% !important;
	margin: 0 5px;
}
</style>
</head>
<body>

	<jsp:include page="./navbar.jsp" />
	<div class="container">
		
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

				<%--For displaying Previous link except for the 1st page --%>
				<c:if test="${currentPage != 1}">
					<td class="pagination"><a
						href="./home?page=${currentPage - 1}">Previous</a></td>
				</c:if>

				<c:forEach begin="${b}" end="${e}" var="i">
					<c:choose>
						<c:when test="${currentPage eq i}">
							<td>${i}</td>
						</c:when>
						<c:otherwise>
							<td class="pagination" align="center"><a
								href="./home?page=${i}">${i}</a></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<%--For displaying Next link --%>
				<c:if test="${currentPage lt noOfPages}">
					<td class="pagination"><a
						href="./home?page=${currentPage + 1}">Next</a></td>
				</c:if>
			</tr>
		</table>

		<table class="table table-striped">

			<c:forEach items="${movies}" var="movie" varStatus="count">
				<c:if test="${(count.index) % 3 == 0}">
					<tr>
				</c:if>

				<td>
					<div align="center">
						<img src="${movie.src}" style="width: 182px; height: 268px;" align="middle" /><br />
						<c:out value="${movie.name}" />
						<br />
						<div align="center">
						<c:url value="/addtolist" var="updateUrl">
  							<c:param name="id" value="${movie.id}"></c:param>
  						</c:url>
						<button class="btn btn-primary"
							onclick="location.href='${updateUrl}'">View</button>
						

					</div>
				</td>

				<c:if test="${(count.index) % 3 == 2}">
					</tr>
				</c:if>
			</c:forEach>
		</table>
		
		
		
		<%--For displaying Page numbers. 
        The when condition does not display a link for the current page--%>
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
				<%--For displaying Previous link except for the 1st page --%>
				<c:if test="${currentPage != 1}">
					<td class="pagination"><a
						href="./home?page=${currentPage - 1}">Previous</a></td>
				</c:if>
				<c:forEach begin="${b}" end="${e}" var="i">
					<c:choose>
						<c:when test="${currentPage eq i}">
							<td class="pagination">${i}</td>
						</c:when>
						<c:otherwise>
							<td class="pagination" align="center"><a
								href="./home?page=${i}">${i}</a></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>



				<%--For displaying Next link --%>
				<c:if test="${currentPage lt noOfPages}">
					<td class="pagination"><a
						href="./home?page=${currentPage + 1}">Next</a></td>
				</c:if>
			</tr>
		</table>
		
		
	</div>

</body>
</html>