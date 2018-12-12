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
	$card = $("#first_card").clone();
	$card.find("[name=list_clothes_mark]").val(obj.mark);
	$card.find("[name=list_clothes_name]").val(obj.name);
	$card.find("[name=list_clothes_price]").val(obj.price);
	$card.find("[name=clothes_gender]").children("option").eq(obj.gender ? 1 : 2).attr("selected", true);
	$card.find("[name=clothes_type]").find("." + obj.type).attr("selected", true);
	//if(obj.imgUrl != "../img/data/suits/unknown.png")
		alert(obj.imgUrl);
	/*alert($card.find(".clothes_img").attr("src"));*/
	//alert("change");
	$card.find(".clothes_img").attr("src", obj.imgUrl);
	
	$card.show();
	$card.css("display", "inline-block");
	$("#forthBody").append($card);
}

function addOptionIntoSelect(){
	$("[name=clothes_gender]").html("<option value=\"\" disabled selected>选择性别</option>" +
			"<option value=\"true\">男</option>"+
			"<option value=\"false\">女</option>");
	request("GET", "http://localhost:8080/suit/clothestype/operate",null,true,function(result){
		$("[name=clothes_type]").html("<option value=\"\" disabled selected>选择类别</option>");
		$.each(result.data,function(idx, obj){
			$("[name=clothes_type]").append("<option value=\"" + obj.mark 
					+ "\" class=\"" + obj.mark +"\">" + obj.name + "</option>");
		})
	},errorMethod);
}