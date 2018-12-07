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
	
	<style type="text/css">
		.change_user_info {
			width: 60%;
			height: 50%;
			margin: 180px auto;
			border: 2px solid #000;
			border-radius: 10px;
		}
		.change_user_info table {
			width: 90%;
			height: auto;
			margin: 20px auto;
			border-collapse: collapse;
		}
		.change_user_info table th{
			font-size:1.1em;
		    padding-top:10px;
		    padding-bottom:10px;
		    background-color:#000;
		    color:#ffffff;
		    text-align:center;
		}
		.words{
			height: 50px;
			width: 30%;
			font-color: #AFB2B6;
			font-size: 25px;
			text-align: center;
		}
		.texts{
			box-sizing: border-box;
			text-align:center;
			font-size:1em;
			height:2em;
			border-radius:4px;
			border:1px solid #c8cccf; 
			color:#6a6f77;
			-web-kit-appearance:none;
			-moz-appearance: none;
			display:block;
			outline:0;
			padding:0 1em;
			text-decoration:none;
			width:100%;
		}
		.gender_radio{
			width: 1.2rem;
            height: 1.2rem;
            background-color: #ffffff;
            border: solid 1px #dddddd;
            -webkit-border-radius: 0.6rem;
            border-radius: 0.6rem;
            font-size: 0.8rem;
            margin: 0;
            padding: 0;
            position: relative;
            display: inline-block;
            vertical-align: top;
            cursor: default;
            -webkit-appearance: none;
            margin-left: 20px;
            cursor:pointer;
		}
		.gender_radio:checked{
            background-color: #04c9e8;
            border: solid 1px #00adc8;
            box-shadow: 0 1px 1px rgba(0,0,0,.1);
            text-align: center;
            background-clip: padding-box;
        }
         /**选择后 里面小对勾样式**/
        .gender_radio:checked:before{
            content: '';
            width: 0.5rem;
            height: 0.3rem;
            border: 1px solid #ffffff;
            border-top: none;
            border-right: none;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-left: -0.25rem;
            margin-top: -0.25rem;
            -webkit-transform: rotate(-45deg);
                    transform: rotate(-45deg);
        }
		.save_button{
			width:38%;
			background-color: #4CAF50; /* Green */
			border: none;
			color: white;
			padding: 15px 32px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
			margin: 0 auto;
			border-radius:4px;
			margin-left: 50px;
			cursor:pointer;
		}
		.save_button:after {
		   content: "";
		   display: block;
		   position: absolute;
		   width: 100%;
		   height: 100%;
		   top: 0;
		   left: 0;
		   pointer-events: none;
		   background-image: radial-gradient(circle, #666 10%, transparent 10.01%);
		   background-repeat: no-repeat;
		   background-position: 50%;
		   transform: scale(10, 10);
		   opacity: 0;
		   transition: transform .3s, opacity .5s;
		} 
		.save_button:active:after {
		    transform: scale(0, 0);
		    opacity: .3;
		    transition: 0s;
		}
	</style>
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
		<li class="siderbar_selector_li" onclick=""><img style="width:64px;height=64px;" src="../img/ui/logout.png"></li>
		</ul>
	</div>
	
	<div id="info_page">
		<div class="change_user_info">
			<table>
				<tr>
					<th colspan=2>修改用户信息</th>
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
					<td colspan="2" rowspan="2"></td>
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
	
</script>

</html>