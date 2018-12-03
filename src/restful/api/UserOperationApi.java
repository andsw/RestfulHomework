package restful.api;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import restful.bean.Result;
import restful.dao.UserDao;
import restful.entity.User;

@Path("/useroperate")
public class UserOperationApi {
	
	private UserDao userDao;
	
	public UserOperationApi() {
		userDao = new UserDao();
	}
	
	@GET
	@Path("/list")
	@Produces("application/json;charset=UTF-8")
	public Result list() {
		Result result = new Result(1, "暂无用户", null, "");
		List<User> userList = userDao.list();
		if(userList != null && userList.size() != 0) {
			result.setCode(0);
			result.setData(userList);
			System.out.println("userList : " + userList);
			result.setDescription("获取成功");
		}
		return result;
	}
	
	@POST
	@Path("/operate") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result insertStu(User user) {
		Result result = new Result(1, "插入失败", null, "");
		if(userDao.add(user)) {
			result.setCode(0);
			result.setDescription("插入成功");
		}
		return result;
	}
	
	/*@GET 
	@Path("/operate") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result selectStu(String ColumnName,User user) {
		Result result = new Result(1, "查询失败", null, "");
		return result;
	}*/
	
	@GET
	@Path("/operate") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result selectStu(User user) {
		Result result = new Result(1, "查询失败", null, "");
		List<User> users = userDao.findByUsernameEquals(user);
		if(users != null && !users.isEmpty()) {
			result.setCode(0);
			result.setData(users.get(0));
			result.setDescription("查询成功");
		}
		return result;
	}
	
	@PUT 
	@Path("/operate") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result updateStu(User user) {
		Result result = new Result(1, "更新失败", null, "");
		if(userDao.update(user)) {
			result.setCode(0);
			result.setDescription("更新成功");
		}
		return result;
	}
	
	@DELETE 
	@Path("/operate") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result deleteStu(User user) {
		Result result = new Result(1, "删除失败", null, "");
		if(userDao.delete(user)) {
			result.setCode(0);
			result.setDescription("删除成功");
		}
		return result;
	}
}
