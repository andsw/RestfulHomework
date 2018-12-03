package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "tbl_clothesType")
@NamedQueries({
    @NamedQuery(name = "ClothesType.findAll", query = "SELECT clothesType FROM ClothesType clothesType"),
    @NamedQuery(name = "ClothesType.listByName", query = "SELECT clothesType FROM ClothesType clothesType where clothesType.num like :num")
})
public class ClothesType extends IdEntity {
	private String num;//最大长度为20的字符串
	private String name;//最大长度为10字符串
	
	public ClothesType() {}
	
	public ClothesType(String num, String name) {
		super();
		this.num = num;
		this.name = name;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "ClothesType [num=" + num + ", name=" + name + ", id=" + id + "]";
	}
}
