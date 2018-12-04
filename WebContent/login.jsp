<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" href="css/login.css" />
		<script language="JavaScript" type="text/javascript" src="js/login.js"></script>
		<title>登录</title>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css" />
		<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
		<script type="text/javascript">
          function refresh(){
        	  var time = new Date().getTime();
        	  document.getElementById("checkcode").src="<%=basePath%>/checkcode?d="+time;
          }
        </script>
	</head>

	<body>
		<div id="container">
			<div id="wrapper">
				<div class="loginBox">
					<img src="img/ui/logo.png" />
					<input type="text" placeholder="请输入用户名" id="username"></input>
					<input type="password" placeholder="" id="password"></input><br/>
					<input type="text" placeholder="验证码" id="inputCheckCode"></input><br/>
					<img src="<%=basePath%>/checkcode" width="120px" height="50px" 
					id="checkcode" onclick="refresh()"/>
					<button onclick="login()" style="background-color: #575757;margin-top: 6%;">我要登录</button><br/>
					<button onclick="toRegisterPage()" style="background-color: #C4C4C4;margin-top: 2%;">我要注册</button>
				</div>
				<div id="logoword">
					<img src="img/ui/logoWord.png" />
				</div>
			</div>
		</div>

	</body>
	<script>

<!-- 可以试试加密！！！使用cookie存储密钥，将机密后的密码上传至服务器-->

	$(document).ready(function () {
		
    });
	
	function login(){
		var user = {};
		user.username = $("#username").val();
		user.password = $("#password").val();
		var code = $("#inputCheckCode").val();
		
		request("POST","<%=basePath%>/user/login?checkcode=" + code, user, toMain(), serverError, true);
	}
	
	function toRegisterPage(){
		window.location.href="./register.jsp";
	}
	
	function toMain(){
		//window.location.href="./jsp/index.jsp";
	}

    function request(method,url,data,successCallBack,errorCallBack,async){
        $.ajax({
            url: url,
            async:async,
            contentType: "application/json",
            data: JSON.stringify(data),
            method: method
        }).success(successCallBack).error(errorCallBack);
    }
    
    function showMessage(responseData){
    	console.log("showMessage",responseData);
    	alert(responseData.description);
    }

    function serverError(XMLHttpRequest, textStatus){
        console.log("responseText:",XMLHttpRequest.responseText);
        console.log("status:",XMLHttpRequest.status);
        console.log("textStatus:",textStatus);
        console.log("readyState:",XMLHttpRequest.readyState);
        alert("服务器错误，请检查前后台控制台输出！");
    }
</script>
</html>