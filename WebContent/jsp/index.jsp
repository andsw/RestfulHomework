<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>    
<html>
<head>
<title>梦想试衣间</title>
<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
</head>
	<h1>main page</h1>
	<button onclick="logout()">注销账户！</button>
	<script>

<!-- 可以试试加密！！！使用cookie存储密钥，将机密后的密码上传至服务器-->

	$(document).ready(function () {
		
    });
	
	function logout(){
		request("POST","<%=basePath%>/user/logout", "", drawList, serverError, true);
	}
	
	function drawList(responseData){
		showMessage(responseData);
	}

    function request(method,url,data,async){
        myajax = $.ajax({
            url: url,
            async: async,
            contentType: "application/json",
            data: JSON.stringify(data), 
            method: method,
            timeout: 20000,
            //记住不管是登录成功还是失败，都会走这个函数
            success: function(result){
            		alert(result.description);
            		window.location.href="../login.jsp";
            	},
            //当url错误等找不到地址错误才走这个函数
        	error: function(XMLHttpRequest, textStatus, errorThrown){
        			alert("登录失败！"); 
        			alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
        	}
        });
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
</script>
</html>