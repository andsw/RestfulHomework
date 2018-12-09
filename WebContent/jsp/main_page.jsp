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
	<script src="https://www.imooc.com/static/lib/jquery/1.9.1/jquery.js"></script>
	<script src="../js/homepage.js"></script>
	<style type="text/css">
		
	</style>
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
		<li class="siderbar_selector_li" onclick="secondListUsers()"><img style="width:64px;height=64px;" src="../img/ui/user_list.png"></li>
		<li class="siderbar_selector_li" onclick="thirdClothesType()"><img style="width:64px;height=64px;" src="../img/ui/catalog.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/all_clothes.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/mine.png"></li>
		<li class="siderbar_selector_li" onclick="sixthExit()"><img style="width:64px;height=64px;" src="../img/ui/logout.png"></li>
		</ul>
	</div>
	
	<div class="info_page" id="one"></div>
	<div class="info_page" id="two"></div>
	<div class="info_page" id="three">
		<div id="third">
 			<div class="card" id="add_card">
				<label class="green_title" for="id_input">
					<h1 class="title_style">服饰类别</h1>
				</label>
				<table>
					<tr>
						<td><label for="mark_input">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label></td>
						<td><input type="text" name="mark" id="mark_input"/></td>
					</tr>
					<tr>
						<td><label for="name_input">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</label></td>
						<td><input type="text" name="mark" id="name_input"/></td>
					</tr>
					<tr>
						<td colspan="2"><button id="sole_button">添加</button></td>	
					</tr>
				</table>
			</div>
			
		</div>
	</div>
	<div class="info_page" id="four"></div>
	<div class="info_page" id="five"></div>
</div>
</body>
</html>