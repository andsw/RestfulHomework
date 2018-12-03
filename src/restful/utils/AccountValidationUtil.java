package restful.utils;

import java.util.regex.Pattern;

import restful.bean.Result;
import restful.entity.User;

public class AccountValidationUtil {

	// 用户名为4-16位的 '字母','数字','下划线' 的组合字符串
	public boolean isUsernameInRightFormat(String username) {
		return Pattern
				.matches("^[a-zA-Z0-9_]{4,16}$"
						, username);
	}
	
	// 实名为2到5位的中文字符的字符串！
	public boolean isNameInChinese(String realName) {
		return Pattern.matches("^[\\u4E00-\\u9FA5]{2,5}$", realName);
	}
	
	public boolean isPasswordInRightFormat(String password) {
		return Pattern
		.matches("^[a-zA-Z0-9_]{3,16}$"
				, password);
	}
	
	//因为有触发器！所以不需要这个！
	/*public boolean isSomeoneExitsInDB(User user) {
		List<User> list = userDao.list();
		boolean validationResult = true;
		for(User user0 : list) {
			if(user0.getUsername().equals(user.getUsername()) 
				&& user0.getId() == user.getId()) {
				validationResult = false;
			}
		}
		return list.size() == 0 || validationResult;
	}*/
	
	public boolean isAccountInfoRight(User user, Result result) {
		if(!isUsernameInRightFormat(user.getUsername())) {
			result.setDescription("用户名为4-16位的 '字母'、'数字'或'下划线' 的字符串");
		} else if(!isNameInChinese(user.getRealName())) {
			result.setDescription("实名为2-5位的中文字符串");
		} else if(!isPasswordInRightFormat(user.getPassword())) {
			result.setDescription("密码为4-16位的 '字母'、'数字'或'下划线' 的字符串");
		} else {
			result.setCode(0);
			result.setDescription("注册成功");
		}
		return result.getCode() == 0;
		//&& isSomeoneExitsInDB(user)
	}
}
