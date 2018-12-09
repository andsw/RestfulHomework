<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<div id="second">
			<div style="width: calc(100% - 17px);overflow-x: hidden;" id="table-head">
	            <table class="table" style="width: 100%;table-layout: fixed;">
	                <thead>
		                <tr>
		                    <th>id</th>
							<th>用户名</th>
							<th>用户实名</th>
							<th>性别</th>
							<th>模型选择</th>
							<th>用户身份</th>
							<th>操作</th>
		                </tr>
	                </thead>
	            </table>
        	</div>
        	
        	<div style="width: 100%;height: 579px;overflow-y: scroll;" id="table-body">
	           <table class="table" style="width: 100%;table-layout: fixed">
	               <tbody>
	               		<!-- 这里填充数据！ -->
	               </tbody>
	           </table>
        	</div>
        </div>