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
	//secondListUsers();
	//thirdClothesType();
	forthClothes()
});

function firstChangeInfo() {
	if(whichPage!=1){
		
		empty();
		
		//加载html码
		$('#one').slideDown(500);
		
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

function secondListUsers() {

	if(whichPage!=2) {
		
		empty();
		
		$('#two').fadeIn("slow");
		
		if(!pageSet.has(2)){
			$('#two').load("user_list_page.jsp");
			$('head').append('<script src="../js/infoPage/pageJs2.js"><\/script>');
			$('head').append('<link rel="stylesheet" type="text/css" href="../css/pageCss2.css"/>');
			request("POST", "http://localhost:8080/suit/useroperate/list",null,true,ListUsers,errorMethod);
			pageSet.add(2);
		}
		whichPage = 2;
	} else {
		alert("已经是第二个页面哦！")
	}
}

function thirdClothesType() {
	if(whichPage!=3) {
		
		empty();
		
		$('#three').fadeIn("slow");
		
		if(!pageSet.has(3)){
			$('#three').load("clothes_type_page.jsp");
			$('head').append('<script src="../js/infoPage/pageJs3.js"><\/script>');
			$('head').append('<link rel="stylesheet" type="text/css" href="../css/pageCss3.css"/>');
			
			request("GET", "http://localhost:8080/suit/clothestype/operate",null,true,function(result){
				$.each(result.data,function(idx, obj){
					addClothesTypeCard(obj);
				})
			},errorMethod);
			
			pageSet.add(3);
		}
		whichPage = 3;
	} else {
		alert("已经是第三个页面哦！")
	}
}

function popupForm() {
	if($("#add_button").text() === '添加') {
		$("#pop_mark_input").val("");
		$("#pop_name_input").val("");
		$("#pop_price_input").val("");
		//$("#popup_add_form").fadeIn("slow");
		$("#popup_add_form").slideDown(500);
		$("#add_button").text("取消");
		$("#forthBody").slideUp('Slow');
	} else {
		//$("#popup_add_form").fadeOut('slow');
		$("#popup_add_form").slideUp(500);
		$("#add_button").text("添加");
		$("#forthBody").slideDown('Slow');
	}
}

function addClothesFrompopupForm(self) {
	var clothes = {};
	$d = $(self.parentNode);
	clothes.mark = $d.children("#pop_mark_input").val();
	clothes.name = $d.children("#pop_name_input").val();
	clothes.price = $d.children("#pop_price_input").val();
	clothes.gender = $d.children("#pop_gender_select").find("option:selected").val();
	clothes.type = $d.children("#pop_type_select").find("option:selected").val();
	
	if(clothes.mark === "" || clothes.name === "" || clothes.price === "") {
		alert("请完善信息!");
	} else if(!/^\d+$/.test(clothes.price)){
		alert("价格栏必须为整数！")
	} else{
		request("POST", "http://localhost:8080/suit/clothesoperate/operate",clothes,true,function(result){
			alert(result.description);
			if(result.code === 0){
				addClothesCard(result.data);
				$d.children("#pop_mark_input").val("");
				$d.children("#pop_name_input").val("");
				$d.children("#pop_price_input").val("");
				$d.children("#pop_gender_select").children("option").eq(0).attr("selected");
				$d.children("#pop_type_select").children("option").eq(0).attr("selected");
			}
		},errorMethod);
	}
}

function addClothesCard(obj) {
	//这里添加遍历返回的所有衣服类型，先睡明天写！
	
}

function addOptionIntoSelect(){
	$("[name=clothes_gender]").html("<option value=\"\" disabled selected>选择性别</option>" +
			"<option value=\"true\">男</option>"+
			"<option value=\"false\">女</option>");
	request("GET", "http://localhost:8080/suit/clothestype/operate",null,true,function(result){
		$("[name=clothes_type]").html("<option value=\"\" disabled selected>选择类别</option>");
		$.each(result.data,function(idx, obj){
			$("[name=clothes_type]").append("<option value=\"" + obj.mark + "\">" + obj.name + "</option>");
		})
	},errorMethod);
}

function forthClothes() {
	addOptionIntoSelect();
	if(whichPage!=4) {
		
		empty();
		
		$('#four').fadeIn("slow");
		
		if(!pageSet.has(4)){
			//$('#three').load("clothes_type_page.jsp");
			//$('head').append('<script src="../js/infoPage/pageJs3.js"><\/script>');
			$('head').append('<link rel="stylesheet" type="text/css" href="../css/pageCss4.css"/>');
			$("#popup_add_form").hide();
			
			request("GET", "http://localhost:8080/suit/clothesoperate/operate",null,true,function(result){
				$.each(result.data,function(idx, obj){
					addClothesCard(obj);
				})
			},errorMethod);
			
			pageSet.add(4);
		}
		whichPage = 4;
	} else {
		alert("已经是第四个页面哦！")
	}
}

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