<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jspPath = basePath;
request.setAttribute("jspPath", jspPath);
request.setAttribute("basePath", basePath);
%>
<%//在EL表达式中是获取不到 list 集合的长度的，引用本标签可以用以下方式获取返回集合的长度：${fn:length(list)}%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%//格式化用到的标签：<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm:ss"/> %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>list</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="js/tool.js"></script>
	<script type="text/javascript" src="laydate/laydate.js"></script>
	<style type="text/css">
	.body1 { 
     background-color:#999999; 
     filter:Alpha(Opacity=40); 
     } 
	 table td{
	   text-align:center;
	   line-height:38px;
	} 
	</style>
  </head>
  
  <body>
   <form id="frm" action="user/listUser.do" method="post" >
  <div id="resetformdiv">
   <div style="width:550px;margin:0 auto;margin-top:20px;">
     <label>姓名</label>&nbsp;&nbsp;<input type="text" name="username" value="${pageinfo.username}"/>
     &nbsp;&nbsp; <label>性别</label>&nbsp;&nbsp;
       <select name="gender" id="selgender">
                         <option id="allman" value="">不限</option>
                         <option id="man" value="男">男</option>
                         <option id="woman" value="女">女</option>
       </select>
     &nbsp;&nbsp;<label>爱好</label>&nbsp;&nbsp;<input type="text" name="interest" value="${pageinfo.interest}"/>
   </div>
   <div style="width:560px;margin:0 auto;margin-top:20px;" id="timet">
     <label>部门</label>&nbsp;&nbsp;
     <select name="departno" id="seldepart">
     <option value="">全部</option>
     <option value="1">研发部</option>
     <option value="2">测试部</option>
     <option value="3">集成部</option>
     <option value="4">网络部</option>
     <option value="5">人事部</option>
     </select>
     &nbsp;&nbsp;<label>入职时间</label>&nbsp;&nbsp;
     <input type="text" name="fromtime" class="laydate-icon" value="${pageinfo.fromtime}"/>
     <label>一</label>
     <input type="text" class="laydate-icon" name="totime"  value="${pageinfo.totime}"/>
   </div>
   <div style="width:200px;margin:0 auto;margin-top:20px;margin-bottom:20px;">
      <input type="button" id="search" value="查询"/>
      <input type="button" value="重置" onclick="resetform()"/>
      <input type="button" onclick="toAdduser(1);"value="添加员工"/>
   </div>
   </div>
   <div style="width:810px;min-width:810px;margin:0 auto;">
   <table style="width:100%;" border="1">
     <tr style="background:#ccc;">
       <td style="width:100px;">姓名</td>
       <td style="width:50px;">性别</td>
       <td style="width:200px;">爱好</td>      
       <td style="width:100px;">部门</td>
       <td style="width:100px;">入职时间</td>
       <td style="width:50px;">操作</td>
     </tr>
       <c:forEach var="us" items="${pageinfo.users}">      
						        <tr>	
									<td>${us.userName}</td>
									<td>${us.gender}</td>
									<td>${us.interest}</td>
									<td>${us.depart.departname}</td>
									<td>
									<fmt:formatDate value="${us.intime}" pattern="yyyy-MM-dd" /> 
                                     <%--  <fmt:parseDate value="${us.intime}" pattern="yyyy-MM-dd" var="receiveDate"></fmt:parseDate>
                                      <fmt:formatDate value="${receiveDate}" pattern="yyyy-MM-dd" ></fmt:formatDate> --%>
                                    </td>									
									<td><a href="javascript:void(0)" onclick="toModifyUser(${us.userId})">编辑</a></td>
								</tr>
		</c:forEach>	
	  <tr>
	  <td  colspan="6" style="text-align:center;">
	    <input type="hidden" id="pageNo" name="pagenum" value="${pageinfo.pageNum }"/>
        <input type="hidden" id="pageSize" name="pagesize" value="${pageinfo.pageSize }"/>
	    <input type="button" onclick="gotoPage(1)" value="首页"/>
		<input type="button" onclick="gotoPage(${pageinfo.pageNum-1})" value="上一页"/>
		<input type="button" onclick="gotoPage(${pageinfo.pageNum+1})" value="下一页"/>
		<input type="button" onclick="gotoPage(${pageinfo.totalPageNum})" value="尾页"/>
	         当前第<input name="pageNum--" value="${pageinfo.pageNum}" id="repagenum" style="width:30px;" type="text" onkeydown="function keydown(e){e = e||event;  if(e.keyCode == 13) {gotoPage($(this).val());}return;}"/>
	         页/共<span>${pageinfo.totalPageNum}</span>页
	         每页显示<input name="pageSize--" value="${pageinfo.pageSize}" id="repagesize" style="width:30px;" type="text"/>条，共<span>${pageinfo.totalPageSize}</span>条
	  </td>
	  </tr>	
   </table>
   </div>
  </form>
  <script type="text/javascript">
    var reshf;//打开窗口返回值，用于关闭窗口时刷新父页面
    jQuery(document).ready(function(){
       //性别
       var gender = '${pageinfo.gender}';
       if(gender=='男'){
         $("#man").attr("selected","selected");
       }else if(gender=='女'){
         $("#woman").attr("selected","selected");
       }else{
         $("#allman").attr("selected","selected");
       }
       //选中部门
       var departno = '${pageinfo.departno}';
       var index = departno;
       $("#seldepart").get(0).selectedIndex=index;//index为索引值
	   $("#search").click(function(){	
	              frm.method="post";
	              frm.pagenum.value = 1;
	              frm.submit();		
				 // $("#frm").submit();
			});			
	});
    //添加窗口
    function toAdduser(){
     var openUrl = "${jspPath}jsp/addUser.jsp";//弹出窗口的url
     var iWidth=600; //弹出窗口的宽度;
     var iHeight=400; //弹出窗口的高度;
     var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
     var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
     reshf = window.open(openUrl, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no,resizable=no,location=no, status=no');
     //for chrome
      if (!reshf) {
        reshf = window.reshf;
      }
       //关闭子窗口后刷新父窗口
      if(reshf.closed){
        window.opener.location.reload();
        window.onunload = function(){window.opener.location.reload();} 
       }	
   }
    //修改窗口
    function toModifyUser(id){
     var openUrl = "user/toModifyUser.do?userid="+id+" ";//弹出窗口的url
     var iWidth=600; //弹出窗口的宽度;
     var iHeight=400; //弹出窗口的高度;
     var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
     var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
     reshf = window.open(openUrl, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no,resizable=no,location=no, status=no');
     //for chrome
       if (!reshf) {
        reshf = window.reshf;
      } 
      //关闭子窗口后刷新父窗口
      if(reshf.closed){
        window.opener.location.reload();
        window.onunload = function(){window.opener.location.reload();} 
       }	
   }
     
        
   //分页
   function gotoPage(n){
	var num = 1;
	if(Util.ISEmpty(n)){
		alert("请输入页码！");
		return;
	}
	if(Util.ISInteger(n)){
		num=n;
		var totalPageNum = parseInt(${pageinfo.totalPageNum});
	    if(num>totalPageNum){
		   alert("当前已经是尾页");
		   return;
	    }else if(num<=0){
		   alert("当前已经是首页");
		   return;
	    }else{
	      frm.method="post";
	      frm.pagenum.value = num;
	      frm.submit();
	    }
	}else{
		alert("请输入正确的页码");
		return;
	}
	
	
}
/**
 * 鼠标回车事件
 */
  document.onkeydown=function keydown(e){  
       e = e||event;  
       if(e.keyCode == 13) {
          anotherpage();
       }   
       return;  
} 
//重置页数，页码
function anotherpage(){
    var num=$("#repagenum").val();
    var size=$("#repagesize").val();
    var pagenum;//重置页码
    var pagesize;//重置页数
    var totalpage = parseInt(${pageinfo.totalPageNum});//总页数
    var totalpagesize = parseInt(${pageinfo.totalPageSize});//总条数
    var oldpagenum =  parseInt(${pageinfo.pageNum });//原来的页码
    var oldpagesize =  parseInt(${pageinfo.pageSize });//原来的每页条数数
    //只有页码
    if(!Util.ISEmpty(num)&&Util.ISEmpty(size)){
	    if(Util.ISInteger(num)){
		   pagenum=num;
	    }else{
		  alert("请输入正确的页码");
		  return;
	    }
	  
	   if(num>totalpage){
		  pagenum = totalpage;
	    }
	    if(num<=0){
		pagenum=1;
	   }
     frm.method="post";
	 frm.pagenum.value = pagenum;
	 //frm.pagesize.value = size;
	 frm.submit();
	}//只有页数
	else if(Util.ISEmpty(num)&&!Util.ISEmpty(size)){
	   if(Util.ISInteger(size)&&size>0){
		   pagesize=size;		   
		 if(size>totalpagesize){
		  pagesize = totalpagesize;
		  frm.method="post";
	      frm.pagenum.value = 1;
	      frm.pagesize.value = pagesize;
	      frm.submit();
	     }else{	    
		   frm.method="post";
	       frm.pagenum.value = 1;
	       frm.pagesize.value = pagesize;
	       frm.submit();
	     }
	   }else{
		  alert("请输入正确的页数");
		  return;
	    }

	}//页码页数都有
	else if(!Util.ISEmpty(num)&&!Util.ISEmpty(size)){
	    var total = num*size;
	    if(total>totalpagesize&&num != oldpagenum){
	      frm.method="post";
	      frm.pagenum.value = 1;
	      frm.pagesize.value = oldpagesize;
	      frm.submit();
	    }else{
	      pagenum=num;
	      pagesize=size;
	      frm.method="post";
	      frm.pagenum.value = pagenum;
	      frm.pagesize.value = pagesize;
	      frm.submit();
	    }   
	 }else{//页码页数都没有
	  return;
	}
	
	 
	
}
function resetform(){
    $("#resetformdiv input[type=text]").val("");
    $("#seldepart").get(0).selectedIndex=0;//index为索引值
    $("#selgender").get(0).selectedIndex=0;//index为索引值
}

laydate({
  elem: '#timet .laydate-icon', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
  event: 'focus' //响应事件。如果没有传入event，则按照默认的click
});

  </script>
  </body>
</html>
