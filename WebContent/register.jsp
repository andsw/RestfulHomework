<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>注册</title>
    <link rel="stylesheet" href="css/Registration_page.css">
<script type="text/javascript">
			window.onload = function() {
				resetPage();
			}

			window.onresize = function() {
				resetPage();
			}

			function resetPage() {
				var deviceWidth = document.documentElement.clientWidth,
					scale = deviceWidth / 1090;
				document.body.style.zoom = scale;
			}
		</script>
  <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">
    </script>
    <script>
    	function index(){
	$('.welcome').css('color','#03a9f4');  //默认值
	setTimeout(" $('.welcome').css('color','white')",1000); //第一次闪烁
	setTimeout( "$('.welcome').css('color','blue')",2000); //第二次闪烁
};
window.setInterval(index, 3000); //让index 多久循
        $(document).ready(function(){
        $("#hide").click(function(){
            if($("#man").is(":hidden")){
                $("#man").fadeIn(); 
                 $("#woman").hide(); 
            }else{
                $("#man").hide();    //如果元素为隐藏,则将它显现
            }
        });    
        $("#hide2").click(function() {
            if($("#woman").is(":hidden")){
              $("#woman").fadeIn(); 
                $("#man").hide(); 
            }else{
                $("#woman").hide(); 
            }
        });
        });
        
    </script>
</head>
<body>
<div class="container"> 
<div class="box"></div>

<div class="InputName">用户名：</div>
<div class="InputBox1"> 
	<input  type="text" id="username" value="">
</div>

<div class="InputTrueName">实  名：</div>
<div class="InputBox2"> 
	<input  type="text" id="realName" value="">
</div>
		
<div class="PassWord">密  码：</div>
<div class="InputBox3"> 
	<input  type="password" id="password" value=""/>
</div> 
	
<div class="Password_confirmation">密码确认：</div>
<div class="InputBox4"> 
	<input  type="password" id="password_confirming" value="">
</div> 
	
<div class="Sex">性  别：</div> 
<label class="Sex1">
	<input name="Sex2" type="radio" value=""  id="hide"/>男</label> 
	
<label class="Sex2">
		<input name="Sex2" type="radio" value=""  id="hide2"/>女</label> 
		
<p hidden="hidden" id="woman">
	<input name="woman1" class="woman1" type="button"  onclick="javascrtpt:window.location.href='#'"/>
	<input name="woman2" class="woman2" type="button" onclick="javascrtpt:window.location.href='#'"/>
</p> 
<p hidden="hidden" id="man">
	<input name="man1" class="man1" type="button" onclick="javascrtpt:window.location.href='#'"/>
	<input name="man2" class="man2" type="button" onclick="javascrtpt:window.location.href='#'"/>
</p> 

<div>
	<button type="button" class="ReturnLogin" onclick="toLoginPage()">返回登录</button>
</div>

<div>  
	<button type="button" class="Click_registration" onclick="register()">注册用户</button>
</div>

</div> 
</body>
<script>

<!-- 可以试试加密！！！使用cookie存储密钥，将机密后的密码上传至服务器-->

	$(document).ready(function () {
		
    });
	
	function register(){
		var user = {};
		user.username = $("#username").val();
		user.realName = $("#realName").val();
		user.password = $("#password").val();
		var password_confirming = $("#password_confirming").val();
		user.gender = $("input[name='Sex2']:checked").val();
		user.gender = "false";
		if(user.username.length == 0) {
			alert("用户名不能为空！")
		} else if(user.realName == 0) {
			alert("实名不能为空！")
		} else if (user.password.length == 0) {
			alert("密码不能为空！")
		} else if(user.realName.length == 0) {
			alert("验证码不能为空！")
		} else if(user.gender.lenth==0) {
			alert("性别未选中！")
		} else if(user.password != password_confirming){
			alert("两次输入密码不一致！")
		} else {
			request("POST","<%=basePath%>/user/register", user, false);	
		}
	}
	
	function toLoginPage(){
		alert("toLoginPage")
		window.location.href="./login.jsp";
	}


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
            		if(result.code == "0"){
            			window.location.href="./login.jsp";	
            		} else {
            			window.location.href="./register.jsp";	
            		}
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
</script>
</html> 
