package restful.services;

import restful.bean.Result;
import restful.entity.User;
import restful.utils.AccountValidationUtil;

public class RegisterService extends BaseService{
	
	private AccountValidationUtil accountValidationUtil;
	
	public RegisterService() {
		super();
		accountValidationUtil = AccountValidationUtil.getInstance();
	}
	
	@Override
	public void service(User user, Result result) {
		
		System.out.println("账号验证服务类！");
		if(accountValidationUtil.isAccountInfoRight(user,result)) {
			if(!userDao.add(user)) {
				result.setCode(1);
				result.setDescription("用户注册失败！");
			}
		}
	}
	
}
