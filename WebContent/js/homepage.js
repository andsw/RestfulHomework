// 算了算了，性别和头像就用一个全局变量来代表吧！
var whichPage = 0;
const pageSet = new Set();
var errorMethod = function(XMLHttpRequest, textStatus, errorThrown){
	alert("更新失败！"); 
	alert(XMLHttpRequest.status);
    alert(XMLHttpRequest.readyState);
    alert(textStatus);
}

$(document).ready(function () {
	
	$("#one").hide();
	$("#two").hide();
	$("#three").hide();
	$("#four").hide();
	$("#five").hide();
	
	//firstChangeInfo()
	secondListUsers();
});

function firstChangeInfo(){
	if(whichPage!=1){
		
		empty();
		
		//加载html码
		$('#one').show();
		
		if(!pageSet.has(1)){
			$('#one').load("change_user_info.jsp");
			
			//动态加载css/js！
			$('head').append('<script src="../js/infoPage/pageJs1.js"><\/script>');
			$('head').append('<link rel="stylesheet" type="text/css" href="../css/pageCss1.css"/>');
			
			$('#username').val(getCookie("username"));
			//设置为只读！
			$("#username").attr("readonly", "readonly");
			$('#realName').val(getCookie("realName"));
			
			var isMan = getCookie("isMan");
			var isRightModel = getCookie("whichModel");
			/*alert("isMan :" + isMan);
			alert("is right model : " + isRightModel)*/
			
			if(isMan === "true") {
				$('#man_radio').attr("checked","checked");
				man=true;
			} else if(isMan === "false") {
				$('#woman_radio').attr("checked","checked");
				man=false;
			}
			changeModelImage();
			$('#man_radio').change(changeModelImage);
			$('#woman_radio').change(changeModelImage);
			
			if(isRightModel === "true") {
				$('#second_head_radio').attr("checked","checked");
				whichModel = true;
			} else if(isRightModel === "false") {
				$('#first_head_radio').attr("checked","checked");
				whichModel = false;
			}
			$('#first_head_radio').change(changeModelNumber);
			$('#second_head_radio').change(changeModelNumber);
			
			if(getCookie("isAdmin") === true){
				$("#permission").text("管理员");
			} else {
				$("#permission").text("普通用户");
			}
			//记录已加载
			pageSet.add(1)
		}
		//此时页面为第一个
		whichPage = 1;
	} else {
		alert("已经是第一个页面哦！")
	}
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
	// TODO
	
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
	$modelTd = $tableBodyj.children("td").eq(4);
	user.model = $modelTd.text();
	
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
	// TODO
	
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

function ListUsers(result){
	$.each(result.data,function(idx, obj){
		$("#table-body tbody").append("<tr><td>" + obj.id
				+ "</td><td>" + obj.username
				+ "</td><td>" + obj.realName
				+ "</td><td>" + (obj.gender === true ? '男' : '女')
				+ "</td><td>" + obj.model
				+ "</td><td>" + (obj.permission === true ? '管理员' : "普通用户")
				+ "</td><td>" + "<button class=\"operate_button\" onclick=\"changeUserFromTable(this)\">修改</button>" 
							  + "<button class=\"operate_button\" onclick=\"deleteUserFromTable(this) \">删除</button>"
				+ "</td></tr>")
	})
}

function secondListUsers(){
	if(whichPage!=2) {
		
		empty();
		
		$('#two').show();
		if(!pageSet.has(2)){
			$('head').append('<link rel="stylesheet" type="text/css" href="../css/pageCss2.css"/>');
			request("POST", "http://localhost:8080/suit/useroperate/list",null,true,ListUsers,errorMethod);
			pageSet.add(2);
		}
		whichPage = 2;
	} else {
		alert("已经是第二个页面哦！")
	}
}

function thirdClothesType(){
	
}

function forth(){}

function fifth(){}

function sixthExit() {
	alert("退出")
	var successMethod = function(result){
		alert(result.description);
		window.location.href="../login.jsp";
	}
	request("POST","http://localhost:8080/suit/user/logout", "", true, successMethod, errorMethod);
}

function getCookie(c_name) {
	if(document.cookie.length > 0) {
		c_start = document.cookie.indexOf(c_name + "=");//获取字符串的起点
		if(c_start != -1) {
			c_start = c_start + c_name.length + 1;//获取值的起点
			c_end = document.cookie.indexOf(";", c_start);//获取结尾处
			if(c_end == -1) c_end = document.cookie.length;//如果是最后一个，结尾就是cookie字符串的结尾
			return decodeURI(document.cookie.substring(c_start, c_end));//截取字符串返回
		}
	}
	return "";
}

function request(method,url,data,async,successMethod,errorMethod){
    $.ajax({
        url: url,
        async: async,
        contentType: "application/json",
        data: JSON.stringify(data), 
        method: method,
        timeout: 20000,
        //记住不管是登录成功还是失败，都会走这个函数
        success: successMethod,
        //当url错误等找不到地址错误才走这个函数
    	error: errorMethod
    });
}

function empty() {
	if(whichPage === 1){
		$('#one').hide();
	} else if(whichPage === 2){
		$('#two').hide();
	} else if(whichPage === 3){
		$('#three').hide();
	} else if(whichPage === 4){
		$('#four').hide();
	} else if(whichPage === 5){
		$('#five').hide();
	}
}