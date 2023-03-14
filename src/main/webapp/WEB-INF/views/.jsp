<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.google.zxing.*" %>
<%@ page import="com.google.zxing.client.j2se.*" %>
<%@ page import="com.google.zxing.common.*" %>
<%@ page import="com.google.zxing.qrcode.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>QR Scanner</title>
  </head>
  <body>
  <video id="video" width="400" height="300"></video>
 
  <button onclick="scanQRCode()">Scan QR Code</button>
  


<script>
    function scanQRCode() {
        const codeReader = new ZXing.BrowserQRCodeReader();
        codeReader
          .decodeOnceFromVideoDevice(undefined, 'video')
          .then(result => {
            alert(result.text);
          })
          .catch(err => {
            console.error(err);
          });
    }
</script>

  </body>
</html>
