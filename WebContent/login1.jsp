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
					<input type="text" placeholder="验证码" id="identifyingCode"></input><br/>
					<img src="<%=basePath%>/checkcode" width="120px" height="50px" 
					id="checkcode"/><a href="javascript: refresh()">看不清楚，换一张！</a>
					<button type="submit" style="background-color: #575757;margin-top: 6%;" onclick="judgeEmpty('username','password')">我要登录</button><br/>
					<button type="button" style="background-color: #C4C4C4;margin-top: 2%;">我要注册</button>
				</div>
				<div id="logoword">
					<img src="img/ui/logoWord.png" />
				</div>
			</div>
		</div>

	</body>

</html>