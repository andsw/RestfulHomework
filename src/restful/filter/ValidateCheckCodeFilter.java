package restful.filter;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

public class ValidateCheckCodeFilter implements ContainerRequestFilter{
	
	@Context 
	private HttpServletRequest httpServletRequest;
	
	@Override
	public void filter(final ContainerRequestContext context) throws IOException {
		
		System.out.println("\n进入ValidateCheckCodeFilter");
		
		HttpSession session = httpServletRequest.getSession();
		String checkCode = (String) session.getAttribute("checkcode");
		
		UriInfo uriInfo = context.getUriInfo();
		String path = uriInfo.getPath();
		
		//有验证码且访问路径为user的请求将被过滤！
		if(!"".equals(checkCode) && path.startsWith("/user/")) {
			MultivaluedMap<String, String> queryParam = context.getUriInfo().getQueryParameters();
			String inputCheckCode = queryParam.getFirst("checkcode");
			//不输入时为空字符串！
			if("".equals(inputCheckCode)) System.out.println("输入的验证码为空");
			System.out.println("inputCheckCode : "+ inputCheckCode + " checkCode : " + checkCode);
			if(!inputCheckCode.equalsIgnoreCase(checkCode)) {
				System.out.println("验证码错误！");
			    context.abortWith(Response.status(500)
			    	.entity("{description:验证码错误!}")
			    	.type(MediaType.APPLICATION_JSON)
			        .build());
			} else {
				// 干掉session的正确姿势！
				// 这样就不行了，后面连login页面都访问不了了！等我想想问题所在！
				System.out.println("干掉验证码session！");
				//session.invalidate();
				//session.setAttribute("checkcode", null)都没用！
				// TODO
				// 还是存在着验证码莫名其妙为null的问题。
				// 以及新验证码和之前的叠加问题！
				System.out.println("session.invalidate()这样子干不掉、、、");
				session.removeAttribute("checkcode");
			}
		}
		
		System.out.println("\n离开ValidateCheckCodeFilter");
	}

}
