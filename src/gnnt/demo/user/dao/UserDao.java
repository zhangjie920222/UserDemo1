package gnnt.demo.user.dao;

import gnnt.demo.user.model.Page;
import gnnt.demo.user.model.User;

public interface UserDao extends BaseDao{
	
	public Page listUser(String username, String gender, String interest,int departno, String fromtime, String totime, int pagenum,int pagesize);
	public int delUser(int userId);
	public int findTotalNum(String username, String gender, String interest,int departno, String fromtime, String totime, int pagenum,int pagesize);
    public User findByid(int userid);
    public int saveOrUpdate(User user);
}
