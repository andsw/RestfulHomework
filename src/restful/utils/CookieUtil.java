package restful.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;

import restful.entity.User;

public class CookieUtil {
	
	private CookieUtil() {}
	
	private static class MyClass{
		public static CookieUtil cookieUtil = new CookieUtil();
	}
	
	public static CookieUtil getInstance() {
		return MyClass.cookieUtil;
	}
	
	public String getCookieByName(HttpServletRequest request, String cookieName) {
		String cookieValue = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookieName.equals(cookie.getName())) {
					cookieValue = cookie.getValue();
				}
			}
		}
		return cookieValue;
	}
	
	public void addUserInfoIntoResponse(HttpServletResponse response, User user) {
		Cookie[] cookies = new Cookie[7];
		cookies[0] = new Cookie("hasLogged", "true");
		cookies[1] = new Cookie("isAdmin", "" + user.getPermission());
		cookies[2] = new Cookie("username", user.getUsername());
		try {
			cookies[3] = new Cookie("realName", URLEncoder.encode(user.getRealName(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			System.out.println("放入cookie的中文转码失败！");
		}
		cookies[4] = new Cookie("isMan","" + user.getGender());
		cookies[5] = new Cookie("whichModel","" + user.getModel());
		cookies[6] = new Cookie("id", "" + user.getId());
		System.out.println("用户信息已放入cookie");
		
		/*
		 * 删除cookie的步骤！
		 * userCookie.setMaxAge(0);
		 * userCookie.setPath("/"); //路径一定要写上，不然干不掉的
		 * response.addCookie(userCookie);
		 * */
		
		for(Cookie cookie : cookies) {
			cookie.setPath("/");
			cookie.setMaxAge(60*60*24*7);
			response.addCookie(cookie);
		}
	}
	
	public void removeCookieFromResponse(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				//将MaxAge设置为0，然后再添加进response，相当当于删除！
				System.out.println(cookie.getName() + " cookie 清除成功！");
				cookie.setMaxAge(0);
				cookie.setPath("/");
				//记住啊！！！！！！！！这个要填写相同的路径然后才可以删除！！！！！！
				response.addCookie(cookie);
			}
		}
	}
}
