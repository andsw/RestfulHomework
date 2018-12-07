package restful.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "tbl_user")
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT user FROM User user"),
    @NamedQuery(name = "User.listByUsername", query = "SELECT user FROM User user where User.username like :username")
})
public class User extends IdEntity {
	private String username;// 4-16位的字母数字下划线 
	private String password;// 同上
	private String realName;// 2-5位的中文字符串
	private boolean gender; // 前端单选，jq转化为“true”或“false”传入后端即可！
	private boolean permission;//前端默认为false，表示为普通用户！
	private boolean model;
	
	public User() {}
	
	public User(String username, String password, String realName, boolean gender, boolean permission, boolean model) {
		super();
		this.username = username;
		this.password = password;
		this.realName = realName;
		this.gender = gender;
		this.permission = permission;
		this.model=model;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public boolean getGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	// 注意permission是boolean值，此方法本应该
	// 用isPermission作为方法名，但是那样不符合此项目规范，写成getXXX才可被识别！
	public boolean getPermission() {
		return permission;
	}
	public void setPermission(boolean permission) {
		this.permission = permission;
	}
	public boolean getModel() {
		return model;
	}

	public void setModel(boolean model) {
		this.model = model;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password + ", realName=" + realName + ", gender=" + gender
				+ ", permission=" + permission + ", model=" + model + ", id=" + id + "]";
	}
}
