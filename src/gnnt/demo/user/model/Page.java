package gnnt.demo.user.model;

import java.util.List;

public class Page {
	private int pageSize;//ÿҳ����
	private int pageNum;//ҳ��
	private int totalPageNum;//��ҳ��
	private int totalPageSize;//������
	
	private String username;
	private String gender;
	private String interest;//��Ȥ����
	private String fromtime;//��ְʱ��1
	private String totime;//��ְʱ��2
	private String departname;//��������
	private Integer departno;	
	private List<User> users;
	
	public List<User> getUsers() {
		return users;
	}
	public void setUsers(List<User> list) {
		this.users = list;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getTotalPageNum() {
		return totalPageNum;
	}
	public void setTotalPageNum(int totalPageNum) {
		this.totalPageNum = totalPageNum;
	}
	public int getTotalPageSize() {
		return totalPageSize;
	}
	public void setTotalPageSize(int totalPageSize) {
		this.totalPageSize = totalPageSize;
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
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
	public String getDepartname() {
		return departname;
	}
	public void setDepartname(String departname) {
		this.departname = departname;
	}
		
	public String getFromtime() {
		return fromtime;
	}
	public void setFromtime(String fromtime) {
		this.fromtime = fromtime;
	}
	public String getTotime() {
		return totime;
	}
	public void setTotime(String totime) {
		this.totime = totime;
	}
	public Integer getDepartno() {
		return departno;
	}
	public void setDepartno(Integer departno) {
		this.departno = departno;
	}
	

}
