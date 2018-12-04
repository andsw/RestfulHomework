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
		
		System.out.println("\n进入验证码核实过滤器");
		
		HttpSession session = httpServletRequest.getSession();
		String checkCode = (String) session.getAttribute("checkcode");
		
		UriInfo uriInfo = context.getUriInfo();
		String path = uriInfo.getPath();
		
		//有验证码且访问路径为user的请求将被过滤！
		if(!"".equals(checkCode) && path.startsWith("/user/login")) {
			MultivaluedMap<String, String> queryParam = context.getUriInfo().getQueryParameters();
			String inputCheckCode = queryParam.getFirst("checkcode");
			//不输入时为空字符串！
			if("".equals(inputCheckCode)) System.out.println("输入的验证码为空");
			System.out.println("inputCheckCode : "+ inputCheckCode);
			System.out.println(" checkCode : " + checkCode);
			if(!inputCheckCode.equalsIgnoreCase(checkCode)) {
				System.out.println("验证码错误！");
			    context.abortWith(Response.status(500)
			    	.entity("{description:验证码错误!}")
			    	.type(MediaType.APPLICATION_JSON)
			        .build());
			}
		}
		System.out.println("离开验证码核实过滤器\n");
	}

}
