package restful.dao;

import java.util.List;

import restful.database.EM;
import restful.entity.User;

public class UserDao implements BaseDao<User>, SelectBaseDao<User>{
	public List<User> list() {
		List<User> userList = null;
		try{
			userList = EM.getEntityManager()
					.createNamedQuery("User.findAll", User.class)
					.getResultList();
		} catch(Exception e) {
			System.out.println("dao中list出错");
		}
		
		return userList;
	}
	
	public List<User> findByUsernameEquals(User user) {
		List<User> users = null;
		try{
			users = EM.getEntityManager()
			.createNamedQuery("User.listByUsername", User.class)
			.setParameter("username", user.getUsername())
			.getResultList();
		} catch(Exception e) {
			System.out.println("dao中findByUsernameEquals出错");
		}
		return users;
	}
	
	public List<User> findByUsernameLikes(User user) {
		List<User> userList = null;
		try{
			userList = EM.getEntityManager()
			.createNamedQuery("User.listByUsername", User.class)
			.setParameter("username", "%"+user.getUsername()+"%")
			.getResultList();
		} catch(Exception e) {
			System.out.println("dao中findByUsernameLikes出错");
		}
		
		return userList;
	}
	
	public boolean add(User user) {
		boolean result = true;
		try {
			user.setId(0);
			user = EM.getEntityManager().merge(user);
			EM.getEntityManager().persist(user);
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("dao中add出错");
			result = false;
		}
		return result;
	}
	
	public boolean update(User user) {
		boolean result = true;
		try {
			EM.getEntityManager().persist(EM.getEntityManager().merge(user));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("dao中update出错");
			result = false;
		}
		return result;
	}
	
	public boolean delete(User user) {
		boolean result = true;
		try {
			EM.getEntityManager().remove(EM.getEntityManager().merge(user));
			EM.getEntityManager().getTransaction().commit();
		} catch(Exception e) {
			System.out.println("dao中delete出错");
			result = false;
		}
		return result;
	}
}
