<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="hostlermanager.service.EmployeeService" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css">

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>QR Code Scanner</title>
</head>
<body class="bg-light" style="overflow-x: hidden;">

  <nav class="navbar navbar-expand-lg navbar-light  p-2" style="background-color: #e9ecef;">
    <div class="container-fluid">
  <img src="https://source.unsplash.com/random/35x35" alt="A random image from Unsplash">
       <a class="navbar-brand" href="" style="font-weight: bold; font-size: xx-large;;">QR Hostel Pass</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="empshowall">All Activity</a>
          </li>
        </ul>
        <div class="d-flex">
				<form action="emplogin" method="post">
					<input class=" btn btn-secondary" type="submit" value="LOG OUT">
				</form>	
        </div>
      </div>
    </div>
  </nav>
 
  <div class="row">
  <div class="col mt-4">
    <div class="text-center m-4 ">
  <h5 id="success" class="text-success" style="display: none;">Permission granted</h5>
  <h5 id="fail" class=" text-danger" style="display: none;">Something went wrong</h5>
  <h5 id="tryAgain" class=" text-warning" style="display: none;">Scan QR again</h5>
  </div>
  <div class="d-flex justify-content-center">
<video  id="video" width="600" height="400" autoplay></video>
	<canvas id="canvas" width="600" height="400" style="display: none;"></canvas>		
</div>
	<div class="text-center mt-3"><button id = "btnScanQr" 
	class="btn btn-success" onclick="scanQR()">click to scan QR</button></div>
</div>


<div class="col mt-4">
<h3>Your Detail</h3><hr>
<div class="p-4">
<h5><%=session.getAttribute("empName") %></h5>
<h5><%=session.getAttribute("empEmail") %></h5>
</div>

</div>
</div>


<div style="height: 100px; width: auto;"></div>


   <footer class="footer fixed-bottom text-center p-4" style="background-color: #e9ecef;">
  <div class="container">
    <span class="text-muted">Copyright &copy; 2023 My Website</span>
  </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.min.js"></script>
<script>
	var tickId;
    var video = document.getElementById('video');
    var btnScanQr = document.getElementById("btnScanQr");
    var fail = document.getElementById("fail");
    var success = document.getElementById("success");
    var tryAgain = document.getElementById("tryAgain");
    navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } })
           .then(function(stream) {
          video.srcObject = stream;
          video.play();
     }).catch(function(error) {
          console.error('Could not access the camera: ', error);
        }); 
     
     function scanQR(){
    	video.pause();
        var canvas = document.getElementById('canvas');
        var context = canvas.getContext('2d');
        function tick() {
            if (video.readyState === video.HAVE_ENOUGH_DATA) {
              canvas.width = video.videoWidth;
              canvas.height = video.videoHeight;
              context.drawImage(video, 0, 0, canvas.width, canvas.height);
              var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
              var code = jsQR(imageData.data, imageData.width, imageData.height, { inversionAttempts: "dontInvert" });
              if (code) {
            	  var s = code.data;
            	  console.log(s)
            	  
            $.ajax({
				url: "permissionGarant",
				type: "POST",
				data: { myVar: s },
				success: function(response) {
	             	if(response == "true"){
	             		video.play();
	             		fail.style.display = "none";
	             		success.style.display = "block";
	             		tryAgain.style.display = "none";
						btnScanQr.innerHTML = "click to scan QR";
	             	}
				},
		        error: function(xhr, status, error) {
		            // Handle the error from the server
	             	video.play();
	             	success.style.display = "none";
	             	fail.style.display = "block";
	             	tryAgain.style.display = "none";
	              	btnScanQr.innerHTML = "click to scan QR";
		          }
			});
              }else{

             	video.play();
             	tryAgain.style.display = "block";
             	success.style.display = "none";
             	fail.style.display = "none";
             	btnScanQr.innerHTML = "Try again";
              }
            }
          }
        
        video.addEventListener('pause', function() {
        	if(tickId == null) tickId = requestAnimationFrame(tick);
          });
        
        video.addEventListener('play', function() {
        	if(tickId != null) tickId = null;
          });
    
    }

    </script>
    


  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>
    

</body>
</html>
