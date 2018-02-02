<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%//在EL表达式中是获取不到 list 集合的长度的，引用本标签可以用以下方式获取返回集合的长度：${fn:length(list)}%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%//格式化用到的标签：<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm:ss"/> %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>"> 
    <base target="_self"/> 
    <title>add</title>
    
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
  </head>
  
  <body>
   <div style="width:550px;margin:0 auto;margin-top:50px;">
   <form action="user/addUser.do" method="post" >
     <input type="hidden" name="user.userId" value="0"/>
   <table>
    <tr>
     <td>姓名</td>
     <td><input type="text" name="userName" id="userid"/></td>
    </tr>
     <tr>
     <td>性别</td>
     <td>
       <input type="radio" name="user.gender" value="男"/>男
       <input type="radio" name="user.gender" value="女"/>女
     </td>
    </tr>
     <tr>
     <td>爱好</td>
     <td>
      <input type="checkbox" class="interest" id="checkAll" />全选
      <input type="checkbox" class="interest" name="user.interest" value="篮球"/>篮球
      <input type="checkbox" class="interest" name="user.interest" value="游戏"/>游戏
      <input type="checkbox" class="interest" name="user.interest" value="游泳"/>游泳
      <input type="checkbox" class="interest" name="user.interest" value="唱歌"/>唱歌
     </td>
    </tr>
     <tr>
     <td>入职时间</td>
     <td><div id="timet"><input type="text" name="user.intime" class="laydate-icon"/></div></td>
    </tr>
     <tr>
     <td>部门</td>
     <td>
        <select name="user.depart.departno">
           <option value="1">研发部</option>
           <option value="2">测试部</option>
           <option value="3">集成部</option>
           <option value="4">网络部</option>
           <option value="5">人事部</option>
        </select>
     </td>
    </tr>   
   </table>
   <div style="width:130px;text-align:center;margin:0 auto;margin-top:50px;">      
         <div style="float:left"><input type="submit" value="保存"/></div>
         <div style="float:left;margin-left:10px;"><input type="button" value="关闭" onclick="closewin();"/></div>
         <div style="clear:both"></div>
    </div>
   </form>
   </div>
   <script type="text/javascript">
     var isSuccess = "${isSuccess}";//用于判断是否添加成功
     if(isSuccess=='yes'){//成功
       window.opener.document.getElementById("frm").submit();      
       alert("添加成功");
       window.close();    
     }else if(isSuccess=='no'){//失败
       alert("添加失败");
     }
     //关闭窗口
     function closewin(){   
      window.opener = null;
      window.open('','_self');
      window.close();
     }
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
 //日期插件
 laydate({
  elem: '#timet .laydate-icon', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
  event: 'focus' //响应事件。如果没有传入event，则按照默认的click
});
   </script>
  </body>
</html>
