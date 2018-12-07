<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<div class="change_user_info">
	<table>
		<tr>
			<th colspan=4>修改用户信息</th>
		</tr>
		<tr>
			<td class="words">用户名称：</td>
			<td colspan="3"><input type="text" class="texts" id="username"></input></td>
		</tr>
		<tr>
			<td class="words">用户实名：</td>
			<td colspan="3"><input type="text" placeholder="请输入用户名" class="texts" id="realName"></input></td>
		</tr>
		<tr>
			<td class="words">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
			<td colspan="3"><input type="password" class="texts" placeholder="不需修改请留空" id="password"></input></td>
		</tr>
		<tr>
			<td class="words">密码确认：</td>
			<td colspan="3"><input type="password" class="texts" placeholder="不需修改请留空" id="password_confirming"></input></td>
		</tr>
		<tr>
			<td class="words">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
			<td><input type="radio" class="gender_radio" name="gender" value="true" id="man_radio"/>&nbsp;&nbsp;&nbsp;男
				<input type="radio" class="gender_radio" name="gender" value="false" id="woman_radio"/>&nbsp;&nbsp;&nbsp;女
			</td>
			<!-- 这里放置模特头像 -->
			<td colspan="2" rowspan="2">
				<div  id="model_select">
					<label for="first_head_radio" class="model_label" id="first_label">
						<input type="radio" id="first_head_radio" class="model_select_radio" name="model"/>
					</label>
					<label for="second_head_radio" class="model_label" id="second_label">
						<input type="radio" id="second_head_radio" class="model_select_radio" name="model"/>
					</label>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan=2><button class="save_button">保存信息</button></td>
		</tr>
	</table>
</div>