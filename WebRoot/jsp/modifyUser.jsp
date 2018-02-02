<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    <base target="_self"> 
    <title>modify</title>   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="js/tool.js"></script>
	<script type="text/javascript" src="laydate/laydate.js"></script>
	<style type="text/css">
	    .floatL{
	     float:left;
	     margin-left:10px;
	    }
	    .clearfl{
	     clear:both;
	    }
	</style>
  </head>
  
  <body>
   <div style="width:550px;margin:0 auto;">
   <form id="frm" action="user/modifyUser.do" method="post">
    <input type="hidden" name="user.userId" value="${user.userId}">
   <table>
    <tr>
     <td>姓名</td>
     <td><input type="text" name="user.userName" value="${user.userName}"/></td>
    </tr>
     <tr>
     <td>性别</td>
     <td>
       <input type="radio" id="man" name="user.gender" value="男" />男
       <input type="radio" id="woman" name="user.gender" value="女" />女
     </td>
    </tr>
     <tr>
     <td>爱好</td>
     <td>
      <input type="checkbox" id="checkAll" class="interest"/>全选
      <input type="checkbox" name="user.interest" class="interest" value="篮球" />篮球
      <input type="checkbox" name="user.interest" class="interest" value="游戏" />游戏
      <input type="checkbox" name="user.interest" class="interest" value="游泳" />游泳
      <input type="checkbox" name="user.interest" class="interest" value="唱歌"/>唱歌
     </td>
    </tr>
     <tr>
     <td>入职时间</td>
     <td><div id="timeplug">
     <input type="text" name="user.intime" value="<fmt:formatDate value="${user.intime}" pattern="yyyy-MM-dd"/>" class="laydate-icon"/>
     
     </div>
     </td>
    </tr>
     <tr>
     <td>部门</td>
     <td>
        <select id="seldepart" name="user.depart.departno">
           <option value="1">研发部</option>
           <option value="2">测试部</option>
           <option value="3">集成部</option>
           <option value="4">网络部</option>
           <option value="5">人事部</option>
        </select>
     </td>
    </tr>   
   </table>
    <div style="width:200px;text-align:center;margin:0 auto;margin-top:50px;">      
          <div class="floatL"><input  type="submit" value="保存"/></div>
          <div class="floatL"><input  type="button" value="删除" onclick="deluser(${userid});"/></div>
          <div class="floatL"><input  type="button" value="关闭" onclick="closewin();"/></div>
          <div class="clearfl"></div>
    </div>
   </form>
  
   </div>
   <script type="text/javascript">
    //全选
     $(function() {
           $("#checkAll").click(function() {
                $('input[name="user.interest"]').attr("checked",this.checked); 
            });
            var $subBox = $("input[name='user.interest']");
            $subBox.click(function(){
                $("#checkAll").attr("checked",$subBox.length == $("input[name='user.interest']:checked").length ? true : false);
           });
     });
     var isSuccess = "${isSuccess}";//用于判断是否修改成功
    
     if(isSuccess=='yes'){//成功                  
       window.opener.document.getElementById("frm").submit();      
       alert("操作成功");
       window.close();        
      //  closewin();     
     }else if(isSuccess=='no'){//失败
       alert("操作失败");
     }
     //关闭窗口
     function closewin(){   
       window.opener = null;
       window.open('','_self');
       window.close();   
     }   
     //删除员工
     function deluser(userid){
       frm.method="post";
       frm.action="delUser.do";
	   frm.submit();   
     }
     //日期插件
   laydate({
      elem: '#timeplug .laydate-icon', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
      event: 'focus' //响应事件。如果没有传入event，则按照默认的click
   });
   
    $(function(){
       //选中性别
       var gender = '${user.gender}';
       if(gender=='男'){
         $("#man").attr("checked","checked");
       }else if(gender=='女'){
         $("#woman").attr("checked","checked");
       }
       //选中部门
       var departno = '${user.depart.departno}';
       var index = departno-1;
       $("#seldepart").get(0).selectedIndex=index;//index为索引值
       //选中爱好
     
       var interests = new Array();//接收后台传入
       <c:forEach items="${interests}" var="item" varStatus="status">  
          interests.push("${item}");  
       </c:forEach> 

       var checkboxs=$("input[type=checkbox]"); 
       //将全选按钮选中
       if((checkboxs.length-1)==interests.length){
           $("#checkAll").attr("checked",true);
       }     
       for(var i=0;i<checkboxs.length;i++){
           for(var j=0;j<interests.length;j++){
             if(checkboxs[i].value==interests[j]){           
                checkboxs[i].checked=true;
             }
           }
       }
     });
   //刷新父窗口
  //   window.onunload = function(){window.opener.location.reload();}   
   </script>
  </body>
</html>
