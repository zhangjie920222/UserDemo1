package gnnt.demo.user.action;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import gnnt.demo.user.model.Page;
import gnnt.demo.user.model.User;
import gnnt.demo.user.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import org.apache.struts2.convention.annotation.Result;


@Controller  
@Scope("prototype")  
@ParentPackage("struts-default")  
@Namespace(value = "/user")  
public class UserAction extends ActionSupport implements ModelDriven{
	private static final long serialVersionUID = 1L;
	@Resource
	private UserService userService;
	//模型传值
	private User user;
	//分页
	private int pagenum;
	private int pagesize;
	HttpServletRequest request = ServletActionContext.getRequest();
	
	//list员工
	@Action(value = "listUser" , results  = {@Result(name = "success", location = "/jsp/listUser.jsp"),@Result(name = "error", location = "/exceptionPage.jsp")})
    public String listUser(){
    	Page page = new Page();
    	try {
    		String username = request.getParameter("username");
    		String gender = request.getParameter("gender");
    		String interest = request.getParameter("interest");
    		String departnos = request.getParameter("departno");
    		String pagenums = request.getParameter("pagenum");
    		String pagesizes = request.getParameter("pagesize");
    		if(pagenums!=null&&!"".equals(pagenums)){
    			pagenum = Integer.parseInt(pagenums);
    		}
    		if(pagesizes!=null&&!"".equals(pagesizes)){
    			pagesize = Integer.parseInt(pagesizes);
    		}
    		int departno=0;
    		if(departnos!=null&&!"".equals(departnos)){
    			departno =  Integer.parseInt(departnos);
    		}    		
    		String fromtime =request.getParameter("fromtime");
    		String totime =request.getParameter("totime");	
    		page = userService.listUser(username,gender,interest, departno,fromtime, totime, pagenum,pagesize);
    		request.setAttribute("pageinfo", page);
    		return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
    	
	    		
    }
	
	 //到修改员工页面
	@Action(value = "toModifyUser" , results  = {@Result(name = "success", location = "/jsp/modifyUser.jsp"),@Result(name = "error", location = "/exceptionPage.jsp")})
    public String toModifyUser() {
    	 String userids = request.getParameter("userid");
    	 int userid = Integer.parseInt(userids);
    	 User user = userService.findByid(userid);
         if(user!=null){ 
        	String interest = user.getInterest();
         	String[] interests = interest.split(",");
         	List<String> list = new ArrayList<String>();
         	for(String str:interests){
         		list.add(str.trim());
         	}
         	request.setAttribute("interests", list);
         	request.setAttribute("user", user);
         	return SUCCESS;
         }else{
         	return ERROR;
         }
    	

    }
	
	 //修改员工
	@Action(value = "modifyUser" , results  = {@Result(name = "success", location = "/jsp/modifyUser.jsp"),@Result(name = "error", location = "/exceptionPage.jsp")}) 
    public String modifyUser() {  		
    	int n = userService.modifyUser(user);
        if(n>0){
    		request.setAttribute("isSuccess", "yes");
         	return SUCCESS;
         }else{
         	return ERROR;
         }

    }
	
	 //添加员工
	@Action(value = "addUser" , results  = {@Result(name = "success", location = "/jsp/addUser.jsp"),@Result(name = "error", location = "/exceptionPage.jsp")})	    
    public String addUser(){  
    	int n = userService.addUser(user);   	
        if(n>0){
    		request.setAttribute("isSuccess", "yes");
         	return SUCCESS;
         }else{
         	return ERROR;
         }
	
    }
	
	//删除员工
	@Action(value = "delUser" , results  = {@Result(name = "success", location = "/jsp/modifyUser.jsp"),@Result(name = "error", location = "/exceptionPage.jsp")})	    
    public String delUser(){
        int n = userService.delUser(user.getUserId());       
        if(n>0){
        	request.setAttribute("isSuccess", "yes");
        	return SUCCESS;
        }else{
        	return ERROR;
        }
    	
    }
	
	//测试修改员工（template）
		@Action(value = "testUser" , results  = {@Result(name = "success", location = "/jsp/modifyUser.jsp"),@Result(name = "error", location = "/exceptionPage.jsp")})	    
	    public String testUser(){
	        userService.TestJdbctemplate();       	       
	        return SUCCESS;	      
	    }

	public int getPagenum() {
		return pagenum;
	}
	public void setPagenum(int pagenum) {
		this.pagenum = pagenum;
	}
	public int getPagesize() {
		return pagesize;
	}
	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public User getModel() {
		if(user== null){
	          user = new User();
	       }
	    return user;
	}
	
	
    
}
