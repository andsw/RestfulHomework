function judgeEmpty(id1, id2) {
	var text1 = document.getElementById(id1).value;
	var text2 = document.getElementById(id2).value;
	if(text1 == "" || text2 == "") {
		alert("用户名或密码不能为空哦！");
	}
}

//以下为验证码js
//生成随机数
function randomNum(min, max) {
	return Math.floor(Math.random() * (max - min) + min); //Math.floor(x)返回一个小于等于x的最大整数
}
//生成随机颜色RGB分量
function randomColor(min, max) {
	var _r = randomNum(min, max);
	var _g = randomNum(min, max);
	var _b = randomNum(min, max);
	return "rgb(" + _r + "," + _g + "," + _b + ")";
}

function drawPic() {
	//获取到元素canvas
	var c = document.getElementById("canvas");
	var str = "0123456789"; //设置随机数库
	var picTxt = ""; //随机数
	var n = 4; //4个随机数字
	var w = c.width;
	var h = c.height;
	var ctx = c.getContext("2d"); //获取 context 对象
	ctx.textBaseline = "bottom"; //文字上下对齐方式--底部对齐
	ctx.fillStyle = randomColor(180, 240); //填充画布颜色
	ctx.fillRect(0, 0, w, h); //填充矩形--画画
	for(var i = 0; i < n; i++) {
		var x = (w - 40) / n * i + 40;
		var y = randomNum(h / 2, h);
		var deg = randomNum(-45, 45);
		var txt = str[randomNum(0, str.length)];
		picTxt += txt; //获取一个随机数
		ctx.fillStyle = randomColor(10, 100); //填充随机颜色
		ctx.font = randomNum(50, 80) + "px SimHei"; //设置随机数大小，字体为SimHei
		ctx.translate(x, y); //将当前xy坐标作为原始坐标
		ctx.rotate(deg * Math.PI / 180); //旋转随机角度
		ctx.fillText(txt, 0, 0); //绘制填色的文本
		ctx.rotate(-deg * Math.PI / 180);
		ctx.translate(-x, -y);
	}
	for(var i = 0; i < n; i++) {
		//定义笔触颜色
		ctx.strokeStyle = randomColor(90, 180);
		ctx.beginPath();
		//随机划线--4条路径
		ctx.moveTo(randomNum(0, w), randomNum(0, h));
		ctx.lineTo(randomNum(0, w), randomNum(0, h));
		ctx.stroke();
	}
	for(var i = 0; i < n * 10; i++) {
		ctx.fillStyle = randomColor(0, 255);
		ctx.beginPath();
		//随机画原，填充颜色
//		ctx.arc(255,255,255)
//		ctx.arc(randomNum(0, w), randomNum(0, h), 1, 0, 2 * Math.PI);
//		ctx.fill();
	}
	return picTxt; //返回随机数字符串
}