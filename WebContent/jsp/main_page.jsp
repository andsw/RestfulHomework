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
	<title>主页</title>
	<meta charset="utf-8" />
	<link rel="stylesheet" type="text/css" href="../css/main.css"/>
	<link rel="stylesheet" type="text/css" href="../css/homepage.css"/>
			<link rel="stylesheet" type="text/css" href="../css/change_user_info.css"/>
	<script src="https://www.imooc.com/static/lib/jquery/1.9.1/jquery.js"></script>
</head>
<body>
<div id="content" style="height: 966px">
	<div id="top_tab">
		<img src="../img/ui/themeBanner.png" id="dream_words"/>
		<p class="identity">身份：<strong class="identity" id="permission"></strong></p>
	</div>

	<div id="siderbar">
		<ul id="siderbar_ul">
		<li class="siderbar_selector_li" onclick="firstChangeInfo()"><img style="width:64px;height=64px;" src="../img/ui/self.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/user_list.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/catalog.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/all_clothes.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/mine.png"></li>
		<li class="siderbar_selector_li" onclick="sixthExit()"><img style="width:64px;height=64px;" src="../img/ui/logout.png"></li>
		</ul>
	</div>
	
	<div id="info_page">
		
	</div>
</div>
</body>

<script>
var whichPage = 0;
var errorMethod = function(XMLHttpRequest, textStatus, errorThrown){
	alert("登录失败！"); 
	alert(XMLHttpRequest.status);
    alert(XMLHttpRequest.readyState);
    alert(textStatus);
}


$(document).ready(function () {
	firstChangeInfo()
});

function saveUser(){
	var password_confirming = $('#password_confirming').val();
	var user = {};
	user.password=$('#password').val();
	user.realName=$('#realName').val();
	if(user.password != password_confirming) {
		alert("密码两次输入不匹配！")
	} else if(user.realName.length == 0) {
		alert("用户实名为空，不可修改！")
	} else {
		user.id=getCookie("id");
		user.username=$('#username').val();
		user.gender=$('[name=isMan]').val();
		alert(user.gender);
		user.model=$('[name=model]').val();
		alert(user.model);
		user.permission=getCookie("isAdmin");
		var successMethod = function(result){
			alert(result.description)
		}
		alert(user);
		request("PUT", "<%=basePath%>/useroperate/operate", user, true, successMethod, errorMethod)
	}
}

function firstChangeInfo(){
	if(whichPage!=1){
		whichPage = 1;
		$('#info_page').load("change_user_info.jsp");
		alert(getCookie("realName"));
		$("#username").attr("readonly", "readonly");
		$('#username').val(getCookie("username"));
		$('#realName').val(getCookie("realName"));
		if(getCookie("isMan") === true) {
			$('#man_radio').attr("checked","true");
		} else {
			$('#woman_radio').attr("checked","true");
		}
		if(getCookie("whichModel") === true) {
			$('#second_head_radio').attr("checked","true");
		} else {
			$('#first_head_radio').attr("checked","true");
		}
		
		//显示身份：
		alert(getCookie("isAdmin"));
		if(getCookie("isAdmin") === true){
			alert("管理员")
			$("#permission").text("管理员");
		} else {
			alert("普通用户")
			$("#permission").text("普通用户");
		}
		$("#permission").attr("color", "#25B80C")
	} else {
		alert("已经是第一个页面哦！")
	}
}

function secondLlistUsers(){
	
}

function thirdClothesType(){
	
}

function forth(){}

function fifth(){}

function sixthExit() {
	alert("退出")
	var successMethod = function(result){
		alert(result.description);
		window.location.href="../login.jsp";
	}
	request("POST","<%=basePath%>/user/logout", "", true, successMethod, errorMethod);
}

function getCookie(c_name) {
	if(document.cookie.length > 0) {
		c_start = document.cookie.indexOf(c_name + "=");//获取字符串的起点
		if(c_start != -1) {
			c_start = c_start + c_name.length + 1;//获取值的起点
			c_end = document.cookie.indexOf(";", c_start);//获取结尾处
			if(c_end == -1) c_end = document.cookie.length;//如果是最后一个，结尾就是cookie字符串的结尾
			return decodeURI(document.cookie.substring(c_start, c_end));//截取字符串返回
		}
	}
	return "";
}

function request(method,url,data,async,successMethod,errorMethod){
    $.ajax({
        url: url,
        async: async,
        contentType: "application/json",
        data: JSON.stringify(data), 
        method: method,
        timeout: 20000,
        //记住不管是登录成功还是失败，都会走这个函数
        success: successMethod,
        //当url错误等找不到地址错误才走这个函数
    	error: errorMethod
    });
}
</script>

</html>