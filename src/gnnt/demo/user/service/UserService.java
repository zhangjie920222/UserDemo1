package gnnt.demo.user.service;

import gnnt.demo.user.model.Page;
import gnnt.demo.user.model.User;

public interface UserService {
	public Page listUser(String username, String gender, String interest,int departno, String fromtime, String totime, int pagenum,int pagesize);
	public int addUser(User user);
	public int delUser(int userid);
	public int modifyUser(User user);
    public User findByid(int userid);
    public void TestJdbctemplate();
}
