package restful.dao;

import java.util.List;

public interface SelectBaseDao<T> {
	List<T> findByUsernameEquals(T t);
	List<T> findByUsernameLikes(T t);
}
