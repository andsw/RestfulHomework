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
import restful.dao.ClothesTypeDao;
import restful.entity.ClothesType;

@Path("/clothestype")
public class ClothesTypeApi {
	
	private ClothesTypeDao clothesTypeDao;
	
	public ClothesTypeApi() {
		clothesTypeDao = new ClothesTypeDao();
	}
	
	@Path("/operate")
	@POST
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result addClothesType(ClothesType clothesType) {
		System.out.println("/clothestype/operate post...");
		Result result = new Result(1,"类别已存在", null,"");
		if(clothesTypeDao.add(clothesType)) {
			result.setDescription("添加成功");
			result.setCode(0);
		}
		return result;
	}
	
	@Path("/operate")
	@GET
	@Produces("application/json;charset=UTF-8")
	public Result getAllClothesType() {
		System.out.println("/clothestype/operate get...");
		Result result = new Result(1, "获取失败", null,"");
		List<ClothesType> clothesTypeList = clothesTypeDao.list();
		if(clothesTypeList != null) {
			result.setCode(0);
			result.setDescription("获取成功");
			result.setData(clothesTypeList);
		}
		return result;
	}
	
	@Path("/operate")
	@PUT
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result updateClothesType(ClothesType clothesType) {
		System.out.println("/clothestype/operate put...");
		Result result = new Result(1,"修改失败", null,"");
		if(clothesTypeDao.update(clothesType)) {
			result.setDescription("修改成功");
			result.setCode(0);
		}
		return result;
	}
	
	@Path("/operate")
	@DELETE
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result deleteClothesType(ClothesType clothesType) {
		System.out.println("/clothestype/operate delete...");
		Result result = new Result(1,"删除失败", null, "");
		if(clothesTypeDao.delete(clothesType)) {
			result.setDescription("删除成功");
			result.setCode(0);
		}
		return result;
	}
}
