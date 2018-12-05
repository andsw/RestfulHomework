<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>注册</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css" />
<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
</head>
<body>
	<h1>注册界面</h1>
	<input id="id" type = "hidden"/>
	账 号 ： <input type="text" id="username" placeholdler="请输入你的手机号码" name="username"><br>
	密 码 ： <input type="password" id="password" name="password"><br>
	真 名 ： <input type="text" id="realName" name="realName"/><br>
	性 别 ： <input type="text" id="gender" name="gender" placeholder="男：true  女：false"/><br>
	<input type="hidden" id="permission" name="permission" value="false">
	<button onclick="register()">注册</button>
</body>
<script>	
	$(document).ready(function () {
		
    });
	
	function register(){
		var user = {};
		user.id=$("#id").val();
		user.username = $("#username").val();
		user.password = $("#password").val();
		user.realName = $("#realName").val();
		user.gender = $("#gender").val()
		user.permission = $("#permission").val()
		request("POST","<%=basePath%>/user/register",user,drawList,serverError,true);
	}
	
	function drawList(responseData){
		showMessage(responseData);
<%--	if(responseData.code<0){
			return;
		}
		var resultList = $("#resultList");
		var cats = responseData.data;
		resultList.html("");
		$(cats).each(function(index,item){
			var catDiv = $("<div>");
			catDiv.html("["+(index+1)+"] id:"+item.id+", code:"+item.code+", name:"+item.name);
			
			var btDelete = $("<button>");
			btDelete.text("删除");
			btDelete.click(function(){
				request("POST","<%=basePath%>/demo/delete",item,doSearch,serverError,true);
			});	
			
			var btEdit = $("<button>");
			btEdit.text("修改");
			btEdit.click(function(){
				$("#catId").val(item.id);
				$("#catCode").val(item.code);
				$("#catName").val(item.name);				
			});	
			catDiv.append(btDelete);
			catDiv.append(btEdit);
			resultList.append(catDiv);
		});--%>
	}

    function request(method,url,data,successCallBack,errorCallBack,async){
        $.ajax({
            url: url,
            async:async,
            contentType: "application/json",
            data: JSON.stringify(data),
            method: method
        }).success(successCallBack).error(errorCallBack);
    }
    
    function showMessage(responseData){
    	console.log("showMessage",responseData);
    	alert(responseData.description);
    }

    function serverError(XMLHttpRequest, textStatus){
        console.log("responseText:",XMLHttpRequest.responseText);
        console.log("status:",XMLHttpRequest.status);
        console.log("textStatus:",textStatus);
        console.log("readyState:",XMLHttpRequest.readyState);
        alert("服务器错误，请检查前后台控制台输出！");
    }
    
    <%--	function doSearch(){
		var input = $("#searchValue");
		var cat = {"name":input.val()};
		request("POST","<%=basePath%>/demo/listByName",cat,drawList,serverError,true);
	}
	
	function doAdd(){
		var input = $("#searchValue");
		var cat = {};
		cat.code = $("#catCode").val();
		cat.name = $("#catName").val();
		request("POST","<%=basePath%>/demo/add",cat,doSearch,serverError,true);
	}
	
	function doAdd(){
		var cat = {};
		cat.code = $("#catCode").val();
		cat.name = $("#catName").val();
		request("POST","<%=basePath%>/demo/add",cat,doSearch,serverError,true);
	}
	
	function doUpdate(){
		var cat = {};
		cat.id =  $("#catId").val();
		cat.code = $("#catCode").val();
		cat.name = $("#catName").val();
		request("POST","<%=basePath%>/demo/update",cat,doSearch,serverError,true);
	} --%>
</script>
</html>