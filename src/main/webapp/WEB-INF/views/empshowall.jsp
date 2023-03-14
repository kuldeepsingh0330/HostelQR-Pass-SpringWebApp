<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="hostlermanager.model.HostlerDetail"%>
    <%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Activity</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body class="bg-light">

  <nav class="navbar navbar-expand-lg navbar-light  p-2" style="background-color: #e9ecef;">
    <div class="container-fluid">
    
  <img src="https://source.unsplash.com/random/35x35" alt="A random image from Unsplash">
      <a class="navbar-brand" href="#" style="font-weight: bold; font-size: xx-large;;">QR Hostel Pass</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="emphome">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="">About</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  
 <h1 class="text-center mt-5 mb-4" style="font-size: 50px;">Your Activities</h1>
<div class="ml-5 mr-5">
<%
List<HostlerDetail>result = (List<HostlerDetail>)session.getAttribute("listAllActivity");
int today = 0;
int size = result.size();
session.removeAttribute("listAllActivity");
String user = (String)session.getAttribute("euser");
%>

<div class="text-end" style="float:right;">
<span>Today Activity : <%=today %></span>
<span class="ml-3"> Total Activity : <%=size %></span>
</div>
  <table class="table table-hover text-center">
  <thead style="background-color: #afd7ff">
    <tr>
      <th scope="col">#</th>
      <th scope="col">Student Name</th>
      <th scope="col">Room Number</th>
      <th scope="col">Hostle Name</th>
      <th scope="col">Purpose</th>
      <th scope="col">Start Time</th>
      <th scope="col">Completion Time</th>
    </tr>
  </thead>
<tbody>

<%
int i =1;
for(HostlerDetail hostlermanager : result){

	String compTime = ""+hostlermanager.getCompletionTime();
	if(compTime == null) {compTime = "---------";}	
%>

    <tr>
      <th scope="row"><%=i++ %></th>
      <td><%=hostlermanager.getStudent().getName() %></td>
      <td><%=hostlermanager.getRoomNumber() %></td>
      <td><%=hostlermanager.getHostleName() %></td>
	  <td><%=hostlermanager.getPurpose() %></td>
      <td><%=hostlermanager.getGrantTime()%></td>
      <td><%=hostlermanager.getCompletionTime()%></td>
    </tr>

<% }%>


  </tbody>
</table>
</div>
<div class="mt-5"><hr></div>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

</body>
</html>