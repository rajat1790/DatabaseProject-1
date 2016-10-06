<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(document).ready(function(e){
    $('.search-panel .dropdown-menu').find('a').click(function(e) {
		e.preventDefault();
		var param = $(this).attr("href").replace("#","");
		var concept = $(this).text();
		$('.search-panel span#search_concept').text(concept);
		$('.input-group #search_param').val(param);
	});
});
</script>
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
<nav class="navbar navbar-default" role="navigation">
	<!-- Brand and toggle get grouped for better mobile display -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#bs-example-navbar-collapse-1">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="./welcome">MovieBase</a>
	</div>

	<!-- Collect the nav links, forms, and other content for toggling -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="./welcome">Home</a></li>
		</ul>
		<div>
			<form class="navbar-form navbar-left" action="./search?${_csrf.parameterName}=${_csrf.token}" method="POST">
				<div class="input-group">
				<div class="input-group-btn search-panel">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    	<span id="search_concept">Movie Name</span> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="#moviename">Movie Name</a></li>
                      <li><a href="#actorname">Actor Name</a></li>
                      <li><a href="#genre">Genre</a></li>
                      <li><a href="#director">Director</a></li>
                    </ul>
                </div>
                <input type="hidden" name="search_param" value="moviename" id="search_param">         
                <input type="text" class="form-control" name="search_term" placeholder="Search by ...">
                <span class="input-group-btn">
                    <button class="btn btn-default " type="submit">Search</button>
                </span>
				</div>
			</form>
			
		</div>
		<ul class="nav navbar-nav navbar-right">
			 <c:if test="${pageContext.request.userPrincipal.name != null}">
				<li><p class="navbar-text">Hi <a href="#"> ${pageContext.request.userPrincipal.name}</a> | </p></li>
				<li><a href="javascript:formSubmit()"> Logout</a></li> 
			</c:if>  
			<!-- <li><a href="#">Link</a></li> -->
    	</ul>
	</div>
	<!-- /.navbar-collapse -->
</nav>




















<nav class="navbar navbar-default navbar-inverse" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="./welcome">MovieBase</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="./welcome">Home</a></li>
        <!-- <li><a href="#">Link</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li class="divider"></li>
            <li><a href="#">One more separated link</a></li>
          </ul>
        </li> -->
      </ul>
      <form class="navbar-form navbar-left" action="./search?${_csrf.parameterName}=${_csrf.token}" method="POST">
				<div class="input-group">
				<div class="input-group-btn search-panel">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                    	<span id="search_concept">Movie Name</span> <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                      <li><a href="#moviename">Movie Name</a></li>
                      <li><a href="#actorname">Actor Name</a></li>
                      <li><a href="#genre">Genre</a></li>
                      <li><a href="#director">Director</a></li>
                    </ul>
                </div>
                <input type="hidden" name="search_param" value="moviename" id="search_param">         
                <input type="text" class="form-control" name="search_term" placeholder="Search by ...">
                <span class="input-group-btn">
                    <button class="btn btn-default " type="submit">Search</button>
                </span>
				</div>
			</form>
      <ul class="nav navbar-nav navbar-right">
        <li><p class="navbar-text">Hi <a href="#"> ${pageContext.request.userPrincipal.name}</a> | </p></li>
        <li>
          <a href="javascript:formSubmit()"><b>Logout</b> </a>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>