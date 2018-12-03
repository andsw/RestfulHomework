package restful.services;

import java.util.List;

import restful.bean.Result;
import restful.entity.User;

public class LoginService extends BaseService{
	
	public LoginService() {
		super();
	}
	
	@SuppressWarnings("null")
	@Override
	public void service(User user, Result result) {
		List<User> users =  userDao.findByUsernameEquals(user);
		if(users == null) {
			result.setData("用户" + user.getUsername() + "不存在！");
		} else if(!user.getPassword().equals(users.get(0).getPassword())) {
			result.setData("密码错误！");
		} else {
			result.setDescription("成功登录");
			result.setCode(0);//0表示成功
			result.setData(users.get(0));
		}
	}
}
