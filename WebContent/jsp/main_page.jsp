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
	<link rel="stylesheet" type="text/css" href="../css/pageCss2.css"/>
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
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/catalog.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/all_clothes.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/mine.png"></li>
		<li class="siderbar_selector_li" onclick="sixthExit()"><img style="width:64px;height=64px;" src="../img/ui/logout.png"></li>
		</ul>
	</div>
	
	<div id="info_page">
		<div id="second">
			<div style="width: calc(100% - 17px);overflow-x: hidden;" id="table-head">
	            <table class="table" style="width: 100%;table-layout: fixed;">
	                <thead>
		                <tr>
		                    <th>id</th>
							<th>用户名</th>
							<th>用户实名</th>
							<th>性别</th>
							<th>模型选择</th>
							<th>是否为管理员</th>
							<th>操作</th>
		                </tr>
	                </thead>
	            </table>
        	</div>
        	
        	<div style="width: 100%;height: 579px;overflow-y: scroll;" id="table-body">
	           <table class="table" style="width: 100%;table-layout: fixed">
	               <tbody>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               		<tr>
	               			<td colspan="7">sssssss</td>
	               		</tr>
	               </tbody>
	           </table>
        	</div>
        </div>
	</div>
</div>
</body>
</html>