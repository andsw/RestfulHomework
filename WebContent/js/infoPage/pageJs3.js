
function addClothesTypeCard(obj){
	//放在添加卡片的卡片后面
	$("#add_card").after("<div class=\"card\">"+
			"<input type=\"hidden\" value=\""+ obj.id +"\" name=\"id\"/>"+
			"<label class=\"green_title\" for=\"id_input\">"+
				"<h1 class=\"title_style\">服饰类别</h1>"+
			"</label>"+
			"<table>"+
				"<tr>"+
					"<td><label for=\"mark_input\">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label></td>"+
					"<td><input type=\"text\" name=\"mark\" value=\"" + obj.mark +"\" readonly/></td>"+
				"</tr>"+
				"<tr>"+
					"<td><label for=\"name_input\">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</label></td>"+
					"<td><input type=\"text\" name=\"name\" value=\"" + obj.name +"\"/></td>"+
				"</tr>"+
				"<tr>"+
					"<td colspan=\"2\"><button onclick=\"updateClothesType(this)\">保存</button>" +
					"<button onclick=\"deleteClothestype(this)\">删除</button></td>"+	
				"</tr>"+
			"</table>"+
		"</div>");
}

function addClothesType() {
	var type = {};
	type.mark = $("#mark_input_add").val();
	type.name = $("#name_input_add").val();
	if(type.name != ''){
		request("POST", "http://localhost:8080/suit/clothestype/operate",type,true,function(result){
			if(result.code === 0) {
				addClothesTypeCard(result.data);
			} else {
				alert(result.description);
			}
		},errorMethod);
	} else {
		alert("名称不能为空哦！")
	}
	$("#mark_input_add").val("");
	$("#name_input_add").val("");
}

function deleteClothestypeCard(card){
	$cardj = $(card);
	$cardj.fadeOut('slow');
}

function deleteClothestype(self) {
	var clothesType = {}; 
	var card = self.parentNode.parentNode.parentNode.parentNode.parentNode;
	$cardj = $(card);
	//删除也别忘了要加上id！！
	clothesType.id = $cardj.find('[name=id]').val();
	clothesType.mark = $cardj.find('[name=mark]').val();
	clothesType.name = $cardj.find('[name=name]').val();
	
	request("DELETE", "http://localhost:8080/suit/clothestype/operate",clothesType,true,function(result){
		if(result.code === 0) {
			deleteClothestypeCard(card);
		} else {
			alert(result.description)
		}
	},errorMethod);
}

function updateClothesType(self) {
	var clothesType = {}; 
	var card = self.parentNode.parentNode.parentNode.parentNode.parentNode;
	$cardj = $(card);
	clothesType.id = $cardj.find('[name=id]').val();
	clothesType.mark = $cardj.find('[name=mark]').val();
	clothesType.name = $cardj.find('[name=name]').val();
	if(clothesType.name != '') {
		request("PUT", "http://localhost:8080/suit/clothestype/operate",clothesType,true,function(result){
			alert(result.description)
		},errorMethod);	
	} else {
		alert("名称为空，不可修改！")
	}
	
}
