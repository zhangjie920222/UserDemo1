<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%//��EL���ʽ���ǻ�ȡ���� list ���ϵĳ��ȵģ����ñ���ǩ���������·�ʽ��ȡ���ؼ��ϵĳ��ȣ�${fn:length(list)}%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%//��ʽ���õ��ı�ǩ��<fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm:ss"/> %>
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
     <td>����</td>
     <td><input type="text" name="user.userName" value="${user.userName}"/></td>
    </tr>
     <tr>
     <td>�Ա�</td>
     <td>
       <input type="radio" id="man" name="user.gender" value="��" />��
       <input type="radio" id="woman" name="user.gender" value="Ů" />Ů
     </td>
    </tr>
     <tr>
     <td>����</td>
     <td>
      <input type="checkbox" id="checkAll" class="interest"/>ȫѡ
      <input type="checkbox" name="user.interest" class="interest" value="����" />����
      <input type="checkbox" name="user.interest" class="interest" value="��Ϸ" />��Ϸ
      <input type="checkbox" name="user.interest" class="interest" value="��Ӿ" />��Ӿ
      <input type="checkbox" name="user.interest" class="interest" value="����"/>����
     </td>
    </tr>
     <tr>
     <td>��ְʱ��</td>
     <td><div id="timeplug">
     <input type="text" name="user.intime" value="<fmt:formatDate value="${user.intime}" pattern="yyyy-MM-dd"/>" class="laydate-icon"/>
     
     </div>
     </td>
    </tr>
     <tr>
     <td>����</td>
     <td>
        <select id="seldepart" name="user.depart.departno">
           <option value="1">�з���</option>
           <option value="2">���Բ�</option>
           <option value="3">���ɲ�</option>
           <option value="4">���粿</option>
           <option value="5">���²�</option>
        </select>
     </td>
    </tr>   
   </table>
    <div style="width:200px;text-align:center;margin:0 auto;margin-top:50px;">      
          <div class="floatL"><input  type="submit" value="����"/></div>
          <div class="floatL"><input  type="button" value="ɾ��" onclick="deluser(${userid});"/></div>
          <div class="floatL"><input  type="button" value="�ر�" onclick="closewin();"/></div>
          <div class="clearfl"></div>
    </div>
   </form>
  
   </div>
   <script type="text/javascript">
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
     var isSuccess = "${isSuccess}";//�����ж��Ƿ��޸ĳɹ�
    
     if(isSuccess=='yes'){//�ɹ�                  
       window.opener.document.getElementById("frm").submit();      
       alert("�����ɹ�");
       window.close();        
      //  closewin();     
     }else if(isSuccess=='no'){//ʧ��
       alert("����ʧ��");
     }
     //�رմ���
     function closewin(){   
       window.opener = null;
       window.open('','_self');
       window.close();   
     }   
     //ɾ��Ա��
     function deluser(userid){
       frm.method="post";
       frm.action="delUser.do";
	   frm.submit();   
     }
     //���ڲ��
   laydate({
      elem: '#timeplug .laydate-icon', //Ŀ��Ԫ�ء�����laydate.js��װ��һ����������ѡ�������棬���elem�������㴫��class��tag�����밴�����ַ�ʽ '#id .class'
      event: 'focus' //��Ӧ�¼������û�д���event������Ĭ�ϵ�click
   });
   
    $(function(){
       //ѡ���Ա�
       var gender = '${user.gender}';
       if(gender=='��'){
         $("#man").attr("checked","checked");
       }else if(gender=='Ů'){
         $("#woman").attr("checked","checked");
       }
       //ѡ�в���
       var departno = '${user.depart.departno}';
       var index = departno-1;
       $("#seldepart").get(0).selectedIndex=index;//indexΪ����ֵ
       //ѡ�а���
     
       var interests = new Array();//���պ�̨����
       <c:forEach items="${interests}" var="item" varStatus="status">  
          interests.push("${item}");  
       </c:forEach> 

       var checkboxs=$("input[type=checkbox]"); 
       //��ȫѡ��ťѡ��
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
   //ˢ�¸�����
  //   window.onunload = function(){window.opener.location.reload();}   
   </script>
  </body>
</html>
