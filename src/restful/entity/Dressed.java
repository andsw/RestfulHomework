package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "tbl_dressed_on")
@NamedQueries({
    @NamedQuery(name = "Dressed.findAll", query = "SELECT dressed FROM Dressed dressed"),
    @NamedQuery(name = "Dressed.listByUsername", query = "SELECT dressed FROM Dressed dressed where Dressed.username like :username")
})
public class Dressed extends IdEntity {
	private String username;
	private String mark;
	private int zindex;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public int getZindex() {
		return zindex;
	}
	public void setZindex(int zindex) {
		this.zindex = zindex;
	}
	@Override
	public String toString() {
		return "Dressed [username=" + username + ", mark=" + mark + ", zindex=" + zindex + ", id=" + id + "]";
	}
}
