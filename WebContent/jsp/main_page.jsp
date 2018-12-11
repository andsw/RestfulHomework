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
		#forth {
			width: 90%;
			height: 80%;
			margin: 5% auto;
			border: 2px solid #000;
			border-radius: 10px;
			overflow-y: auto;
		}
		#forth #forthHead {
			width: 100%;
			height: 47px;
			border-bottom: 2px solid #FFF;
			z-index: 0;
		}
		#forth .input_label {
			width: 300px;
			height: auto;
			display: inline-block;
			margin: 9px -60px 0 17px;
			font-family: SimHei;
            font-size: 14pt;
            font-weight: 500;
            color: RGBA(102,102,102,0.7);
            padding-top: 3px;
		}
		#forth .gender_select_class {
			width: 108px;
            height: 29px;
            line-height: 30pt;
            padding-right: 15pt;
            text-indent: 4pt;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #94c1e7;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            border-radius: 4px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            font-family: SimHei;
            font-size: 14pt;
            font-weight: 500;
            color: RGBA(102,102,102,0.7);
            cursor: pointer;
            outline: none;
            margin-left: 10px;
            margin-top: -4px;
		}
		#forth .forth_button {
			width:90px;
			height: 30px;
			padding: 10px 30px 27px 30px;
			background: #9DC45F;
			border: none;
			color: #FFF;
			box-shadow: 1px 1px 1px #4C6E91;
			-webkit-box-shadow: 1px 1px 1px #4C6E91;
			-moz-box-shadow: 1px 1px 1px #4C6E91;
			text-shadow: 1px 1px 1px #5079A3;
			border-radius: 5px;
			margin-left:-20px;
			margin-top: 3px;
			margin-right: 24px;
		}
		
		#forth .forth_button:hover {
			background: #3EB1DD;
		}
		
		#forth #add_button {
			float: right;
		}
		
		/*pop*/
		 #forth #popup_add_form {
			width: 273px;
			height: 410px;
			position:absolute;
			left: 39%;
			top: 23%;
			z-index: 1004;
			background: #FFF;
			padding-left: 30px;
		}
		#forth #popup_add_form h1 {
			width: 100%+30px;
			height: 47px;
			color: #d6d1d1;
		    font-size: 20px;
		    text-align: center;
		    text-shadow: 2px 2px 1px #000;
		    line-height: 48px;
		    background: #9DC45F;
		    margin-left: -30px;
		}
		
		#forth #popup_add_form input {
			width: 160px;
			height: 30px;
			padding-left:5px;
			margin-top: 26px;
		}
		#forth #popup_add_form label {
			padding-left:6px;
			margin-top: 10px;
			color: #d6d1d1;
		    font-size: 20px;
		    text-align: center;
		    text-shadow: 2px 2px 1px #000;
		    line-height: 48px;
		}
		
		#forth #popup_add_form select {
			width: 231px;
			display: inline-block;
			margin-left: 7px;
			margin-top: 10px;
			border: 2px solid #94c1e7;
			/*background: #3EB1DD;*/
		}
		
		#forth #popup_add_form button {
			width: 231px;
			height: 50px;
			background-color: #9DC45F;
			border: none;
			color: white;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 22px;
			margin: 24px auto;
			border-radius: 2px;
			margin-left: 7px;
			cursor: pointer;
		}
		
		#forth #popup_add_form button:hover {
			background: #3EB1DD;
		}
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
		<li class="siderbar_selector_li" onclick="forthClothes()"><img style="width:64px;height=64px;" src="../img/ui/all_clothes.png"></li>
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/mine.png"></li>
		<li class="siderbar_selector_li" onclick="sixthExit()"><img style="width:64px;height=64px;" src="../img/ui/logout.png"></li>
		</ul>
	</div>
	
	<div class="info_page" id="one"></div>
	<div class="info_page" id="two"></div>
	<div class="info_page" id="three"></div>
	<div class="info_page" id="four">
		<div id="forth">
		
			<div id="forthHead">
				<label class="input_label" for="gender_select_class">性&nbsp;&nbsp;&nbsp;&nbsp;别:
					<select id="gender_select" class="gender_select_class">
						<option>男</option>
						<option>女</option>
					</select>
				 </label>
				 <label class="input_label" for="gender_select_class" style="margin-left:-20px;" placeholder="请选择：">服饰类别:
					<select id="gender_select" class="gender_select_class">
					</select>
				 </label>
				<button class="forth_button" onclick="">查询</button>
				<button class="forth_button" id="add_button" onclick="popupForm()">添加</button>
			</div>
			<div id="body">
				
			</div>
			
			<div id="popup_add_form">
				<h1>添加服装</h1>
				<label for="pop_mark_input">编号：</label>
				<input type="text" name="clothes_mark" id="pop_mark_input"/><br>
				<label for="pop_name_input">名称：</label>
				<input type="text" name="clothes_name" id="pop_name_input"/><br>
				<label for="pop_price_input">价格：</label>
				<input type="text" name="clothes_price" id="pop_price_input"/><br>
				<select id="pop_gender_select" name="clothes_gender" 
				class="gender_select_class" style="margin-top: 10px;">
					<option>男</option>
					<option>女</option>
				</select><br>
				<select id="pop_type_select" name="clothes_type" 
				class="gender_select_class" style="margin-top: 10px;">
				</select>
				<button onclick="addClothesFrompopupForm(this)">添加</button>
			</div>
		</div>
	</div>
	<div class="info_page" id="five"></div>
</div>
</body>
</html>