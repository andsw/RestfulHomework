package restful.api;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.bean.Result;
import restful.entity.User;
import restful.services.BaseService;
import restful.services.LoginService;
import restful.services.RegisterService;
import restful.utils.CookieUtil;

@Path("/user")
public class UserApi {
	
	private BaseService registerService;
	private BaseService loginService;
	
	public UserApi() {
		registerService = new RegisterService();
		loginService = new LoginService();
	}

	@POST
	@Path("/login")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	//public Result login(@DefaultValue(" ") @QueryParam("checkcode") final String inputCheckCode, final User user, @Context final HttpServletRequest httpServletRequest)
	public Result login(final User user, @Context HttpServletResponse httpServletResponse) {
		System.out.println("访问到登录api方法");
		Result result = new Result(1, "登录失败", null, "");//1表示失败, 返回的改成了null而非user是不想传输过多没用的数据影响速度！
		loginService.service(user, result);
		if(0 == result.getCode()) {
			//用cookie记录登录状态和用户信息，以控制网站的登录用户状态和数据访问权限！不保存密码，保证安全！
			User userIndatabase = (User)result.getData();
			System.out.println("登录时正确用户信息：" + userIndatabase);
			
			System.out.println(userIndatabase.getId());
			
			// 使用cookie工具类添加cookie！
			CookieUtil cookieUtil = CookieUtil.getInstance();
			cookieUtil.addUserInfoIntoResponse(httpServletResponse, userIndatabase);
		}
		System.out.println("result" + result.toString());
		System.out.println("退出登录api方法");
		return result;
	}
	
	@POST
	@Path("/logout")
	@Produces("application/json;charset=UTF-8")
	public Result logout(@Context final HttpServletRequest httpServletRequest, @Context final HttpServletResponse httpServletResponse) {
		System.out.println("访问到登出api方法");
		Result result = new Result(0, "登出", null, "/login.jsp");//1表示失败
		
		// 使用cookie工具类去除cookie！
		CookieUtil cookieUtil = CookieUtil.getInstance();
		cookieUtil.removeCookieFromResponse(httpServletRequest, httpServletResponse);
		
		System.out.println("登出成功！");
		System.out.println("退出登出api方法");
		return result;
	}
	
	@POST
	@Path("/register")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result register(final User user) {
		System.out.println("访问到注册api方法");
		Result result = new Result(1, "注册失败", null, "");
		registerService.service(user, result);
		System.out.println("注册user：" + user);
		System.out.println("退出注册api方法");
		return result;
	}
}
