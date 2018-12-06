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
<link rel="stylesheet" type="text/css" href="../css/main.css"/>
<link rel="stylesheet" type="text/css" href="../css/homepage.css"/>
<script src="https://www.imooc.com/static/lib/jquery/1.9.1/jquery.js"></script>
<title>主页</title>
</head>
<body>
<div id="content" style="height: 966px">
	<div id="top_tab">
		<img src="../img/ui/themeBanner.png" id="dream_words"/>
		<p id="identity">当前用户：<strong id="permission"></strong></p>
	</div>

	<div id="siderbar">
		<ul>
		<li class="siderbar_selector"><img alt="" src="../img/ui/self.png"></li>
		<li class="siderbar_selector"><img alt="" src="../img/ui/user_list.png"></li>
		<li class="siderbar_selector"><img alt="" src="../img/ui/catalog.png"></li>
		<li class="siderbar_selector"><img alt="" src="../img/ui/all_clothes.png"></li>
		<li class="siderbar_selector"><img alt="" src="../img/ui/mine.png"></li>
		<li class="siderbar_selector"><img alt="" src="../img/ui/logout.png"></li>
		</ul>
	</div>
	
	<div id="info_page">
		
	</div>
</div>
</body>
<script>

</script>
</html>