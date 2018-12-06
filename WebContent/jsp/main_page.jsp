<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="../css/main.css"/>
		<link rel="stylesheet" type="text/css" href="../css/homepage.css"/>
		<title>首页</title>
		<style>
			body {
				background-image: url(../img/ui/loginWindowBg1920.png);
				background-size: 1020px 765px;
				background-position: center top;
				background-repeat: no-repeat;
			}
		</style>
	</head>

	<body>
		<div id="con">
			<div id="banner">
				<div id="user">
					当前用户：
				</div>
				<img src="img/ui/themeBanner.png" />
			</div>

			<ul id="tabs">

				<li class="selectTab">
					<a href="javascript:void(0)" onclick="selectTab('tabContent0',this)"> <img src="../img/ui/self.png" /> </a>
				</li>

				<li>
					<a href="javascript:void(0)" onclick="selectTab('tabContent1',this)"><img src="../img/ui/userList.png" /></a>
				</li>
				<li>
					<a href="clothes_page.jsp" onclick="selectTab('tabContent2',this)"><img src="../img/ui/catalog.png" /></a>
				</li>
				<li>
					<a href="javascript:void(0)" onclick="selectTab('tabContent3',this)"><img src="../img/ui/suits.png" /></a>
				</li>
				<li>
					<a href="javascript:void(0)" onclick="selectTab('tabContent4',this)"><img src="../img/ui/mySuits.png" /></a>
				</li>
				<li>
					<a href="../login.jsp"><img src="../img/ui/exit.png" /></a>
				</li>

			</ul>

			<div id="tabContent">
				
				<div id="tabContent0" class="tabContent selectTab">

					<p>内容1</p>

				</div>
				
				<div id="tabContent1" class="tabContent">

					<p>内容2</p>
              </div>
              
              
				<div id="tabContent2" class="tabContent">

					<p>内容3</p>

				</div>
				<div id="tabContent3" class="tabContent">

					<p>内容4</p>

				</div>
				<div id="tabContent4" class="tabContent">

					<p>内容5</p>

				</div>

			</div>

		</div>
	</body>
	<script type="text/javascript">
		function selectTab(thisContent, thisObj) {

			thisObj.blur();

			var tab = document.getElementById("tabs").getElementsByTagName("li");

			var tablength = tab.length;

			for(i = 0; i < tablength; i++)

			{

				tab[i].className = "change";

			}

			thisObj.parentNode.className = "selectTab";

			for(i = 0; j = document.getElementById("tabContent" + i); i++)

			{

				j.style.display = "none";

			}

			document.getElementById(thisContent).style.display = "block";

		}
	</script>

</html>