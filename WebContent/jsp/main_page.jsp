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
		<div class="change_user_info">
			<table>
				<tr>
					<th colspan=4>修改用户信息</th>
				</tr>
				<tr>
					<td class="words">用户名称：</td>
					<td colspan="3"><input type="text" class="texts" id="username" readonly="readonly"></input></td>
				</tr>
				<tr>
					<td class="words">用户实名：</td>
					<td colspan="3"><input type="text" placeholder="请输入用户名" class="texts" id="username"></input></td>
				</tr>
				<tr>
					<td class="words">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
					<td colspan="3"><input type="password" class="texts" placeholder="不需修改请留空" id="password"></input></td>
				</tr>
				<tr>
					<td class="words">密码确认：</td>
					<td colspan="3"><input type="password" class="texts" placeholder="不需修改请留空" id="password_confirming"></input></td>
				</tr>
				<tr>
					<td class="words">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
					<td><input type="radio" class="gender_radio" name="gender" value="true"/>男
						<input type="radio" class="gender_radio" name="gender" value="false"/>女
					</td>
					<!-- 这里放置模特头像 -->
					<td colspan="2" rowspan="2">
						<div  id="model_select">
							<label for="first_head_radio" class="model_label" id="first_label">
								<input type="radio" id="first_head_radio" class="model_select_radio" name="model"/>
							</label>
							<label for="second_head_radio" class="model_label" id="second_label">
								<input type="radio" id="second_head_radio" class="model_select_radio" name="model"/>
							</label>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan=2><button class="save_button">保存信息</button></td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>

<script>
$(document).ready(function () {
	alert("开启")
});

function firstChangeInfo(){
	
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
/*
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
        		window.location.href="./jsp/index.jsp";
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
*/
</script>

</html>