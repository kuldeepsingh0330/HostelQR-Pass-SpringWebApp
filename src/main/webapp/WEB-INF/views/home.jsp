<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*,javax.imageio.*,com.google.zxing.*,com.google.zxing.client.j2se.*,com.google.zxing.common.*"%>	
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="hostlermanager.model.*"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css">

<head>
<script
	src="https://cdn.rawgit.com/davidshimjs/qrcodejs/gh-pages/qrcode.min.js"></script>
</head>
<title>Home</title>
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
            <a class="nav-link active" aria-current="page" href="">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="showall">All Activity</a>
          </li>
        </ul>
        <div class="d-flex">
				<form action="logOutUser" method="post">
					<input class=" btn btn-secondary" type="submit" value="LOG OUT">
				</form>
			
        </div>
      </div>
    </div>
  </nav>
  
 <%
 int hostlerID = 0;
	if(session.getAttribute("hostlerID") != null) hostlerID = (Integer) session.getAttribute("hostlerID");
	int id = (Integer) session.getAttribute("sid");
	String name = (String) session.getAttribute("name");
	String email = (String) session.getAttribute("email");
	Student student = (Student) session.getAttribute("student");
	boolean isInside = student.isInside();
	String startTime = "---------";
	String completionTime = "---------";
	String grantedByempName = "---------";
	String currentStatus = "Pending";
	String permission = "";
	if(student.getHostlerDetail() != null && student.getHostlerDetail().isPermissionGranted()) {	permission = "Granted";}
	else if(student.getHostlerDetail() != null){ permission = "Not yet";}
	
	if(student.getHostlerDetail() != null ) {
		if(student.getHostlerDetail().getGrantTime() != null){
		startTime = String.valueOf(student.getHostlerDetail().getGrantTime());
		grantedByempName = student.getHostlerDetail().getGrantedByempName();
		currentStatus = "Ongoing";
		}
		if(student.getHostlerDetail().getCompletionTime() != null){
			currentStatus =  "Completed";
			completionTime = String.valueOf(student.getHostlerDetail().getCompletionTime());
		}
	}
	
	
	
	// Get the text to encode as a QR code
	String qrText = hostlerID+"/"+id;

	// Set the size of the QR code image
	int size = 250;

	// Generate the QR code as a BitMatrix
	BitMatrix bitMatrix = new MultiFormatWriter().encode(qrText, BarcodeFormat.QR_CODE, size, size);

	// Convert the BitMatrix to a BufferedImage
	BufferedImage image = MatrixToImageWriter.toBufferedImage(bitMatrix);

	// Write the image to the output stream
	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	ImageIO.write(image, "png", baos);
	byte[] imageData = baos.toByteArray();

	// Encode the image data as a base64 string
	String base64 = new String(Base64.getEncoder().encode(imageData));

	// Embed the base64 image data in an HTML image tag
	String html = "<img style=\"width: 300px;height: 300px;\" class=\"img-fluid img-thumbnail\"src=\"data:image/png;base64," + base64 + "\" alt=\"QR Code\">";
	
%>
<div class="container mt-5 ">
  <div class="row">
    <div class="col mb-5 ">
    <h3>Personal Detail</h3><hr>
    <div class="p-4"><h5><%=name %></h5>
    <h5><%=email %></h5>
</div>
    <%if(student.getHostlerDetail() != null){ %>
    <h3 class="mt-3">Hostler Detail</h3><hr>
    <div class="p-4"><h5>Hostel Name : <%=student.getHostlerDetail().getHostleName() %></h5>
    <h5>Room Number : <%=student.getHostlerDetail().getRoomNumber() %></h5>
    </div>
    <%} %>
    
    </div>
    <div class="col" id="qrcode">
      		<%
		if (!isInside) {
		%>
		<div>
		
		<h2 class="text-center ">Generate QR Code</h2>
			<div class="col-md-68 offset-md-1">
				<form action="generateQRCon" method="post" class="mt-4">
					<div class="form-group mt-3">
						<label for="hostel-name">Select Hostel</label> 
						<div class="p-3">
						<div class="row">
						<span class="form-check col	">
						<input type="radio"class="form-check-input" id="hostel1" name="hostleName" value="Hostel 1" required>
						<label class="form-check-label" for="hostel1">Hostel 1</label>
						</span>
						<span class="form-check col">
						<input type="radio"class="form-check-input" id="hostel2" name="hostleName" value="Hostel 2" required>
						<label class="form-check-label" for="hostel2">Hostel 2</label>
						</span>
						</div>
						<div class="row">
						<span class="form-check col">
						<input type="radio"class="form-check-input" id="hostel3" name="hostleName" value="Hostel 3" required>
						<label class="form-check-label" for="hostel3">Hostel 3</label>
						</span>
						<span class="form-check col">
						<input type="radio"class="form-check-input" id="hostel4" name="hostleName" value="Hostel 4" required>
						<label class="form-check-label" for="hostel4">Hostel 4</label>
						</div>
						</span>
						</div>
					</div>
					<div class="form-group mt-3">
						<label for="room-number">Room Number</label> <input type="number"
							class="form-control" id="room-number"  value="Hostel 1" name="roomNumber" required>
					</div>
					<div class="form-group mt-3">
						<label for="purpose">Purpose</label> <input type="text"
							class="form-control" id="purpose" name="purpose" required>
					</div>
					<div class="form-group mt-3">
						<label for="location">Location</label> <input type="text"
							class="form-control" id="location" name="location" required>
					</div>
					<div class="text-center mt-5">
					<button type="submit" class="btn btn-success">Submit</button>
					</div>
				</form>
			</div>
		</div>

		<%
		} else {
		%>

		<div class="text-center mt-5"><%=html %></div>

		<%
		}
		%>
    </div>
  </div>
</div>


<%if(student.getHostlerDetail() != null){ %>
<div class="container mt-3">
    <h3>
    <span>Last Activity</span>
    <span class="float-end">Current Status : 
    <%if(currentStatus == "Pending"){%>
    <span class="text-danger"><%=currentStatus %></span>
    <%} else if(currentStatus == "Ongoing"){%>
    <span class="text-warning"><%=currentStatus %></span>
    <%}else if(currentStatus == "Completed"){%>
    <span class="text-success"><%=currentStatus %></span>
    <%} %>
    </span></h3><hr>
    <div class=" row p-3">
    <div class="col">
    <h5>Purpose : 
    <%=student.getHostlerDetail().getPurpose() %>
    </h5>
    <h5>Loction : 
    <%=student.getHostlerDetail().getLocation() %>
    </h5>
    
        <h5>    <%
    if(permission == "Not yet" && student.isInside()){%><h5><span>Permission : </span><span class="text-danger "><%=permission %></span></h5>
    <%}else if(permission == "Granted"){%><h5><span>Permission : </span><span class="text-success"><%=permission %></span></h5>
    <%} %>
    
    
    </h5>
    
    </div>
    <div class="col">
    <h5>Start Time : 
    <%=startTime %>
    </h5>
    
    
	<h5 >Completion Time : 
    <%=completionTime %>
    </h5>
    
    <h5>Permission Granted by : 
    <%=grantedByempName %>
    </h5>
</div>
</div>
</div>
<%} %>
<div style="width: auto; height: 100px"></div>

<footer class="footer fixed-bottom text-center p-4" style="background-color: #e9ecef;">
  <div class="container">
    <span class="text-muted">Copyright &copy; 2023 My Website</span>
  </div>
</footer>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD" crossorigin="anonymous"></script>

</body>
</html>
