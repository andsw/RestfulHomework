package restful.dao;

import java.util.List;

public interface BaseDao<T> {
	List<T> list();
	boolean add(T t);
	boolean update(T t);
	boolean delete(T t);
}
