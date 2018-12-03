package restful.dao;

import java.util.List;

import restful.database.EM;
import restful.entity.ClothesType;

public class ClothesTypeDao implements BaseDao<ClothesType> {

	@Override
	public List<ClothesType> list() {
		List<ClothesType> clothesTypeList = null;
		try{
			clothesTypeList = EM.getEntityManager()
					.createNamedQuery("ClothesType.findAll", ClothesType.class)
					.getResultList();
		} catch(Exception e) {
			System.out.println("ClothesTypeDao中list出错");
		}
		return clothesTypeList;
	}

	@Override
	public boolean add(ClothesType clothesType) {
		boolean result = true;
		try {
			clothesType.setId(0);
			clothesType = EM.getEntityManager().merge(clothesType);
			EM.getEntityManager().persist(clothesType);
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("ClothesTypeDao中add出错");
			result = false;
		}
		return result;
	}

	@Override
	public boolean update(ClothesType clothesType) {
		boolean result = true;
		try {
			EM.getEntityManager().persist(EM.getEntityManager().merge(clothesType));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("ClothesTypeDao中update出错");
			result = false;
		}
		return result;
	}

	@Override
	public boolean delete(ClothesType clothesType) {
		boolean result = true;
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge(clothesType));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("ClothesTypeDao中delete出错");
			result = false;
		}
		return result;
	}
}
