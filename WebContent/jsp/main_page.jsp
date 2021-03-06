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
		<li class="siderbar_selector_li" onclick="fifthTryOnClothes()"><img style="width:64px;height=64px;" src="../img/ui/mine.png"></li>
		<li class="siderbar_selector_li" onclick="sixthExit()"><img style="width:64px;height=64px;" src="../img/ui/logout.png"></li>
		</ul>
	</div>
	
	<div class="info_page" id="one"></div>
	<div class="info_page" id="two"></div>
	<div class="info_page" id="three"></div>
	<div class="info_page" id="four" hidden="true">
		<div id="forth">
			<div id="forthHead">
				<label class="input_label" for="gender_select_class">性&nbsp;&nbsp;&nbsp;&nbsp;别:
					<select id="gender_select" class="select_class" name="clothes_gender">
					</select>
				 </label>
				 <label class="input_label" for="gender_select" style="margin-left:-20px;">服饰类别:
					<select id="type_select" class="select_class" name="clothes_type">
					</select>
				 </label>
				<button class="forth_button" onclick="searchCard()">查询</button>
				<button class="forth_button" onclick="showAll()">所有</button>
				<button class="forth_button" id="add_button" onclick="popupForm()">添加</button>
			</div>
			<div id="forthBody">
				<div class="list_add_form" id="first_card">
					<div class="list_add_form_head">
						<button class="save_change_button" onclick="saveCard(this)">保存</button>
						<h1>服饰细目</h1>
						<button class="delete_button" onclick="deleteCard(this)">删除</button>
					</div>
					<input type="hidden" name="list_clothes_id"/>
					<p>编号：</p>
					<input type="text" name="list_clothes_mark"/><br>
					<p>名称：</p>
					<input type="text" name="list_clothes_name"/><br>
					<p>价格：</p>
					<input type="text" name="list_clothes_price"/><br>
					
					<select name="clothes_gender" 
					class="select_class" style="margin-top: 0px;  margin-left:0px; width: 160px;">
					</select>
					<select name="clothes_type" 
					class="select_class" style="margin-top: 0px; width: 160px;">
					</select>
					<div id="uploaderContainer">
						<input type="file" name="files[]" class="img_file" multiple data-url="/uploadImg/upload"/>
						<img id="suitImage" class="clothes_img" src="" onclick="image_click(this)"/>
					</div>
				</div>
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
				class="select_class" style="margin-top: 10px;">
				</select><br>
				<select id="pop_type_select" name="clothes_type" 
				class="select_class" style="margin-top: 10px;">
				</select>
				<button onclick="addClothesFrompopupForm(this)">添加</button>
			</div>
		</div>
	</div>
	<div class="info_page" id="five">
		<div id="fifth">
			<div id="fifth_head">
				<h1>试&ensp;衣&ensp;间</h1>
			</div>
			<div id="fifth_body" >
				<div id="wearing">
					<div class="clothes_dressed_on" id="first_dressed_on">
						<h1>已穿</h1>
						<table class="dressed_on_info_table">
							<tr><td>编号：</td><td></td></tr>
							<tr><td>名称：</td><td></td></tr>
							<tr><td>单价：</td><td></td></tr>
							<tr><td colspan="2">
								<img src="../img/ui/zIndex24.png" style="display:inline-block; margin-bottom: -6px;">
								<p class="zindex" style="display:inline-block;">0</p>
								<img src="../img/ui/up.png" onclick="zindexUp(this)" class="dedup zindex_up">
								<img src="../img/ui/down.png" onclick="zindexDown(this)" class="dedup zindex_down">
								<img src="../img/ui/delete.png" onclick="takeOffClothes(this)" class="dedup remove_from_model">
							</td></tr>
						</table>
					</div>
				</div>
				
				<div id="model">
					<img src="../img/ui/ground.png" id="floor_img"/>
					<img src="../img/data/model/modelShadow.png" id="shadow_img"/>
					<img src="" id="all_model_img"/>
					<div id="sum_price">
						<p>总价</p>
						<p>0</p>
					</div>
				</div>
				
				<div id="all_clothes">
					<div id="search_clothes_head">
						选择分类：<select id="all_clothes_type_select"></select>
					</div>
					<div id="search_clothes_body">
						<div class="clothes_card" id="first_clothes_card">
							<img src="../img/ui/add.png" class="dress_up_button" onclick="putOnClothes(this,0)"/>
							<img src="../img/data/suits/mShirt01.png" class="clothes_img_ds">
							<table class="dressed_on_info_table" style="margin-left:10px;margin-top:5px;">
								<tr><td>编号：</td><td></td></tr>
								<tr><td>名称：</td><td></td></tr>
								<tr><td>单价：</td><td></td></tr>
							</table>
							<input type="hidden" name="type" value=""/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>