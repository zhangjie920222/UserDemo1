package gnnt.demo.user.service.impl;

import javax.annotation.Resource;

import org.hibernate.validator.constraints.Range;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gnnt.demo.user.dao.TestDao;
import gnnt.demo.user.dao.UserDao;
import gnnt.demo.user.model.Page;
import gnnt.demo.user.model.User;
import gnnt.demo.user.service.UserService;

@Transactional //�����������
@Service("userService")
public class UserServiceImpl implements UserService{
	private static final Logger log = LoggerFactory.getLogger(UserServiceImpl.class);
	@Resource
	private UserDao userDao;
	@Resource
	private TestDao testDao;
    //list user
	@Override
	public Page listUser(String username, String gender, String interest,int departno, String fromtime, String totime, int pagenum,int pagesize) {
		Page page = new Page();
	    page = userDao.listUser(username,gender, interest,departno,  fromtime,totime, pagenum,pagesize);
		int totalsize = userDao.findTotalNum(username, gender, interest, departno, fromtime, totime, pagenum, pagesize);
		int totalNum=0;
		int pageSize= page.getPageSize();
		if(totalsize%pageSize==0){
			totalNum=totalsize/pageSize;
		}else{
			totalNum=totalsize/pageSize+1;
		}
		page.setTotalPageSize(totalsize);
		page.setTotalPageNum(totalNum);
		return page;
	}
	  //��� user
	@Override
	public int addUser(User user) {
		int n = userDao.saveOrUpdate(user);
		return n;
	}
	 //ɾ�� user
	@Override
	public int delUser(int userid) {
		int n = userDao.delUser(userid);
		return n;
	}
	 //�޸� user
	@Override
	public int modifyUser(User user) {
		int n = userDao.saveOrUpdate(user);
		return n;
	}
	 //����id��ѯ
	@Override
	public User findByid(int userid) {
		User user = userDao.findByid(userid);
		return user;
	}
	@Override
	public void TestJdbctemplate() {
		 try {          
			    testDao.testUser();
			    userDao.findByid(12);
		       } catch (Exception e) {         		                
		         e.printStackTrace();         
		     }      
		
	}
  

	

}
