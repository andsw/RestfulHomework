package restful.services;

import restful.bean.Result;
import restful.dao.UserDao;
import restful.entity.User;

public abstract class BaseService {
	protected UserDao userDao;
	
	public BaseService() {
		this.userDao = new UserDao();
	}

	public abstract void service(User user, Result result);
}
