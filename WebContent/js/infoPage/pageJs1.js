function saveUser(){
	var password_confirming = $('#password_confirming').val();
	var user = {};
	user.password=$('#password').val();
	user.realName=$('#realName').val();
	if(user.password != password_confirming) {
		alert("密码两次输入不匹配！")
	} else if(user.realName.length === 0) {
		alert("用户实名为空，不可修改！")
	} else {
		user.id=getCookie("id");
		user.username=$('#username').val();
		// 试验一番发现这个以name为属性获取的永远都是第一个即男的和左边的值。所以要两个分开获取然后ifelse判断！
		/*if($('#man_radio').attr("checked") === 'checked') {// 获得一个就行了，非此即彼！！
			user.gender='true';
		} else {
			user.gender='false';
		}*/
		
		user.gender = man;
		user.model=whichModel;
		
		alert("in saveUser username = " + user.username);
		alert("in saveUser is Man? " + user.gender);
		alert("in saveUser is right model?  " + user.model);
		user.permission=getCookie("isAdmin");
		var successMethod = function(result){
			alert(result.description)
		}
		request("PUT", "http://localhost:8080/suit/useroperate/operate", user, true, successMethod, errorMethod)
	}
}

var man = false;
function changeModelImage() {
	if(whichPage===1){
		man = !man;
	}
	//alert(man)
	if(man === true) {
		$("#first_label").css("background", "url(../img/register/man1.png) no-repeat")
		$("#second_label").css("background", "url(../img/register/man2.png) no-repeat")
	} 
	if(man===false) {
		//alert("change to girl");
		$("#first_label").css("background", "url(../img/register/woman1.png) no-repeat")
		$("#second_label").css("background", "url(../img/register/woman2.png) no-repeat")
	}
}

var whichModel = false;
function changeModelNumber() {
	if(whichPage===1){
		whichModel = !whichModel;
	}
}