package gnnt.demo.user.model;

import java.util.Date;

import org.springframework.stereotype.Component;
@Component
public class User implements java.io.Serializable{
	
	private int userId;
	private String userName;
	private String gender;
	private String interest;//兴趣爱好
	private Date intime;//入职时间
	private Depart depart;
	
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	
	public Date getIntime() {
		return intime;
	}
	public void setIntime(Date intime) {
		this.intime = intime;
	}
	public Depart getDepart() {
		return depart;
	}
	public void setDepart(Depart depart) {
		this.depart = depart;
	}
	
	

	
}
