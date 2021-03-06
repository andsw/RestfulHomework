function ListUsers(result){
	$.each(result.data,function(idx, obj){
		$("#table-body tbody").append("<tr><td>" + obj.id
				+ "</td><td>" + obj.username
				+ "</td><td>" + obj.realName
				+ "</td><td>" + (obj.gender === true ? '男' : '女')
				+ "</td><td><img src=\"" +  getImgUrlByGenderAndModel(obj.gender, obj.model)
				+ "\" style=\"width:54px; height: auto;\" alt=\"" + obj.model +"\"/></td><td>" + (obj.permission === true ? '管理员' : "普通用户")
				+ "</td><td>" + "<button class=\"operate_button\" onclick=\"changeUserFromTable(this)\">修改</button>" 
							  + "<button class=\"operate_button\" onclick=\"deleteUserFromTable(this) \">删除</button>"
				+ "</td></tr>")
	})
}

//上述添加的每一行的头像显示所需的api
function getImgUrlByGenderAndModel(gender,model){
	var result = "";
	if(gender === true) {//男
		result = model ? "../img/data/model/mheadB.png" : "../img/data/model/mheadA.png";
	} else {
		result = model ? "../img/data/model/wheadB.png" : "../img/data/model/wheadA.png"
	}//男
	return result;
}

function deleteUserFromTable(self){
	var row = self.parentNode;
	var tableBody = row.parentNode;
	$tableBodyj = $(tableBody);
	
	var user = {};
	//记住获取jquery对象的子节点是这样的！！！
	user.id = $tableBodyj.children("td").eq(0).text();
	user.username = $tableBodyj.children("td").eq(1).text();
	//删除数据库信息
	request("DELETE", "http://localhost:8080/suit/useroperate/operate",user,true,
			function(){},errorMethod);
	
	$tableBodyj.fadeOut(800);
}


//保存点击修改键前的用户信息
var tempUser = {};
function changeUserFromTable(self){
	
	var row = self.parentNode;
	var tableBody = row.parentNode;
	$tableBodyj = $(tableBody);
	//用户实名变成input
	$realNameTd = $tableBodyj.children("td").eq(2);
	tempUser.realName = $realNameTd.text();
	$realNameTd.html("<input type=\"text\" value=\"" + $realNameTd.text() + "\" style=\"width=50px;heigt=50px\"/>");
	
	// 性别变成下拉框
	$genderTd = $tableBodyj.children("td").eq(3);
	tempUser.gender = $genderTd.text();
	$genderTd.html("<select><option>" + $genderTd.text() +
			"</option><option>" + ($genderTd.text()==='男' ? '女' : '男') + "</option></select>");
	
	//模型选择
	//头像旁边出现更换按钮
	//emmmm 实在太复杂了，现在代码都写好了，变动有些麻烦。。。
	//就给图片设置点击事件吧！点击图片变换！！！
	$imgButton = $tableBodyj.children("td").eq(4).children();
	tempUser.model = $imgButton.attr("alt")
	$imgButton.bind("click", function(){
		var url = $imgButton.attr("src");
		var alt = $imgButton.attr("alt");
		
		if(url === '../img/data/model/mheadA.png') {
			url = '../img/data/model/mheadB.png';
		} else if(url === '../img/data/model/mheadB.png') {
			url = '../img/data/model/mheadA.png';
		} else if(url === '../img/data/model/wheadA.png') {
			url = '../img/data/model/wheadB.png';
		} else if(url === '../img/data/model/wheadB.png') {
			url = '../img/data/model/wheadA.png';
		}
		alt = !alt;
		$imgButton.attr("src", url);
		$imgButton.attr("alt", alt);
	})
	
	//是否为管理员变为下拉框
	$isAdminTd = $tableBodyj.children("td").eq(5);
	tempUser.permission=$isAdminTd.text();
	$isAdminTd.html("<select><option>" + $isAdminTd.text() +
			"</option><option>" + ($isAdminTd.text()==='管理员' ? '普通用户' : '管理员') + "</option></select>");
	
	//修改按钮变为保存
	$changeButton = $tableBodyj.children("td").eq(6).children().eq(0);
	$changeButton.attr("onclick", "saveChange(this)")
	$changeButton.text("保存");
	
	//删除按钮变为取消
	$deleteButton = $tableBodyj.children("td").eq(6).children().eq(1);
	$deleteButton.attr("onclick", "cancelChange(this, null)")
	$deleteButton.text("取消");
}

function saveChange(self) {
	var user = {};
	
	var row = self.parentNode;
	var tableBody = row.parentNode;
	$tableBodyj = $(tableBody);
	
	// 获取用户id
	$idTd = $tableBodyj.children("td").eq(0);
	user.id = $idTd.text();
	
	// 获取用户实名
	$usernameTd = $tableBodyj.children("td").eq(1);
	user.username = $usernameTd.text();
	
	// 获取用户实名
	$realNameTd = $tableBodyj.children("td").eq(2);
	user.realName = $realNameTd.children("input").eq(0).val();
	
	// 获取性别
	$genderTd = $tableBodyj.children("td").eq(3);
	user.gender = $genderTd.children("select").eq(0).find("option:selected").text();
	
	// 获取模型选择
	// TODO
	$modelTd = $tableBodyj.children("td").eq(4).children();
	user.model = $modelTd.children().attr("alt");
	
	//获取身份	
	$isAdminTd = $tableBodyj.children("td").eq(5);
	user.permission = $isAdminTd.children("select").eq(0).find("option:selected").text();
	
	//点击保存后传入修改后的数据再还原
	cancelChange(self, user)
	
	// 提交到后台的需要修改为正确格式！
	user.gender = user.gender === '男' ? true : false;
	user.permission = user.permission === '管理员' ? true : false;
	alert(user.id + " " + user.username + " " + user.realName + " " + user.gender + " " + user.model + " " + user.permission);
	//后台会检验密码是否为空字符串！
	user.password="";
	
	//提交后台请求
	request("PUT", "http://localhost:8080/suit/useroperate/operate",user,true,
			function(){alert("保存成功")},errorMethod);
}

function cancelChange(self, user) {
	
	//如果数据是修改后的就把修改后的数据写上去！
	if(user != null){
		tempUser = user;
	}
	
	var row = self.parentNode;
	var tableBody = row.parentNode;
	$tableBodyj = $(tableBody);//js对象转化为jq对象
	
	//用户实名还原
	$realNameTd = $tableBodyj.children("td").eq(2);
	$realNameTd.html(tempUser.realName);
	
	// 性别还原
	$genderTd = $tableBodyj.children("td").eq(3);
	$genderTd.html(tempUser.gender);
	
	//模型选择
	$ImageButton = $tableBodyj.children("td").eq(4).children();
	var url = getImgUrlByGenderAndModel(tempUser.gender === '男', tempUser.model);
	$ImageButton.attr("alt", tempUser.model); 
	$ImageButton.attr("src", url);
	$ImageButton.bind("click" , "");
	
	//用户身份还原
	$isAdminTd = $tableBodyj.children("td").eq(5);
	$isAdminTd.html(tempUser.permission);
	
	//修改按钮变为保存
	$changeButton = $tableBodyj.children("td").eq(6).children().eq(0);
	$changeButton.attr("onclick", "changeUserFromTable(this)")
	$changeButton.text("修改");
	
	//删除按钮变为取消
	$deleteButton = $tableBodyj.children("td").eq(6).children().eq(1);
	$deleteButton.attr("onclick", "deleteUserFromTable(this)")
	$deleteButton.text("删除");
}