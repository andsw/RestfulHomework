package restful.api;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import restful.bean.Result;
import restful.dao.DressedDao;
import restful.entity.Dressed;

@Path("/dressedoperate")
public class DressedApi {
	private DressedDao dressedDao;
	
	public DressedApi() {
		this.dressedDao = new DressedDao();
	}
	
	@POST
	@Path("/list")
	@Produces("application/json;charset=UTF-8")
	public Result list() {
		Result result = new Result(1, "暂无用户", null, "");
		List<Dressed> dressedList = dressedDao.list();
		if(dressedList != null && dressedList.size() != 0) {
			result.setCode(0);
			result.setData(dressedList);
			System.out.println("dressedList : " + dressedList);
			result.setDescription("获取成功");
		}
		return result;
	}
	
	@POST
	@Path("/operate") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result insertDressed(Dressed dressed) {
		Result result = new Result(1, "插入失败", null, "");
		if(dressedDao.add(dressed)) {
			result.setCode(0);
			result.setDescription("插入成功");
		}
		return result;
	}
	
	@POST
	@Path("/select") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result selectDressed(Dressed dressed) {
		Result result = new Result(1, "查询失败", null, "");
		List<Dressed> dresseds = dressedDao.findByUsernameEquals(dressed);
		if(dresseds != null && !dresseds.isEmpty()) {
			result.setCode(0);
			result.setData(dresseds);
			result.setDescription("查询成功");
		}
		return result;
	}
	
	@DELETE 
	@Path("/operate") 
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result deleteStu(Dressed dressed) {
		Result result = new Result(1, "删除失败", null, "");
		if(dressedDao.delete(dressed)) {
			result.setCode(0);
			result.setDescription("删除成功");
		}
		return result;
	}
}
