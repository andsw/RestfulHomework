package restful.dao;

import java.util.List;

import restful.database.EM;
import restful.entity.Clothes;

public class ClothesDao implements BaseDao<Clothes> {

	@Override
	public List<Clothes> list() {
		List<Clothes> clothesList = null;
		try{
			clothesList = EM.getEntityManager()
					.createNamedQuery("Clothes.findAll", Clothes.class)
					.getResultList();
		} catch(Exception e) {
			System.out.println("ClothesDao中list出错");
		}
		return clothesList;
	}

	@Override
	public boolean add(Clothes clothes) {
		boolean result = true;
		try {
			clothes.setId(0);
			clothes = EM.getEntityManager().merge(clothes);
			EM.getEntityManager().persist(clothes);
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("ClothesDao中add出错");
			result = false;
		}
		return result;
	}

	@Override
	public boolean update(Clothes clothes) {
		boolean result = true;
		try {
			EM.getEntityManager().persist(EM.getEntityManager().merge(clothes));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("ClothesDao中update出错");
			result = false;
		}
		return result;
	}

	@Override
	public boolean delete(Clothes clothes) {
		boolean result = true;
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge(clothes));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("ClothesDao中delete出错");
			result = false;
		}
		return result;
	}
	
}
