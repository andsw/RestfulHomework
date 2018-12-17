package restful.dao;

import java.util.List;

import restful.database.EM;
import restful.entity.Dressed;

public class DressedDao implements BaseDao<Dressed>, SelectBaseDao<Dressed> {

	@Override
	public List<Dressed> findByUsernameEquals(Dressed dressed) {
		List<Dressed> dressedList = null;
		try{
			dressedList = EM.getEntityManager()
			.createNamedQuery("Dressed.listByUsername", Dressed.class)
			.setParameter("username", dressed.getUsername())
			.getResultList();
		} catch(Exception e) {
			System.out.println("dao中findByUsernameEquals出错");
		}
		
		return dressedList;
	}

	@Override
	public List<Dressed> findByUsernameLikes(Dressed dressed) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Dressed> list() {
		List<Dressed> dressedList = null;
		try{
			dressedList = EM.getEntityManager()
					.createNamedQuery("Dressed.findAll", Dressed.class)
					.getResultList();
		} catch(Exception e) {
			System.out.println("dao中list出错");
		}
		
		return dressedList;
	}

	@Override
	public boolean add(Dressed dressed) {
		boolean result = true;
		try {
			dressed.setId(0);
			dressed = EM.getEntityManager().merge(dressed);
			EM.getEntityManager().persist(dressed);
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("dao中add出错");
			result = false;
		}
		return result;
	}

	@Override
	public boolean update(Dressed dressed) {
		boolean result = true;
		try {
			EM.getEntityManager().persist(EM.getEntityManager().merge(dressed));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("dao中update出错");
			result = false;
		}
		return result;
	}

	@Override
	public boolean delete(Dressed dressed) {
		boolean result = true;
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge(dressed));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("dao中delete出错");
			result = false;
		}
		return result;
	}

}
