<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<title>sign in</title>
</head>
<body>	

<div class="d-flex justify-content-center align-items-center mt-3">
  <img src="https://source.unsplash.com/random/80x80" alt="A random image from Unsplash">
</div>
<div class="container p-5 mt-2">
  <div class="row justify-content-center ">
    <div class="col-md-5">
      <div class="card">
        <div class="card-body">
          <h3 class="card-title text-center">Hostler Sign in</h3>
          <%if(request.getAttribute("email_exist") != null){ %><small class="text-danger"><%=request.getAttribute("email_exist")  %></small><%} %>
          <form action="signin" method="post">
            <div class="mb-3 mt-3">
            	<label for="name">Name</label> 
            	<input type="text" name="name" class="form-control" id="name" placeholder="Enter Name" required="required"></div>
            <div class="mb-3">
              <label for="inputEmail" class="form-label">Email</label>
              <input type="email" class="form-control" name="email" id="inputEmail" placeholder="Enter email" required="required">
            </div>
            <div class="mb-5">
              <label for="inputPassword" class="form-label">Password</label>
              <input type="password" class="form-control" name="password" id="inputPassword" placeholder="Enter password" required="required">
            </div>
            <div class="text-center ">
              <button type="submit" class="btn btn-success">Sign in</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<footer class="bg-light mt-5">
  <div class="container">
    <div class="text-center py-3">
      <ul class=" d-flex justify-content-center" style="list-style: none">
        <li class="mr-3"><a>Terms</a></li>
        <li class="mr-3"><a>Privacy</a></li>
        <li class="mr-3"><a>Security</a></li>
        <li class="mr-3"><a>Contact Us</a></li>
      </ul>
    </div>
  </div>
</footer>



	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

</body>
</html>