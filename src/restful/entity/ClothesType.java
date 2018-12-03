package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "tbl_clothes_type")
@NamedQueries({
    @NamedQuery(name = "ClothesType.findAll", query = "SELECT clothesType FROM ClothesType clothesType"),
    @NamedQuery(name = "ClothesType.listByName", query = "SELECT clothesType FROM ClothesType clothesType where clothesType.mark like :mark")
})
public class ClothesType extends IdEntity {
	private String mark;//最大长度为20的字符串
	private String name;//最大长度为10字符串
	
	public ClothesType() {}
	
	public ClothesType(String num, String name) {
		super();
		this.mark = num;
		this.name = name;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "ClothesType [mark=" + mark + ", name=" + name + ", id=" + id + "]";
	}
}
