<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String jspPath = basePath;
request.setAttribute("jspPath", jspPath);
request.setAttribute("basePath", basePath);
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
     <label>����</label>&nbsp;&nbsp;<input type="text" name="username" value="${pageinfo.username}"/>
     &nbsp;&nbsp; <label>�Ա�</label>&nbsp;&nbsp;
       <select name="gender" id="selgender">
                         <option id="allman" value="">����</option>
                         <option id="man" value="��">��</option>
                         <option id="woman" value="Ů">Ů</option>
       </select>
     &nbsp;&nbsp;<label>����</label>&nbsp;&nbsp;<input type="text" name="interest" value="${pageinfo.interest}"/>
   </div>
   <div style="width:560px;margin:0 auto;margin-top:20px;" id="timet">
     <label>����</label>&nbsp;&nbsp;
     <select name="departno" id="seldepart">
     <option value="">ȫ��</option>
     <option value="1">�з���</option>
     <option value="2">���Բ�</option>
     <option value="3">���ɲ�</option>
     <option value="4">���粿</option>
     <option value="5">���²�</option>
     </select>
     &nbsp;&nbsp;<label>��ְʱ��</label>&nbsp;&nbsp;
     <input type="text" name="fromtime" class="laydate-icon" value="${pageinfo.fromtime}"/>
     <label>һ</label>
     <input type="text" class="laydate-icon" name="totime"  value="${pageinfo.totime}"/>
   </div>
   <div style="width:200px;margin:0 auto;margin-top:20px;margin-bottom:20px;">
      <input type="button" id="search" value="��ѯ"/>
      <input type="button" value="����" onclick="resetform()"/>
      <input type="button" onclick="toAdduser(1);"value="���Ա��"/>
   </div>
   </div>
   <div style="width:810px;min-width:810px;margin:0 auto;">
   <table style="width:100%;" border="1">
     <tr style="background:#ccc;">
       <td style="width:100px;">����</td>
       <td style="width:50px;">�Ա�</td>
       <td style="width:200px;">����</td>      
       <td style="width:100px;">����</td>
       <td style="width:100px;">��ְʱ��</td>
       <td style="width:50px;">����</td>
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
									<td><a href="javascript:void(0)" onclick="toModifyUser(${us.userId})">�༭</a></td>
								</tr>
		</c:forEach>	
	  <tr>
	  <td  colspan="6" style="text-align:center;">
	    <input type="hidden" id="pageNo" name="pagenum" value="${pageinfo.pageNum }"/>
        <input type="hidden" id="pageSize" name="pagesize" value="${pageinfo.pageSize }"/>
	    <input type="button" onclick="gotoPage(1)" value="��ҳ"/>
		<input type="button" onclick="gotoPage(${pageinfo.pageNum-1})" value="��һҳ"/>
		<input type="button" onclick="gotoPage(${pageinfo.pageNum+1})" value="��һҳ"/>
		<input type="button" onclick="gotoPage(${pageinfo.totalPageNum})" value="βҳ"/>
	         ��ǰ��<input name="pageNum--" value="${pageinfo.pageNum}" id="repagenum" style="width:30px;" type="text" onkeydown="function keydown(e){e = e||event;  if(e.keyCode == 13) {gotoPage($(this).val());}return;}"/>
	         ҳ/��<span>${pageinfo.totalPageNum}</span>ҳ
	         ÿҳ��ʾ<input name="pageSize--" value="${pageinfo.pageSize}" id="repagesize" style="width:30px;" type="text"/>������<span>${pageinfo.totalPageSize}</span>��
	  </td>
	  </tr>	
   </table>
   </div>
  </form>
  <script type="text/javascript">
    var reshf;//�򿪴��ڷ���ֵ�����ڹرմ���ʱˢ�¸�ҳ��
    jQuery(document).ready(function(){
       //�Ա�
       var gender = '${pageinfo.gender}';
       if(gender=='��'){
         $("#man").attr("selected","selected");
       }else if(gender=='Ů'){
         $("#woman").attr("selected","selected");
       }else{
         $("#allman").attr("selected","selected");
       }
       //ѡ�в���
       var departno = '${pageinfo.departno}';
       var index = departno;
       $("#seldepart").get(0).selectedIndex=index;//indexΪ����ֵ
	   $("#search").click(function(){	
	              frm.method="post";
	              frm.pagenum.value = 1;
	              frm.submit();		
				 // $("#frm").submit();
			});			
	});
    //��Ӵ���
    function toAdduser(){
     var openUrl = "${jspPath}jsp/addUser.jsp";//�������ڵ�url
     var iWidth=600; //�������ڵĿ��;
     var iHeight=400; //�������ڵĸ߶�;
     var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
     var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
     reshf = window.open(openUrl, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no,resizable=no,location=no, status=no');
     //for chrome
      if (!reshf) {
        reshf = window.reshf;
      }
       //�ر��Ӵ��ں�ˢ�¸�����
      if(reshf.closed){
        window.opener.location.reload();
        window.onunload = function(){window.opener.location.reload();} 
       }	
   }
    //�޸Ĵ���
    function toModifyUser(id){
     var openUrl = "user/toModifyUser.do?userid="+id+" ";//�������ڵ�url
     var iWidth=600; //�������ڵĿ��;
     var iHeight=400; //�������ڵĸ߶�;
     var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
     var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
     reshf = window.open(openUrl, 'newwindow', 'height='+iHeight+', width='+iWidth+', top='+iTop+', left='+iLeft+', toolbar=no, menubar=no, scrollbars=no,resizable=no,location=no, status=no');
     //for chrome
       if (!reshf) {
        reshf = window.reshf;
      } 
      //�ر��Ӵ��ں�ˢ�¸�����
      if(reshf.closed){
        window.opener.location.reload();
        window.onunload = function(){window.opener.location.reload();} 
       }	
   }
     
        
   //��ҳ
   function gotoPage(n){
	var num = 1;
	if(Util.ISEmpty(n)){
		alert("������ҳ�룡");
		return;
	}
	if(Util.ISInteger(n)){
		num=n;
		var totalPageNum = parseInt(${pageinfo.totalPageNum});
	    if(num>totalPageNum){
		   alert("��ǰ�Ѿ���βҳ");
		   return;
	    }else if(num<=0){
		   alert("��ǰ�Ѿ�����ҳ");
		   return;
	    }else{
	      frm.method="post";
	      frm.pagenum.value = num;
	      frm.submit();
	    }
	}else{
		alert("��������ȷ��ҳ��");
		return;
	}
	
	
}
/**
 * ���س��¼�
 */
  document.onkeydown=function keydown(e){  
       e = e||event;  
       if(e.keyCode == 13) {
          anotherpage();
       }   
       return;  
} 
//����ҳ����ҳ��
function anotherpage(){
    var num=$("#repagenum").val();
    var size=$("#repagesize").val();
    var pagenum;//����ҳ��
    var pagesize;//����ҳ��
    var totalpage = parseInt(${pageinfo.totalPageNum});//��ҳ��
    var totalpagesize = parseInt(${pageinfo.totalPageSize});//������
    var oldpagenum =  parseInt(${pageinfo.pageNum });//ԭ����ҳ��
    var oldpagesize =  parseInt(${pageinfo.pageSize });//ԭ����ÿҳ������
    //ֻ��ҳ��
    if(!Util.ISEmpty(num)&&Util.ISEmpty(size)){
	    if(Util.ISInteger(num)){
		   pagenum=num;
	    }else{
		  alert("��������ȷ��ҳ��");
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
	}//ֻ��ҳ��
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
		  alert("��������ȷ��ҳ��");
		  return;
	    }

	}//ҳ��ҳ������
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
	 }else{//ҳ��ҳ����û��
	  return;
	}
	
	 
	
}
function resetform(){
    $("#resetformdiv input[type=text]").val("");
    $("#seldepart").get(0).selectedIndex=0;//indexΪ����ֵ
    $("#selgender").get(0).selectedIndex=0;//indexΪ����ֵ
}

laydate({
  elem: '#timet .laydate-icon', //Ŀ��Ԫ�ء�����laydate.js��װ��һ����������ѡ�������棬���elem�������㴫��class��tag�����밴�����ַ�ʽ '#id .class'
  event: 'focus' //��Ӧ�¼������û�д���event������Ĭ�ϵ�click
});

  </script>
  </body>
</html>
