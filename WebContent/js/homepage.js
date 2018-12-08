// 算了算了，性别和头像就用一个全局变量来代表吧！
var whichPage = 0;
var errorMethod = function(XMLHttpRequest, textStatus, errorThrown){
	alert("更新失败！"); 
	alert(XMLHttpRequest.status);
    alert(XMLHttpRequest.readyState);
    alert(textStatus);
}

$(document).ready(function () {
	firstChangeInfo()
});

function firstChangeInfo(){
	if(whichPage!=1){
		//加载html码
		$('#info_page').load("change_user_info.jsp");
		
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
		//此时页面为第一个
		whichPage = 1;
	} else {
		alert("已经是第一个页面哦！")
	}
}

function secondListUsers(){
	alert(whichPage)
	if(whichPage!=2) {
		alert("second");
		empty();
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
	if(whichPage === 1) {
		$("#first").hide();
		alert("empty")
	}
	
}