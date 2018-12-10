<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<div id="third">
 			<div class="card" id="add_card">
				<label class="green_title" for="id_input">
					<h1 class="title_style">服饰类别</h1>
				</label>
				<table>
					<tr>
						<td><label for="mark_input">编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</label></td>
						<td><input type="text" name="mark" id="mark_input_add"/></td>
					</tr>
					<tr>
						<td><label for="name_input">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</label></td>
						<td><input type="text" name="mark" id="name_input_add"/></td>
					</tr>
					<tr>
						<td colspan="2"><button id="sole_button" onclick="addClothesType()">添加</button></td>	
					</tr>
				</table>
			</div>
			
		</div>