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
import restful.dao.ClothesDao;
import restful.entity.Clothes;

@Path("/clothesoperate")
public class ClothesApi {
	
	private ClothesDao clothesDao;
	
	public ClothesApi() {
		clothesDao = new ClothesDao();
	}
	
	@Path("/operate")
	@POST
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result addClothesType(Clothes clothes) {
		
		@SuppressWarnings("unchecked")
		List<Clothes> clothesList = (List<Clothes>) getAllClothes().getData();
		
		Result result = new Result(1, "衣服已存在", null, "");
		boolean isExisted = true;
		for(Clothes clothes0 : clothesList) {
			if(clothes0.getMark().equals(clothes.getMark())) {
				isExisted = false;
			}
		}
		if(isExisted) {
			if(clothesDao.add(clothes)) {
				result.setDescription("添加成功");
				result.setCode(0);
				//这一次就是用来查找已经添加进数据库的该条数据的id！
				@SuppressWarnings("unchecked")
				List<Clothes> list = (List<Clothes>) getAllClothes().getData();
				if(list != null) {
					for(Clothes clothes0 : list) {
						if(clothes0.getMark().equals(clothes.getMark())) {
							clothes.setId(clothes0.getId());
						}
					}
				}
				result.setData(clothes);
			}
		}
		return result;
	}
	
	@Path("/operate")
	@GET
	@Produces("application/json;charset=UTF-8")
	public Result getAllClothes() {
		System.out.println("/clothes/operate get...");
		Result result = new Result(1, "获取失败", null,"");
		List<Clothes> clothesList = clothesDao.list();
		if(clothesList != null) {
			result.setCode(0);
			result.setDescription("获取成功");
			result.setData(clothesList);
		}
		return result;
	}
	
	@Path("/operate")
	@PUT
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result updateClothesType(Clothes clothes) {
		System.out.println("/clothes/operate put...");
		Result result = new Result(1,"修改失败", null,"");
		if(clothesDao.update(clothes)) {
			result.setDescription("修改成功");
			result.setCode(0);
		}
		return result;
	}
	
	@Path("/operate")
	@DELETE
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result deleteClothesType(Clothes clothes) {
		System.out.println("/clothes/operate delete...");
		Result result = new Result(1,"删除失败", null, "");
		if(clothesDao.delete(clothes)) {
			result.setDescription("删除成功");
			result.setCode(0);
		}
		return result;
	}
	
}
