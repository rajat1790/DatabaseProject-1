<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page session="true"%>
<html>
<head>
<title>Calendar</title>
		<jsp:include page="./header.jsp" /> 
		<!-- CSS -->
		<!-- <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.1.0/css/bootstrap-combined.min.css" rel="stylesheet" />
		 --><link href="//arshaw.com/js/fullcalendar-1.5.3/fullcalendar/fullcalendar.css" rel="stylesheet" />
		<link href="http://arshaw.com/js/fullcalendar-1.5.3/fullcalendar/fullcalendar.print.css" rel="stylesheet" />
		
		<!-- SCRIPTS -->
		<script class="cssdesk" src="//ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
		<script class="cssdesk" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js" type="text/javascript"></script>
		<script class="cssdesk" src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.1.0/js/bootstrap.min.js" type="text/javascript"></script>
		<script class="cssdesk" src="//arshaw.com/js/fullcalendar-1.5.3/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
		<style>
	/* 	body {
    margin-top: 40px;
    text-align: center;
	font-size: 14px;
	font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
} */

#calendar {
	width: 100%;
	margin: 0 auto;
}
		</style>
		<script>
		$(function () {
		    var date = new Date();
		    var y = date.getFullYear();
			
			$('#calendar').fullCalendar({
				header: {
					left: 'prev,next today',
					center: 'title'
				},
				editable: true,
		        events: [
		        {
		            title  : 'event1',
		            start  : '2016-01-10'
		        },
		        {
		            title  : 'event2',
		            start  : '2010-01-05',
		            end    : '2010-01-07'
		        },
		        {
		            title  : 'event3',
		            start  : '2010-01-09T12:30:00',
		            allDay : false // will make the time show
		        }
		    ]
			});
		});
		</script>
		
		
</head>
<body>
	<jsp:include page="./navbar.jsp" />
	<div class="container">
			<h1>Date</h1>
			
			<div id='calendar'></div>
		</div>
</body>
</html>