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
		if(user.username.length == 0) {
			alert("用户名不能为空！")
		} else if (user.password.length == 0) {
			alert("密码不能为空！")
		} else if(code.length == 0) {
			alert("验证码不能为空！")
		} else {
			//这个东西等待回应的时间很短，还没返回结果就直接判断错误！！怎么解！！
			request("POST","<%=basePath%>/user/login?checkcode=" + code, user, false);	
		}
	}
	
	function toRegisterPage(){
		alert("toRegisterPage")
		window.location.href="./register.jsp";
	}
	
	/*function toMain(){
		//试着延时几秒等浏览器存储好cookie再跳转试试！
		window.location.href="./jsp/index.jsp";
		进入页面过滤器
		path =/suit/jsp/index.jsp
		isLogged = 空字符串
		未登录，跳转到登录界面
		离开页面过滤器
		登录成功后也是一样我的原因，获取信息或写入cookie太慢，cookie
		的状态还是未登录，导致过滤器拦截，好好到床上想想怎么办！！！
	}*/

    function request(method,url,data,async){
        myajax = $.ajax({
            url: url,
            async: async,
            contentType: "application/json",
            data: JSON.stringify(data), 
            method: method,
            timeout: 20000,
            //记住不管是登录成功还是失败，都会走这个函数
            success: function(result){
            		alert(result.description);
            		window.location.href="./jsp/main_page.jsp";
            	},
            //当url错误等找不到地址错误才走这个函数
        	error: function(XMLHttpRequest, textStatus, errorThrown){
        			alert("登录失败！"); 
        			alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
        	}
        });
    }
    
    function showMessage(){
    	alert("登录失败！");
    }
</script>
</html>