<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" href="css/login.css" />
		<script language="JavaScript" type="text/javascript" src="js/login.js"></script>
		<title>登录/注册</title>
	</head>

	<body>
		<div id="container">
			<div id="wrapper">
				<div class="loginBox">
					<img src="img/ui/logo.png" />
					<input type="number" placeholder="用户名" id="username"></input>
					<input type="password" placeholder="密码" id="password"></input><br/>
					<input type="number" placeholder="验证码" id="identifyingCode"></input><br/>
					<canvas id="canvas" ></canvas>
					<script type="text/javascript">
						//先阻止画布默认点击发生的行为再执行drawPic()方法
						document.getElementById("canvas").onclick = function(e) {
							e.preventDefault();
							drawPic();
						};
						drawPic();
					</script>
					<button type="submit" style="background-color: #575757;margin-top: 6%;" onclick="judgeEmpty('username','password')">我要登录</button><br/>
					<button type="button" style="background-color: #C4C4C4;margin-top: 2%;">我要注册</button>
				</div>
				<div id="logoword">
					<img src="img/ui/logoWord.png" />
				</div>
			</div>
		</div>

	</body>

</html>