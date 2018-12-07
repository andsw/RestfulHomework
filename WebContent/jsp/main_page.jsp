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
		<p id="identity">当前用户：<strong id="permission"></strong></p>
	</div>

	<div id="siderbar">
		<ul id="siderbar_ul">
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/self.png"></li>
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
$(document).ready(function () {
	firstChangeInfo()
});

function firstChangeInfo(){
	$('#info_page').load("change_user_info.jsp");
	alert("sss");
	alert(getCookie("realName"));
	$("#username").attr("readonly", "readonly");
	$('#username').val(getCookie("username"));
	$('#realName').val(getCookie("realName"));
	if(getCookie("isMan") === true) {
		$('#man_radio').attr("checked","true");
	} else {
		$('#woman_radio').attr("checked","true");
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
	var errorMethod = function(XMLHttpRequest, textStatus, errorThrown){
		alert("登录失败！"); 
		alert(XMLHttpRequest.status);
        alert(XMLHttpRequest.readyState);
        alert(textStatus);
	}	
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