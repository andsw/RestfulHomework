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
	//forthClothes()
	fifthTryOnClothes();
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

function forthClothes() {
	if(!pageSet.has(4))
	//因为每次都要动态地更新select中的选项，所以要先加载js文件
		$('head').append('<script src="../js/infoPage/pageJs4.js"><\/script>');
	addOptionIntoSelect();
	if(whichPage!=4) {
		
		empty();
		
		//界面渐渐浮现！
		$('#four').fadeIn("slow");
		
		if(!pageSet.has(4)){
			//$('#three').load("clothes_type_page.jsp");
			
			$('head').append('<link rel="stylesheet" type="text/css" href="../css/pageCss4.css"/>');
			//弹出式的表单先是隐藏的
			$("#popup_add_form").hide();
			//第一个卡片用作克隆对象，没有数据显示所以隐藏！
			$("#first_card").hide(); 
			
			/*
			 * scrollTop    为滚动条在Y轴上的滚动距离。
			 * clientHeight 为内容可视区域的高度。
			 * scrollHeight 为内容可视区域的高度加上溢出（滚动）的距离。
			 * */
			
			//给显示服饰数据区域绑定滑动事件！
			$("#forth").bind('scroll', function(){    //绑定滚动事件
		        /*if($("#forth").scrollTop() >= 10){ //如果远离顶端
		        	if($("#forthHead").css("background"))
		        	//$("#forthHead").css("","")
		        }*/
				if($("#forth").scrollTop() >= 40) {
					$("#forthHead").slideUp('slow');
				}
				
				if($("#forth").scrollTop() < 40) {
					$("#forthHead").slideDown('slow');
				}
		    });     
			
			//获取所有衣服数据！
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

function filterClothesType(self) { 
	
}

function addAllClothes(obj) { 
	$newCard = $("#first_clothes_card").clone();
	$newCard.find(".dressed_on_info_table").children().children().eq(0).children().eq(1).text(obj.mark);
	$newCard.find(".dressed_on_info_table").children().children().eq(1).children().eq(1).text(obj.name);
	$newCard.find(".dressed_on_info_table").children().children().eq(2).children().eq(1).text(obj.price);
	$newCard.find(".clothes_img_ds").attr("src",obj.imgUrl);
	$newCard.show();
	
	$("#search_clothes_body").append($newCard);
}

var clothesSet = new Set();

function fifthTryOnClothes() {
	if(whichPage!=5) {
		
		empty();
		
		$('#five').fadeIn("slow");
		
		if(!pageSet.has(5)){
			//$('#three').load("clothes_type_page.jsp");
			//$('head').append('<script src="../js/infoPage/pageJs3.js"><\/script>');
			$('head').append('<link rel="stylesheet" type="text/css" href="../css/pageCss5.css"/>');
			
			$("#search_clothes_body").children().eq(0).hide();
			request("GET", "http://localhost:8080/suit/clothesoperate/operate",null,true,function(result){
				$("#all_clothes_type_select").append("<option>所有</option>");
				$.each(result.data,function(idx, obj){
					addAllClothes(obj);
					if(!clothesSet.has(obj.type)){
						$("#all_clothes_type_select").append("<option>" + obj.name +"</option>");
						clothesSet.add(obj.type);
					} 
				});
			},errorMethod);
			//给衣服类别选择框设置监听选中事件
			$("#all_clothes_type_select").change(filterClothesType(this));
			
			pageSet.add(5);
		}
		whichPage = 5;
	} else {
		alert("已经是第五个页面哦！")
	}
}

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