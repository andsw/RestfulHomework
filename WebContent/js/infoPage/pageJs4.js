//弹出弹出菜单的按钮点击事件！
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

//从弹出菜单中添加衣服信息
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

//添加衣服细目卡片
function addClothesCard(obj) {
	//这里添加遍历返回的所有衣服类型，先睡明天写！
	$card = $("#first_card").clone();
	$card.find("[name=list_clothes_id]").val(obj.id);
	$card.find("[name=list_clothes_mark]").val(obj.mark);
	$card.find("[name=list_clothes_name]").val(obj.name);
	$card.find("[name=list_clothes_price]").val(obj.price);
	$card.find("[name=clothes_gender]").children("option").eq(obj.gender ? 1 : 2).attr("selected", true);
	$card.find("[name=clothes_type]").find("." + obj.type).attr("selected", true);
	//if(obj.imgUrl != "../img/data/suits/unknown.png")
		//alert(obj.imgUrl);
	/*alert($card.find(".clothes_img").attr("src"));*/
	//alert("change");
	$card.find(".clothes_img").attr("src", obj.imgUrl);
	
	$card.find(".img_file").bind("change", function() {
		var fileName = $(this).val();	
		//alert(fileName);
		$(this.parentNode).find(".clothes_img").attr("src", "../img/data/suits/"
				+ getFileName(fileName));
		
		uploadFileRequest(this.parentNode,'../img/data/suits/');
	})
	$card.css("display", "inline-block");
	$card.show();
	$("#forthBody").append($card);
}

//提交上传图片请求
function uploadFileRequest(suit,urlPrefix){
    suit.find("input").fileupload({
            dataType: 'json',
            done: function (e, data) {
                suit.find("imageUrl").val(data.result.description);
                suit.find("#uploaderContainer img")
                      .attr("src",urlPrefix+data.result.description);

                showMessage({"code":0,"description":data.result.description+"上传成功！"});
            }
    });
}

//从路径中获取文件名！
function getFileName(all){
    var pos=all.lastIndexOf("\\");
    return all.substring(pos+1);  
}

//写入select上方查询select和弹出菜单的select的内容
function addOptionIntoSelect() {
	$("[name=clothes_gender]").html("<option value=\"\" selected>选择性别</option>" +
			"<option value=\"true\">男</option>"+
			"<option value=\"false\">女</option>");
	request("GET", "http://localhost:8080/suit/clothestype/operate",null,true,function(result){
		$("[name=clothes_type]").html("<option value=\"\" selected>选择类别</option>");
		$.each(result.data,function(idx, obj){
			$("[name=clothes_type]").append("<option value=\"" + obj.mark 
					+ "\" class=\"" + obj.mark +"\">" + obj.name + "</option>");
		})
	},errorMethod);
}

//图片的点击事件
function image_click(self) {
	var card = self.parentNode;
	$cardj = $(card);
	$cardj.find(".img_file").click();
}

//查询按钮的点击事件方法
function searchCard() {
	//获取要查询的性别
	var sgender = $("#forth").find("#gender_select").find("option:selected").text();
	var stype = $("#forth").find("#type_select").find("option:selected").text();
	
	//alert($("#forthBody").children(".list_add_form").length);
	//遍历所有衣服卡片，获取信息然后核实
	for(var i = 1; i<$("#forthBody").children(".list_add_form").length; i++) {
		$card = $("#forthBody").find(".list_add_form").eq(i);
		var gender = $card.find("[name=clothes_gender]").children("option:selected").text();
		var type = $card.find("[name=clothes_type]").children("option:selected").text();
		
		if((sgender === '选择性别' || gender === sgender) && (stype === '选择类别' || type === stype)) {
			$card.fadeIn('1000');
		} else {
			$card.fadeOut('1000');
		}
	}
}
//前端所有按钮点击事件处理方法，即显示所有衣服细目
function showAll() {
	//筛选框还原(记住这个要先把已经选中的selected属性设置为false;)
	$("#gender_select").children("option:selected").attr("selected", false);
	$("#type_select").children("option:selected").attr("selected", false);	
	$("#gender_select").children("option").eq(0).attr("selected", true);
	$("#type_select").children("option").eq(0).attr("selected", true);
	//alert($("#type_select").children("option").eq(0).text());
	//遍历所有卡片设置为显示状态
	for(var i = 1; i<$("#forthBody").children(".list_add_form").length; i++) {
		$card = $("#forthBody").find(".list_add_form").eq(i);
		$card.fadeIn('1000');
	}
}

//卡片中保存删除按钮的点击事件对应的两个方法！
function deleteCard(self) {
	var clothes = {};
	
	$cardDel = $(self.parentNode.parentNode);
	clothes.id = $cardDel.find("[name=list_clothes_id]").val();
	
	request("DELETE", "http://localhost:8080/suit/clothesoperate/operate",clothes,true,function(result){
		alert(result.description);
		if(result.code === 0) {
			$cardDel.fadeOut("1000");
		}
	},errorMethod);
}

function saveCard(self) {
	var clothes = {};
	
	$cardDel = $(self.parentNode.parentNode);
	clothes.id = $cardDel.find("[name=list_clothes_id]").val();
	clothes.mark = $cardDel.find("[name=list_clothes_mark]").val();
	clothes.name = $cardDel.find("[name=list_clothes_name]").val();
	clothes.price = $cardDel.find("[name=list_clothes_price]").val();
	
	clothes.gender = $cardDel.find("[name=clothes_gender]").find("option:selected").val();
	clothes.type = $cardDel.find("[name=clothes_type]").find("option:selected").val();
	clothes.imgUrl = $cardDel.find(".clothes_img").attr("src");
	alert("type : " + clothes.type + " imgUrl:" + clothes.imgUrl);
	if(!/^\d+$/.test(clothes.price)) {
		alert("价格不是整数！")
	} else {
		request("PUT", "http://localhost:8080/suit/clothesoperate/operate",clothes,true,function(result){
			alert(result.description);
		},errorMethod);
	}
}