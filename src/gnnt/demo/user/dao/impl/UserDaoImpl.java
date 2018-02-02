package gnnt.demo.user.dao.impl;


import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import gnnt.demo.user.dao.UserDao;
import gnnt.demo.user.model.Depart;
import gnnt.demo.user.model.Page;
import gnnt.demo.user.model.User;
@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl  implements UserDao {
	
	private static final Logger log = LoggerFactory.getLogger(UserDaoImpl.class);
	
	@Autowired
	private SessionFactory sessionFactory;
	//list员工
	@SuppressWarnings("unchecked")
	@Override
	public Page listUser(String username, String gender, String interest,int departno, String fromtime, String totime, int pagenum,int pagesize) {		
		//默认分页
		int pageNum=1;
		int pageSize=6;
		List<User> list=new ArrayList<User>();
		Object[] obj = new Object[6];
		Page page = new Page();
		int i=0;
		try {
			String hql="from User where 1=1 ";
			if(username!=null&&!"".equals(username)){
				hql += " and userName like ?";
				obj[i]="%"+username+"%";
				i++;
				page.setUsername(username);
			}
			if(gender!=null&&!"".equals(gender)){
				hql += "and gender=?";
				obj[i]=gender;
				i++;
				page.setGender(gender);
			}
			if(interest!=null&&!"".equals(interest)){
				hql += "and interest like ?";
				String ins[] = interest.split(",");
				String interests ="";
				for(String str : ins){
					interests += "%"+str;
				}
				interests +="%";
				obj[i]=interests;
				i++;
				page.setInterest(interest);
			}
			if(departno>0){
				hql += "and departno=?";
				obj[i]=departno;
				i++;
				page.setDepartno(departno);
			}
			if(fromtime!=null&&!"".equals(fromtime)){
				hql += "and intime >= to_date(?,'yyyy-mm-dd')";
				obj[i]=fromtime;
				i++;
				page.setFromtime(fromtime);
			}
			if(totime!=null&&!"".equals(totime)){
				hql += "and intime <= to_date(?,'yyyy-mm-dd')";
				obj[i]=totime;
				i++;
				page.setTotime(totime);
			}								

			if(pagenum>0){
				pageNum=pagenum;
			}
			if(pagesize>0){
				pageSize=pagesize;
			}
			Session session = sessionFactory.openSession();
			Transaction ts = session.beginTransaction();
			Query query = session.createQuery(hql);
		
			if(i>0){
				System.out.println("i="+i);
				for(int j=0;j<i;j++){
					query.setParameter(j, obj[j]);
				}
			}			
			query.setFirstResult((pageNum-1)*pageSize);
			query.setMaxResults(pageSize);
			list = query.list();			
			ts.commit();
			session.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		page.setPageNum(pageNum);
		page.setPageSize(pageSize);
		page.setUsers(list);
		return page;
	}
	
	//删除员工
	@Override
	public int delUser(int userId) {
		int n =1;
		try {
			Session session = sessionFactory.openSession();
			Transaction ts = session.beginTransaction();
			User user = (User) session.get(User.class, userId);
			session.delete(user);
			ts.commit();
		} catch (Exception e) {
			n=0;
			e.printStackTrace();
		}
		return n;
	}
	//查询总条数
	@Override
	public int findTotalNum(String username, String gender, String interest,int departno, String fromtime, String totime, int pagenum,int pagesize) {
		Object[] obj = new Object[6];
		int n=0;
		int i=0;
		try {
			Session session = sessionFactory.openSession();
			Transaction ts = session.beginTransaction();
			String hql="select count(*) from User where 1=1 ";
			if(username!=null&&!"".equals(username)){
				hql += "and userName like ?";
				obj[i]=username;
				i++;
			}
			if(gender!=null&&!"".equals(gender)){
				hql += "and gender = ?";
				obj[i]=gender;
				i++;
			}
			if(interest!=null&&!"".equals(interest)){
				hql += "and interest like ?";
				String ins[] = interest.split(",");
				String interests ="";
				for(String str : ins){
					interests += "%"+str;
				}
				interests +="%";
				obj[i]=interests;
				i++;
			}
			if(departno>0){
				hql += "and departno = ?";
				obj[i]=departno;
				i++;
			}
			if(fromtime!=null&&!"".equals(fromtime)){
				hql += "and intime >= to_date(?,'yyyy-mm-dd')";
				obj[i]=fromtime;
				i++;
			}
			if(totime!=null&&!"".equals(totime)){
				hql += "and intime <= to_date(?,'yyyy-mm-dd')";
				obj[i]=totime;
				i++;
			}
						
			Query query = session.createQuery(hql);
			if(i>0){
				for(int j=0;j<i;j++){
					query.setParameter(j, obj[j]);
				}
			}			
		    long num = (Long)query.uniqueResult();   
		    n = new Integer(String.valueOf(num));
			ts.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return n;
	}
	//根据id查询员工
	@Override
	public User findByid(int userid) {
		User user=null;
		try {
			Session session = sessionFactory.openSession();
			Transaction ts = session.beginTransaction();
			user = (User) session.get(User.class, userid);
			ts.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	//修改或添加方法
	@Override
	public int saveOrUpdate(User user) {
		int n=1;
		try {
			Session session = sessionFactory.openSession();
			Transaction ts = session.beginTransaction();
			User use=new User();
			use = (User) session.get(User.class, user.getUserId());
			if(use==null){
				use = new User();
				Depart depart = new Depart();
				depart.setDepartno(user.getDepart().getDepartno());
				use.setUserName(user.getUserName());
				use.setGender(user.getGender());
				use.setInterest(user.getInterest().trim());
				use.setIntime(user.getIntime());
				use.setDepart(depart);
			}else{
				Depart depart = new Depart();
				depart.setDepartno(user.getDepart().getDepartno());
				use.setDepart(depart);
				use.setUserName(user.getUserName());
				use.setGender(user.getGender());
				use.setInterest(user.getInterest().trim());
				use.setIntime(user.getIntime());
			}
			session.saveOrUpdate(use);
			ts.commit();
		} catch (Exception e) {
			n=0;
			e.printStackTrace();
		}
		
		return n;
	}

}
