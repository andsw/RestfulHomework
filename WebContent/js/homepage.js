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
	
	firstChangeInfo()
	//secondListUsers();
	//thirdClothesType();
	//forthClothes()
	//fifthTryOnClothes();
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
	if(getCookie("isAdmin") === 'false'){
		alert("没有权限");
		return;
	}
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
	if(getCookie("isAdmin") === 'false'){
		alert("没有权限");
		return;
	}
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
	if(getCookie("isAdmin") === 'false'){
		alert("没有权限");
		return;
	}
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
				/*$.each(result.data,function(idx, obj){
					alert(idx);
					addClothesCard(obj);
				})*/
				var data= result.data;
				$.each(data,function(idx, obj){
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
	$selector = $(self);
	var type = $selector.find("option:selected").val();
	var $allSon = $("#search_clothes_body").find(".clothes_card");
	for(var i = 1; i<$allSon.length;i++){
		if(type === $allSon.eq(i).find("[name=type]").val() || 'all' === type) {
			$allSon.eq(i).show();
		} else {
			$allSon.eq(i).hide();
		}
	}
}

//定义一个set类型的全局变量来记录已经穿了的衣服，并保证一件衣服不重复穿！
var dressedSet = new Set();

function putOnClothes(self,z) {
	$cardj = $(self.parentNode);
	var mark = $cardj.find(".dressed_on_info_table").children().children().eq(0).children().eq(1).text();
	
	//判断是否已经穿了！
	if(dressedSet.has(mark)){
		alert("已经穿了哦！")
		return;
	}
	dressedSet.add(mark);
	
	var url = $cardj.find("img.clothes_img_ds").attr("src");
	var name = $cardj.find(".dressed_on_info_table").children().children().eq(1).children().eq(1).text();
	var price = $cardj.find(".dressed_on_info_table").children().children().eq(2).children().eq(1).text();

	//在模特身上先穿上
	$("#model").append("<img src=\""+ url +"\" name=\"" + mark + "\" class=\"clothes_on_model\"" +
			" style=\"z-index:" + z + ";\">");
	
	//然后写入已穿列表中
	$firstDressed = $("#first_dressed_on").clone();
	$firstDressed.attr("id", "");
	$firstDressed.find(".dressed_on_info_table").children().children().eq(0).children().eq(1).text(mark);
	$firstDressed.find(".dressed_on_info_table").children().children().eq(1).children().eq(1).text(name);
	$firstDressed.find(".dressed_on_info_table").children().children().eq(2).children().eq(1).text(price);
	
	//模仿点击事件改编zindex的值！
	for(var i=0; i<z; i++){
		$firstDressed.find(".zindex_up").click();
	}
	
	$firstDressed.show();
	$("#wearing").append($firstDressed)
	
	//改变价格
	var origin_price = $("#sum_price").children().eq(1).text();
	var sum = parseInt(origin_price) + parseInt(price);
	$("#sum_price").children().eq(1).text(sum)
}

function takeOffClothes(self) {
	$cardj = $(self).parents(".clothes_dressed_on");
	var mark = $cardj.find(".dressed_on_info_table").children().children().eq(0).children().eq(1).text();
	var price = $cardj.find(".dressed_on_info_table").children().children().eq(2).children().eq(1).text();
	//去除已穿卡片
	$cardj.fadeOut('slow');
	//从模特身上脱下衣服
	$("#model").find("[name=" + mark+ "]").remove();
	//从总价中减去该衣服的价格
	var origin_price = $("#sum_price").children().eq(1).text();
	var sum = parseInt(origin_price) - parseInt(price);
	$("#sum_price").children().eq(1).text(sum)
	//从set中去除
	dressedSet.delete(mark);
}

function zindexUp(self){
	$cardj = $(self).parents(".clothes_dressed_on");
	var mark = $cardj.find(".dressed_on_info_table").children().children().eq(0).children().eq(1).text();
	var index = parseInt($("#model").find("[name=" + mark+ "]").css("z-index"));
	$("#model").find("[name=" + mark+ "]").css("z-index", index + 1);
	$cardj.find(".zindex").text(index+1)
}

function zindexDown(self){
	$cardj = $(self).parents(".clothes_dressed_on");
	var mark = $cardj.find(".dressed_on_info_table").children().children().eq(0).children().eq(1).text();
	var index = parseInt($("#model").find("[name=" + mark+ "]").css("z-index"));
	if(index > 0) {
		$("#model").find("[name=" + mark+ "]").css("z-index",parseInt(index) - 1);
		$cardj.find(".zindex").text(index-1)
	}
}

function addAllClothes_try(obj) { 
	var isMan = getCookie("isMan");
	$newCard = $("#first_clothes_card").clone();
	
	if((isMan === 'true' && obj.gender === true) || (!(isMan === 'true') && !(obj.gender === true))){
		$newCard.find(".dressed_on_info_table").children().children().eq(0).children().eq(1).text(obj.mark);
		$newCard.find(".dressed_on_info_table").children().children().eq(1).children().eq(1).text(obj.name);
		$newCard.find(".dressed_on_info_table").children().children().eq(2).children().eq(1).text(obj.price);
		$newCard.find(".clothes_img_ds").attr("src",obj.imgUrl);
		$newCard.find("[name=type]").val(obj.type);
		$newCard.show();
		$("#search_clothes_body").append($newCard);
	}
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
			if(getCookie("isMan") === 'true') {
				$("#all_model_img").attr("src", "../img/data/model/mheadAModel.png");
			} else if(getCookie("isMan") === 'false'){
				$("#all_model_img").attr("src", "../img/data/model/wheadAModel.png");
			}
			
			//第一张没有内容的卡片设置为隐藏
			$("#search_clothes_body").children().eq(0).hide();
			$("#first_dressed_on").hide();//同理
			request("GET", "http://localhost:8080/suit/clothesoperate/operate",null,false,function(result){
				$("#all_clothes_type_select").append("<option value=\"all\">所有</option>");
				$.each(result.data,function(idx, obj){
					addAllClothes_try(obj);
					if(!clothesSet.has(obj.type)){
						$("#all_clothes_type_select")
						.append("<option value=\"" + obj.type +"\">" + obj.name +"</option>");
						clothesSet.add(obj.type);
					} 
				});
			},errorMethod);
			//给衣服类别选择框设置监听选中事件
			$("select#all_clothes_type_select").change(function(){
				filterClothesType(this)
			});
			
			var dressed = {};
			dressed.username = getCookie("username");
			//读取之前传的衣服！
			request("POST", "http://localhost:8080/suit/dressedoperate/select",dressed,true,function(result){
				//扫描到相应的衣服卡片，然后模拟添加按钮点击页面！
				$allClothes = $("#search_clothes_body").children(".clothes_card");
				$.each(result.data,function(idx, obj){
					for(var i=1; i<$allClothes.length; i++){
						var m = $allClothes.eq(i).find(".dressed_on_info_table")
						.find("tr").eq(0).children().eq(1).text();
						
						if(m === obj.mark){
							putOnClothes($allClothes.eq(i).find("img.dress_up_button")[0]
									, obj.zindex);
						}
					}
				})
			},errorMethod);
			
			pageSet.add(5);
		}
		whichPage = 5;
	} else {
		alert("已经是第五个页面哦！")
	}
}

function sixthExit() {
	
	//在这里记录所穿的衣服！
	$all_dressed = $("#wearing").find(".clothes_dressed_on");
	for(var i = 1; i<$all_dressed.length; i++) {
		var dressed = {};
		dressed.username = getCookie("username");
		dressed.mark = $all_dressed.eq(i).find(".dressed_on_info_table").find("tr").eq(1).children().eq(1).text();
		dressed.zindex = $all_dressed.eq(i).find(".dressed_on_info_table").find(".zindex").text();
		//alert(dressed.username + " " + dressed.mark +" " + dressed.zindex);
		request("POST","http://localhost:8080/suit/dressedoperate/operate", dressed, true, function(result){
			
		}, errorMethod);
	}
	
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