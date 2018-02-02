/**
 * �ı�˵�������ĵ������й��÷������Դ�д��ĸ��ͷ
 * LTrim(str) ���ַ���ȥ����ո�
 * RTrim(str) ���ַ���ȥ���ҿո�
 * Trim(str) ���ַ���ȥ�����߿ո��൱��str.trim();
 * ISEmpty(str) �ж��ַ����Ƿ�Ϊ�գ�Ϊ�շ���true����Ϊ�շ���false
 * ISInteger(num) �ж��Ƿ����������Ƿ���true�����Ƿ���false
 * ISFlote(num,n) �ж�num�Ƿ�Ϊ���nλС���ĸ��������Ƿ���true�����Ƿ���false
 * ISNumber(str) �ж��ַ����Ƿ���������ɣ��Ƿ���true�����Ƿ���false
 * ISDate(str) �ж��ַ����Ƿ����������ͣ��Ƿ���true�����Ƿ���false(������֮�������"-"��"/"�ָ�)
 * ISDateTime(str) �ж��ַ����Ƿ�������ʱ�����ͣ��Ƿ���true�����Ƿ���false(������֮�������"-"��"/"�ָʱ������":"�ָ�)
 * CompareDate(d1,d2) �ж�d1�Ƿ�С�ڵ���d2���Ƿ���true�����Ƿ���false(���d1��d2�����ڸ�ʽ���׳��쳣���� try{}catch(error){error.name,error.message}finally{}�������쳣)
 * ISCardID(sId) �Ƿ��ǺϷ����֤�ţ��Ƿ���true�����Ƿ���false
 * ISEmail(email) �Ƿ��ǺϷ����䣬�Ƿ���true�����Ƿ���false
 * ISPhone(phone) �Ƿ��ǺϷ��绰���룬�Ƿ���true�����Ƿ���false
 * HasNoSpecialStr(s,ch,vec) �ж��Ƿ񲻰��������ַ�������������true����������false(s��Ҫ��֤���ַ�����ch��true���ֲ��������ַ���false�����������ַ���vec�������������������ַ��е��ַ�)
 * RemoveComma(money) ������","���ʽ��޸�Ϊ��ֵ���ʽ���Ϣ
 * IncreaseComma(money) ����ֵ���ʽ���Ϣ����","
 * IFrameAuto(ifmid,autoHeight,autoWidth) ͨ��iframe��id��ʹ��iframe�߶ȡ��������Ӧ
 */
/**
 * ȥ�����ҿո�
 */
String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
};
var Util={
	/**
	 * ȥ����ո�
	 * @param str
	 * @return String
	 */
	LTrim:function (str){
		if(str){
			var i;
			for(i=0;i<str.length;i++){
				if(str.charAt(i)!=" "&&str.charAt(i)!="��")break;
			}
			str=str.substring(i,str.length);
		}
		return str;
	},
	/**
	 * ȥ���ҿո�
	 * @param str
	 * @return String
	 */
	RTrim:function (str){
		if(str){
			var i;
			for(i=str.length-1;i>=0;i--){
				if(str.charAt(i)!=" "&&str.charAt(i)!="��")break;
			}
			str=str.substring(0,i+1);
		}
		return str;
	},
	/**
	 * ȥ�����ҿո�
	 * @param str
	 * @return String
	 */
	Trim:function (str){
		return this.LTrim(this.RTrim(str));
	},
	/**
	 * �ж��Ƿ�Ϊ���ַ���
	 * @param str
	 * @return boolean
	 */
	ISEmpty:function (str){
		if(this.Trim(str+'').length<=0){
			return true;
		}
		return false;
	},
	/**
	 * �ж��Ƿ�������
	 * @param num
	 * @return boolean
	 */
	ISInteger:function (num){
		if(this.ISEmpty(num)){
			return true;
		}
		var patrn=/^([1-9]{1}[0-9]*|0)$/;
		if (patrn.exec(num)) {
			return true ;
		}
		return false ;
	},
	/**
	 * ��֤�������nΪС�������� num ҪУ����ַ�����n С��λ��
	 * @param num,n
	 * @return boolean
	 */
	ISFlote:function (num,n){
		if(this.ISEmpty(num)){
			return true;
		}
		if(!n){
			n=2;
		}
		if(!this.ISInteger(n)){
			return false;
		}else if(n<0){
			return false;
		}else if(n==0){
			return this.ISInteger(num);
		}
		//var matchs='\^\\+\?([1-9]{1}[0-9]\*|0)(\\.[0-9]{1,'+n+'})\?\$';
		var matchs='\^\\+\?([0-9]\*|0)(\\.[0-9]{1,'+n+'})\?\$';
		var patrn = new RegExp(matchs,"ig");
		if (patrn.exec(num)) {
			return true ;
		}
		return false;
	},
	/**
	 * �ж��ַ����Ƿ��������ַ����
	 * @param str
	 * @return boolean
	 */
	ISNumber:function (str){
		if(this.ISEmpty(str)){
			return true;
		}
		var patrn=/^\d*$/;
		if (patrn.exec(str)) {
			return true ;
		}
		return false ;
	},
	/**
	 * �ж��Ƿ�Ϊ��������
	 * @param str
	 * @return boolean
	 */
	ISDate:function (str){
		if(this.ISEmpty(str)){
			return true;
		}
		if(/^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(str)){
			var r = str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/); 
			if(r==null)return false; 
			var d= new Date(r[1], r[3]-1, r[4]); 
			return (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]);
		}else{
			return false;
		}
	},
	/**
	 * �Ƿ�������ʱ������
	 * @param str
	 * @return boolean
	 */
	ISDateTime:function (str){
		if(this.ISEmpty(str)){
			return true;
		}
		var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/; 
		var r = str.match(reg); 
		if(r==null) return false; 
		var d= new Date(r[1], r[3]-1,r[4],r[5],r[6],r[7]); 
		return (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]&&d.getHours()==r[5]&&d.getMinutes()==r[6]&&d.getSeconds()==r[7]);
	},
	/**
	 * ��֤d1�Ƿ�С�ڵ���d2
	 * @param d1,d2
	 * @return boolean
	 * @throw TypeException
	 */
	CompareDate:function (d1,d2) {
		if(this.ISEmpty(d1) || this.ISEmpty(d2)){
			return true;
		}
		if(!this.ISDate(d1) || !this.ISDate(d2)){
			throw new TypeError("���ڸ�ʽΪ yyyy-MM-dd �� yyyy/MM/dd");
		}
		return ((new Date(d1.replace(/-/g,"\/"))) <= (new Date(d2.replace(/-/g,"\/"))));   
	},
	/**
	 * �ж����֤�Ϸ�
	 * @param sId
	 * @return boolean
	 */
	aCity:{11:"����",12:"���",13:"�ӱ�",14:"ɽ��",15:"���ɹ�",21:"����",22:"����",23:"������",31:"�Ϻ�",32:"����",33:"�㽭",34:"����",35:"����",36:"����",37:"ɽ��",41:"����",42:"����",43:"����",44:"�㶫",45:"����",46:"����",50:"����",51:"�Ĵ�",52:"����",53:"����",54:"����",61:"����",62:"����",63:"�ຣ",64:"����",65:"�½�",71:"̨��",81:"���",82:"����",91:"����"}, 
	ISCardID:function (sId){
		var iSum=0 ;
		var info="" ;
		if(!/^\d{17}(\d|x)$/i.test(sId)) {
			return false;
		}//"����������֤���Ȼ��ʽ����"; 
		sId=sId.replace(/x$/i,"a"); 
		if(this.aCity[parseInt(sId.substr(0,2))]==null) {
			return false;
		}//"������֤�����Ƿ�"; 
		sBirthday=sId.substr(6,4)+"-"+Number(sId.substr(10,2))+"-"+Number(sId.substr(12,2)); 
		var d=new Date(sBirthday.replace(/-/g,"/")) ;
		if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate())){
			return false;
		}//"���֤�ϵĳ������ڷǷ�"; 
		for(var i = 17;i>=0;i --) iSum += (Math.pow(2,i) % 11) * parseInt(sId.charAt(17 - i),11) ;
		if(iSum%11!=1) {
			return false;
		}//"����������֤�ŷǷ�"; 
		return true;//aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(16,1)%2?"��":"Ů") 
	},
	/**
	 * ������֤
	 * var re = /^\w{1,15}(?:@(?!-))(?:(?:[a-z0-9-]*)(?:[a-z0-9](?!-))(?:\.(?!-)))+[a-z]{2,4}$/;
	 * @param email
	 * @return boolean
	 */
	ISEmail:function (email){
		if(this.ISEmpty(email)){
			return true;
		}
		var re = /^\w{1,64}(?:@(?!-))(?:(?:[a-z0-9-]*)(?:[a-z0-9](?!-))(?:\.(?!-)))+[a-z]{2,8}$/;
		if(!re.exec(email)){
			return false;
		}
		return true;
	},
	/**
	 * ��֤�绰����
	 * @param phone
	 * @return boolean
	 */
	ISPhone:function (phone){
		if(this.ISEmpty(phone)){
			return true;
		}
		var re = /^[0-9\-\,]*$/; ///^(1[3,5,8][0-9]{9}|[0-9]{7,8}|0[0-9]{2,3}\-[0-9]{7,8}(\-[0-9]{0-4})?)$/;
		return re.exec(phone)
	},
	/**
	 * �ж��Ƿ���������ַ�
	 * @param s ����֤���ַ���
	 * @param ch true���ֲ��������ַ�����false ���������ַ���
	 * @param vec �����ַ����飬�����������еĲ��������ַ�
	 * @return boolean
	 */
	HasNoSpecialStr:function (s,ch,vec){
		if(this.ISEmpty(s)){
			return true;
		}
		var china = "";
		var strs = "";
		if(ch){
			china = "\\u4e00-\\u9fa5";
		}
		if(vec){
			for(var i=0;i<vec.length;i++){
				strs += "|\\"+vec[i];
			}
		}
		var matchs='\^[0-9A-Za-z'+china+strs+']{1,}\$';
		var patrn = new RegExp(matchs,"ig");
		if (patrn.exec(s)) {
			return true ;
		}
		return false;
	},
	/**
	 * Ǯ��ȥ�����ţ�С��������Զ���ȫ
	 * @param money
	 * @return String
	 */
	RemoveComma:function (money){
		if(this.ISEmpty(money)){
			return "";
		}
		money=this.Trim(money);
		money  = money.replace(/,/gi,"");
		money  = money.replace(/��/gi,"");
		var after ="";
		if(money.indexOf(".")>0){
			after = money.substring(money.indexOf("."),money.length);
		}
		if(!after==""){
			if(after.length<2){
				money += "00";
			}else if(after.length==2){
				money += "0";
			}
		}else{
			money += ".00";
		}
		if(!this.ISFlote(money)){
			return "";
		}
		return money;
	},
	/**
	 * Ǯ,ǧ��λ��ʽ��
	 * @param money
	 * @return String
	 */
	IncreaseComma:function (money){
		var begin ="";
		var begin2="";
		var after =".00";
		var n = 2;
		if(!money){
			money = "";
		}
		money = this.Trim(money);
		if(money.indexOf(".")<0){
			begin = money;
		}else{
			begin = money.substring(0,money.indexOf("."));
			after = money.substring(money.indexOf("."),money.length);
		}
		if(this.Trim(begin).length<=0){
			begin="0";
		}
		if(after.length<n+1){
			for(i=n+1;i>after.length;){
				after+="0";
			}
		}
		after = after.substring(0,n+1);
		if(!this.ISFlote(begin+after,n)){
			return "";
		}
		while(begin.length>3){
			begin2 = ","+begin.substring(begin.length-3,begin.length)+begin2;
			begin=begin.substring(0,begin.length-3);
		}
		return begin+begin2+after;
	},
	/**
	 * ����iframe����Ӧ
	 * @param ifmid
	 * @param autoHeight
	 * @param autoWidth
	 * @param addHeight
	 */
	IFrameAuto:function (ifmid,autoHeight,autoWidth,addHeight){
		var h = 14;
		var minheight=563;
		var ifm= document.getElementById(ifmid);
		if(ifm != null) {
			if(autoHeight){
				ifm.height=0;//��ֹ��߶����������߶ȣ�����ÿ�ζ��Ƚ��߶�����
				if(!addHeight)addHeight=0;
				if(ifm.contentWindow.document.documentElement.scrollHeight<minheight){
					ifm.height=minheight+h+addHeight;
				}else{
					ifm.height=ifm.contentWindow.document.documentElement.scrollHeight+h+addHeight;
				}
			}
			if(autoWidth){
				ifm.width = subWeb.body.scrollWidth;
			}
		}
	},
	/**
	 * encodeת��
	 * @param str
	 * @return string
	 */
	Encode:function (str){
		return encodeURI(str,"utf-8");
	},
	/**
	 * ��ԭ encode
	 * @param str
	 * @return string
	 */
	Decode:function (str){
		return decodeURI(str,"utf-8");
	},
	getString:function(a,d){
		if(!typeof d=="object"&&!d.length){
			return;
		}
		var e,c;
		for(var b=0;b<d.length;b++){
			c=new RegExp("\\{"+b+"\\}");//��ʽΪ{n}
			e=e?e.replace(c,d[b]):a.replace(c,d[b]);//���e��Ϊ����e��{n}�滻Ϊd�ĵ�n��Ԫ�ط���eΪa��{n}�滻Ϊd�ĵ�n��Ԫ��
		}
		return e;
	}
}