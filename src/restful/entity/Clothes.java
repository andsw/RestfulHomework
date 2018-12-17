package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "tbl_clothes")
@NamedQueries({
    @NamedQuery(name = "Clothes.findAll", query = "SELECT clothes FROM Clothes clothes"),
    @NamedQuery(name = "Clothes.listByMark", query = "SELECT clothes FROM Clothes clothes where Clothes.mark like :mark")
})
public class Clothes extends IdEntity{
	private String mark;
	private String name;
	private int price;
	private boolean gender;
	private String type;
	private String imgUrl;
	
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public boolean isGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	@Override
	public String toString() {
		return "Clothes [mark=" + mark + ", name=" + name + ", price=" + price + ", gender=" + gender + ", type=" + type
				+ ", imgUrl=" + imgUrl + ", id=" + id + "]";
	}
}
