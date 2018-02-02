package gnnt.demo.user.model;

import org.springframework.stereotype.Component;

@Component
public class Depart implements java.io.Serializable{
	private Integer departno;
	private String departname;
	
	
	public Integer getDepartno() {
		return departno;
	}
	public void setDepartno(Integer departno) {
		this.departno = departno;
	}
	public String getDepartname() {
		return departname;
	}
	public void setDepartname(String departname) {
		this.departname = departname;
	}

	

}
