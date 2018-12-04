function judgeEmpty(id1, id2) {
	var text1 = document.getElementById(id1).value;
	var text2 = document.getElementById(id2).value;
	if(text1 == "" || text2 == "") {
		alert("用户名或密码不能为空哦！");
	}
}