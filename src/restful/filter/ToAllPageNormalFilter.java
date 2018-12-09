package restful.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import restful.utils.CookieUtil;

/*
 * 这个过滤器是用来过滤页面而非api请求！
 * 比如当用户未登录访问主页或其他页面时，
 * 这个过滤器获取cookie，获得登录状态，
 * 未登录就直接跳转到登录界面！用请求转
 * 发的方式跳转！
 * 
 * 而如果是已登录状态访问登录界面或是注
 * 册界面机会直接跳转到主页！想要访问的
 * 话必须先登出此用户
 * 
 * 有了这个就可以直接在登录成功后直接刷
 * 新登录界面进入主页了！
 * */

public class ToAllPageNormalFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	
	//  谁叫/*连无后缀的uri都拦截呢！！！无语
/*	private boolean isApiUri(String path) {
		return path.startsWith("/suit/user/") 
				|| path.startsWith("/suit/useroperate/");
	}
	
	private boolean isStaticSourceUri(String path) {
		return path.startsWith("/suit/js/") 
				|| path.startsWith("/suit/images/") 
				|| path.startsWith("/suit/css/");
	}*/
	
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		
		//先获取登录状态！
		HttpServletRequest request = (HttpServletRequest)servletRequest;
		HttpServletResponse response = (HttpServletResponse)servletResponse;
		
		String hasLogged = "";//cookie或者没有登录信息这个都为空字符串！
		/*Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if("hasLogged".equals(cookie.getName())) {
					isLogged = cookie.getValue() == null ? "" : cookie.getValue();
				}
			}
		}*/
		CookieUtil cookieUtil = CookieUtil.getInstance();
		hasLogged = cookieUtil.getCookieByName(request, "hasLogged");
		
		// 获得请求页面路径
		String path = request.getRequestURI();
		
		if(path != null && !path.endsWith(".js") && !path.endsWith(".css") 
				&& !path.endsWith(".png") && !path.endsWith(".jpg")) {
			System.out.println("\n进入页面过滤器");
			System.out.println("path =" + path);
			System.out.println("isLogged = " + 
			(hasLogged.equals("") ? "空字符串" : hasLogged));
		}
		
		if(path != null && path.endsWith(".jsp")) {
			
			//未登录 访问的是非loing和register界面！！！
			if("".equals(hasLogged) 
					&& !"/suit/login.jsp".equals(path) 
					&& !"/suit/register.jsp".equals(path)
					&& !"/suit/jsp/main_page.jsp".equals(path)
					&& !"/suit/jsp/clothes_page.jsp".equals(path)) {//!!!!!
				//未登录状态且访问的还不是登陆或注册页面！
				System.out.println("未登录，跳转到登录界面");
				response.sendRedirect("/suit/login.jsp");
				System.out.println("离开页面过滤器\n");
				return;
			} else if("true".equals(hasLogged) 
					&& ("/suit/login.jsp".equals(path) 
					|| "/suit/register.jsp".equals(path))) {
				//已登录但访问的是登录界面或注册界面
				System.out.println("已登录，跳转到主页界面");
				//request.getRequestDispatcher("/jsp/main.jsp").forward(request, response);
				response.sendRedirect("/suit/jsp/main_page.jsp");
				System.out.println("离开页面过滤器\n");
				return;
			} 
		}
		if(path != null && !path.endsWith(".js") && !path.endsWith(".css") 
				&& !path.endsWith(".png") && !path.endsWith(".jpg"))
			System.out.println("离开页面过滤器\n");
		filterChain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
