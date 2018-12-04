package restful.filter;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.UriInfo;

/*
 * 此过滤器即检查用户的访问权限，以过滤一些非法操作！
 * 可用权限入下所示！
 * 可用权限		具备权限的角色		相应URI
 * 登录权			匿名用户			/user/*
 * 注册权			匿名用户			/user/*
 * 个人信息修改		登录用户			/useroperate/operate
 * 试衣间			登录用户			待定
 * 用户管理		管理员			
 * 服饰类别管理		管理员			
 * 服饰管理		管理员			
 * */

/*
 * 用户名称不能修改！
 * 
 * */

public class PermissionValidateFilter implements ContainerRequestFilter{

	@Override
	public void filter(ContainerRequestContext context) throws IOException {
		System.out.println("\n进入权限过滤器");
		UriInfo uriInfo = context.getUriInfo();
		String path = uriInfo.getPath();
		
		String methodName = context.getMethod();
		
		if("POST".equals(methodName) && path.startsWith("/user")) {
			//登录和注册过滤
			
		} else if(path.startsWith("/useroperate/operate")) {
			if("POST".equals(methodName)) {
				// 插入用户
			} else if("GET".equals(methodName)) {
				// 获取某个用户
			} else if("PUT".equals(methodName)) {
				// 更新用户信息
			} else if("DELETE".equals(methodName)) {
				//删除某个用户信息
			}
		} else if(path.startsWith("/useroperate/list")) {
			//获取所有用户权限过滤
		}
		
		HttpServletRequest request = (HttpServletRequest) context.getRequest();
		Cookie[] cookies = request.getCookies(); 
		System.out.println("cookies.length" + cookies.length); 
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				String name = cookie.getName();
				if("username".equals(name)) {
					
				} else if("realName".equals(name)) {
					
				} else if("isAdmin".equals(name)) {
					
				} else if("hasLogged".equals(name)) {
					
				} else if("isMan".equals(name)) {
					
				}
			}
		}
		System.out.println("离开权限过滤器\n");
	}

}
