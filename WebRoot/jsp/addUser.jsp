<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%//��EL���ʽ���ǻ�ȡ���� list ���ϵĳ��ȵģ����ñ���ǩ���������·�ʽ��ȡ���ؼ��ϵĳ��ȣ�${fn:length(list)}%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%//��ʽ���õ��ı�ǩ��<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm:ss"/> %>
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
     <td>����</td>
     <td><input type="text" name="userName" id="userid"/></td>
    </tr>
     <tr>
     <td>�Ա�</td>
     <td>
       <input type="radio" name="user.gender" value="��"/>��
       <input type="radio" name="user.gender" value="Ů"/>Ů
     </td>
    </tr>
     <tr>
     <td>����</td>
     <td>
      <input type="checkbox" class="interest" id="checkAll" />ȫѡ
      <input type="checkbox" class="interest" name="user.interest" value="����"/>����
      <input type="checkbox" class="interest" name="user.interest" value="��Ϸ"/>��Ϸ
      <input type="checkbox" class="interest" name="user.interest" value="��Ӿ"/>��Ӿ
      <input type="checkbox" class="interest" name="user.interest" value="����"/>����
     </td>
    </tr>
     <tr>
     <td>��ְʱ��</td>
     <td><div id="timet"><input type="text" name="user.intime" class="laydate-icon"/></div></td>
    </tr>
     <tr>
     <td>����</td>
     <td>
        <select name="user.depart.departno">
           <option value="1">�з���</option>
           <option value="2">���Բ�</option>
           <option value="3">���ɲ�</option>
           <option value="4">���粿</option>
           <option value="5">���²�</option>
        </select>
     </td>
    </tr>   
   </table>
   <div style="width:130px;text-align:center;margin:0 auto;margin-top:50px;">      
         <div style="float:left"><input type="submit" value="����"/></div>
         <div style="float:left;margin-left:10px;"><input type="button" value="�ر�" onclick="closewin();"/></div>
         <div style="clear:both"></div>
    </div>
   </form>
   </div>
   <script type="text/javascript">
     var isSuccess = "${isSuccess}";//�����ж��Ƿ���ӳɹ�
     if(isSuccess=='yes'){//�ɹ�
       window.opener.document.getElementById("frm").submit();      
       alert("��ӳɹ�");
       window.close();    
     }else if(isSuccess=='no'){//ʧ��
       alert("���ʧ��");
     }
     //�رմ���
     function closewin(){   
      window.opener = null;
      window.open('','_self');
      window.close();
     }
     //ȫѡ
     $(function() {
           $("#checkAll").click(function() {
                $('input[name="user.interest"]').attr("checked",this.checked); 
            });
            var $subBox = $("input[name='user.interest']");
            $subBox.click(function(){
                $("#checkAll").attr("checked",$subBox.length == $("input[name='user.interest']:checked").length ? true : false);
           });
     });
 //���ڲ��
 laydate({
  elem: '#timet .laydate-icon', //Ŀ��Ԫ�ء�����laydate.js��װ��һ����������ѡ�������棬���elem�������㴫��class��tag�����밴�����ַ�ʽ '#id .class'
  event: 'focus' //��Ӧ�¼������û�д���event������Ĭ�ϵ�click
});
   </script>
  </body>
</html>
