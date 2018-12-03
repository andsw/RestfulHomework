<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>登录</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css" />
<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
</head>
<body>
	<h1>登录界面</h1>
	<input id="id" type = "hidden"/>
	账 号 ： <input type="text" id="username" placeholder="请输入你的用户名" name="username"><br>
	密 码 ： <input type="password" id="password" name="password"><br>
	验证码 ：<input type="text" id="checkCode"	name="checkCode">
		<img src="<%=basePath%>/checkcode" width="120px" height="50px"/>
	<button onclick="login()">登录</button>
</body>
<script>

<!-- 可以试试加密！！！使用cookie存储密钥，将机密后的密码上传至服务器-->

	$(document).ready(function () {
		
    });
	
	function login(){
		var user = {};
		user.username = $("#username").val();
		user.password = $("#password").val();
		var code = $("#checkCode").val();
		
		request("POST","<%=basePath%>/user/login?checkcode=" + code, user, drawList, serverError, true);
	}
	
	function drawList(responseData){
		showMessage(responseData);
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