<%@page import="cn.com.mmsweb.action.util.SessionUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ include file="../common/jsp/head.jsp" %>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>沃爱彩信</title>
<meta name="keywords" content="沃爱彩信" />
<meta name="description" content="沃爱彩信" />
<style>
.gallery li img {
	width: 100%;
	cursor: hand;
}
body{text-align:center;width:100%;}  
#wrap{ 
 text-align:left;  
 width:560px;  
 margin:0 auto;  
 border:1px solid #333;  
/*  background-color:#ccc;  */
}

</style>
<script>
	var pageNow = 1;		//当前第几页
	var	maxPages = 0;		//总页数
	var picType = 1;		//图片类型(呼朋唤友，节日祝福，生日祝福)
	var whichPic = "xxkul";		//哪一个图片品种
	
	function setContent(str) {
		str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
		str.value = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
		//str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
		return str;
		}

	function ajaxFileUpload()
	{
	  var picfile=$("#file").val();
	  if(picfile=="")
		  {
		   alert("请选择您要上传的图片！");
		  }
	  else{
	         if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(picfile)){
	        	 alert("只能上传.jpg  .png  .jpeg 类型的文件!"); 
	         }else{  
	  $("#loading") .ajaxStart(function(){
	        $(this).show();
	    }).ajaxComplete(function(){
	        $(this).hide();
	    });//文件上传完成将图片隐藏起来 
	   // alert($('#roleCombobox1').combobox('getValue'));
	     $.ajaxFileUpload({
	            url:ctxPath+"/photoFileup!fileupPhoto.action",//用于文件上传的服务器端请求地址
	            secureuri:false,//一般设置为false
	            fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
	            dataType: 'json',//返回值类型 一般设置为json
	           // data:{"sysUserWhite.userId":$('#roleCombobox1').combobox('getValue')},
	            success: function (data,status)  {
	            //	var data=eval('('+ setContent(data) +')');
	            	if(data.msg=="ok") {
	            		queryPicTure($("#paramType").val());
	            		alert("上传成功！");
	            	}else if(data.msg=="error"){
	            		alert("上传失败！");
	            	}else if(data.msg=="login")
	            		{
	            		alert("请先登录！");
	            		}
	            },
	           error: function (data, status, e){
	               alert(e);
	           }
	        }
	    );/* */
	  }
	  }
	}

	var pointImge = "";	//选择的图片divID
	var whatsTypes = true;	//正着走还是反着走 true：正着走；false：反着走
	function rightNowDivID(paramsduii) {
		pointImge = paramsduii;
	}
	var ishus = 0;//饰品图片的初始角度
	var Img = function() {
	    var Tde = function(id) { return document.getElementById(id); }
	    var ua = navigator.userAgent,
	        isIE = /msie/i.test(ua) && !window.opera;
	    var i = 0, sinDeg = 0, cosDeg = 0, timer = null ;

	    var rotate = function(target, degree) {
	        target = Tde(target);
	        var orginW = target.clientWidth, orginH = target.clientHeight;
	            clearInterval(timer);
	            i = ishus;
	        function run(angle) {
	            if (isIE) { // IE
	                cosDeg = Math.cos(angle * Math.PI / 180);
	                sinDeg = Math.sin(angle * Math.PI / 180);
	                with(target.filters.item(0)) {
	                    M11 = M22 = cosDeg; M12 = -(M21 = sinDeg); 
	                }
	                target.style.top = (orginH - target.offsetHeight) / 2 + 'px';
	                target.style.left = (orginW - target.offsetWidth) / 2 + 'px';
	            } else if (target.style.MozTransform !== undefined) {  // Mozilla
	                target.style.MozTransform = 'rotate(' + angle + 'deg)';
	            } else if (target.style.OTransform !== undefined) {   // Opera
	                target.style.OTransform = 'rotate(' + angle + 'deg)';
	            } else if (target.style.webkitTransform !== undefined) { // Chrome Safari
	                target.style.webkitTransform = 'rotate(' + angle + 'deg)';
	            } else {
	                target.style.transform = "rotate(" + angle + "deg)";
	            }
	        }

	        timer = setInterval(function() {
	        	run(i);
				if (i > degree - 1) {
					i = 0;
					clearInterval(timer);
				} 
			    i = (i*1)+1;
	        }, 10); 
	    }
	    return {rotate: rotate}
	}();

	var Img2 = function() {
		var Tde = function(id) {
			return document.getElementById(id);
		}
		var ua = navigator.userAgent, isIE = /msie/i.test(ua) && !window.opera;
		var i = 0, sinDeg = 0, cosDeg = 0, timer = null;

		var rotate = function(target, degree) {
			target = Tde(target);
			var orginW = target.clientWidth, orginH = target.clientHeight;
			clearInterval(timer);
			i = ishus;
			function run(angle) {
				if (isIE) { // IE
					cosDeg = Math.cos(angle * Math.PI / 180);
					sinDeg = Math.sin(angle * Math.PI / 180);
					with (target.filters.item(0)) {
						M11 = M22 = cosDeg;
						M12 = -(M21 = sinDeg);
					}
					target.style.top = (orginH - target.offsetHeight) / 2
							+ 'px';
					target.style.left = (orginW - target.offsetWidth) / 2
							+ 'px';
				} else if (target.style.MozTransform !== undefined) { // Mozilla
					target.style.MozTransform = 'rotate(' + angle + 'deg)';
				} else if (target.style.OTransform !== undefined) { // Opera
					target.style.OTransform = 'rotate(' + angle + 'deg)';
				} else if (target.style.webkitTransform !== undefined) { // Chrome Safari
					target.style.webkitTransform = 'rotate(' + angle + 'deg)';
				} else {
					target.style.transform = "rotate(" + angle + "deg)";
				}
			}

			timer = setInterval(function() {
				run(i);
				if (i < 1 - degree) {
					i = 0;
					clearInterval(timer);
				}
				i = (i * 1) - 1;
			}, 10);
		}
		return {
			rotate : rotate
		}
	}();
</script>
<script type="text/javascript" src="view/diyPostcard_view.js"></script>
<script type="text/javascript" src="controller/diyPostcard_controller.js"></script>
<script type="text/javascript" src="../userManager/controller/userManager_controller.js"></script>

</head>

<body>
	<div class="wrap">
<!-- 	Header begin -->
		<jsp:include page="../top.jsp" />
<!--	Header end -->
		<div class="menu" >
			<ul>
				<li><a href="<%=path%>/weclome.jsp">模版明信片</a></li>
				<li class="on"><a href="<%=path%>/diyPostcard/diyPostcard.jsp">DIY明信片</a></li>
				<li><a href="<%=path%>/gifPostcard/gifPostcard.jsp">动态明信片</a></li>
			</ul>
			<i></i>
		</div>
<!-- 		登陆 begin -->
		<jsp:include page="../login.jsp" />
<!-- 		登陆 end -->
	
	<div class="mainbox">
		<div class="left640">
			<div class="diy-top">
				<span>收件人：</span>
					<input type="text" id="shoujianren" name="sjr" />
									<input type="hidden" id="addressee" />
				<button type="button" title="添加" onclick="loadContract();"></button>
			</div>
<!-- 			<input id="kele" value="come on" style="width: 470px;margin-top: 3px;"/> 可填写多个收件人，每个人收到的是单独发送的明信片。-->
			<div class="diy-tips" align="left">可填写多个收件人手机号码，以“;”间隔。<br><div id="slider-range-min" style="width: 361px;float: left;margin-top: 0px;margin-bottom: 5px; display: none;"></div></div>
			<div class="diy-imgbox" id="postcardarea" >
				<!-- 明信片start -->
<!-- 				class=defaultsize -->
				<div style="MARGIN: 0px 0px 0px 0px; WIDTH: 615px; HEIGHT: 460px; COLOR: #000" id=layerPhoto align="left" class=defaultsize>
					<img  id="img2" src="" style="width: auto;display: none;"/>
<!-- 		style=" WIDTH: 615px; HEIGHT: 460px"			MARGIN: -93px 0px 0px; -->
				</div>
				<div style="MARGIN: 0px 0px 0px 0px; WIDTH: 615px; HEIGHT: 460px; COLOR: #000" id=layerPhoto1 class=defaultsize >
					<img style=" WIDTH: 615px; HEIGHT: 460px;display: none;" id="img123" src="" />
				</div>				
				<div style="MARGIN: 37px 0px 0px 38px; WIDTH: 78px; BACKGROUND: url() no-repeat; HEIGHT: 88px; COLOR: #000" id=layerStamp >
					<img id="layerStamp1" src="" style="width: 100%;height: 100%; display: none;"/>
				</div>
					<%
						for(int i = 1 ; i <= 200; i++){
					%>
<!-- title="11120" .xuanze { cursor:pointer; position:absolute;filter:progid:DXImageTransform.Microsoft.Matrix(sizingmethod="auto expand");}-->
					<div align="right" style="MARGIN-TOP: 153px;cursor: move; WIDTH: 60px; HEIGHT: 60px; MARGIN-LEFT: 42px; display:none;position:absolute;filter:progid:DXImageTransform.Microsoft.Matrix(sizingmethod='auto expand');"
					id=divCenter<%=i%> class=flash ><a href="javascript:void(0);" onclick="del('divCenter<%=i%>')">X</a>
<%-- 						<img id="shipin<%=i%>" name='wolegeca' onclick="rightNowDivID('<%=i%>');" style="position:absolute;left:0px;top:0px;width:100%;height:100%;z-Index:-1;" src=""/> --%>
<%-- 						<input id="impeus<%=i%>" value='0' style="display: none;"/> --%>
					</div>
					<%
						}
					%>
				
				<div style="MARGIN: 58px 0px 0px 70px; WIDTH: 83px; BACKGROUND: url() no-repeat; HEIGHT: 82px; COLOR: #000"
					id=layerPostmark ><img id="layerPostmark1" src="" style="width: 100%;height: 100%; display: none;"/></div>
				<div title="请输入祝福语哟" align="left" style="MARGIN-TOP: 153px;cursor: move; WIDTH: 220px; HEIGHT: 120px; MARGIN-LEFT: 42px; display:none;"
				id="layerText1" class=flash>
					<a id="zfy" href="javascript:void(0);">留下你祝福的话语:</a>
				</div>
				<div style=" VISIBILITY: hidden; " id=layerMover onmouseover="jinyongscroll();" onmouseout="qiyongscroll();" align="left">
<!-- 		WIDTH: 615px; HEIGHT: 460px;		MARGIN: 60px 0px 0px 42px; -->
					<img style="display: none;MARGIN: 0px; width: auto; cursor: move;" id="img1" src="" />
				</div>
				<!-- range start -->
				<div style="MARGIN-TOP: 0px; WIDTH: 615px; HEIGHT: 460px;VISIBILITY: hidden;MARGIN-LEFT: 0px"
					id=rangePhoto class=flash></div>
				<div style="MARGIN-TOP: 37px; WIDTH: 78px; HEIGHT: 88px;VISIBILITY: hidden; MARGIN-LEFT: 38px; CURSOR: pointer"
					id=rangeStamp class=flash title=点击更换邮票 ></div>
				<div style="MARGIN-TOP: 58px; WIDTH: 83px; HEIGHT: 82px; VISIBILITY: hidden;  MARGIN-LEFT: 70px; CURSOR: pointer"
					id=rangePostmark class=flash title=点击更换邮戳 ></div>
				<div style="MARGIN-TOP: 34px; WIDTH: 350px; HEIGHT: 86px;VISIBILITY: hidden; MARGIN-LEFT: 155px;display: none;"
					id=rangeText class=flash ></div>
				<!-- range end -->
				<!-- tool start -->
				<!-- tool end -->
				<div style="MARGIN: 0px; WIDTH: 618px; no-repeat; HEIGHT: 460px; COLOR: #000"
					id=layerMask1 class="mask defaultsize" align="center">
					<img id="layerMask" style="width: 100%;height: 100%;" src="" />
				</div>
				<!-- 明信片end -->
			</div>
			<div class="diy-btns" >
				<button type="button" title="发送" style="background-image: url('../common/images/btns.gif');background-position-x: 0px;background-position-y: -113px;" class="diy-fs" onclick="myfsfun();"></button>
				<button type="button" title="预览" class="diy-yl" onclick="myylfun();"></button>
				<!-- <button type="button" title="收藏" class="diy-sc"></button> margin-left: 330px;-->
				<span style="width: 140px;margin-right: 150px;float: right;">选择背景音乐：</span><br/>
				<select id="themuzics" style="margin-right: 150px;width: 120px;float: right;" onchange="tochachecmuzic();">
				</select>
				
				<div id="yingyusbofas" style="display: none;"></div>
				
				<a href="javascript:void(0);" id="bfa" class="diy-bf" onclick="play_click();">播放</a>
				<a href="javascript:void(0);" class="diy-zt" id="zta" onclick="stop_click();">停止</a>
<!-- 				<a href="javascript:void(0);" class="diy-tz" id="tza" onclick="zantingfun();">停止</a> -->
			</div>
			<table>
				<tr>
				<td align="left"><div class="diy-time">
				<span class="show-time-titbar"><input type="checkbox" name="chetime" />定时发送<em>(选择定时发送的时间)</em></span>
				<span class="show-time-cons">
					<select name="nianer" style="width:60px;" onchange="theendtimescontext();">
					<% for(int i = 2013; i < 2023; i++) { %>
						<option value="<%= i%>"><%= i%></option>
					<% } %>
					</select>
					<em>年</em>
					<select name="yueer" onchange="changeDayByMonth();" style="width:42px;">
						<% for(int j = 1; j < 13; j++) { %>
						<option value="<%= j%>"><%= j%></option>
						<% } %>
					</select>
					<em>月</em>
					<select name="rier" onchange="theendtimescontext();" style="width:42px;">
						<% for(int r = 1; r < 32; r++) { %>
						<option value="<%= r%>"><%= r%></option>
						<% } %>
					</select>
					<em>日</em>
					<select name="shier" onchange="theendtimescontext();" style="width:42px;">
						<% for(int s = 0; s < 24; s++) { %>
						<option value="<%= s%>"><%= s%></option>
						<% } %>
					</select>
					<em>时</em>
					<select name="fener" onchange="theendtimescontext();" style="width:42px;">
						<% for(int f = 0; f < 60; f++) { %>
						<option value="<%= f%>"><%= f%></option>
						<% } %>
					</select>
					<em>分</em>
				</span>
				<p id="endneirongscc"></p>
			</div></td>
				<td><div class="diy-time" style="width: 257px;"><span class="show-time-titbar" style="width: 257px;height: 28px;">选择字体:
				<select id="ziti" style="width: 75px;margin-top: 2px;" title="字体的修改效果需要在预览中才可看到效果">
					<option value="systemData/fonts/BAUHS93.TTF">华文彩云</option>
					<option value="systemData/fonts/COLOUR.TTF">行楷</option>
					<option value="systemData/fonts/STCAIYUN.TTF">琥珀</option>
				</select>
				<select id="yanse" style="width: 55px;margin-top: 2px;" onchange="yansechange();">
				 <option value="black">黑色</option>
					<option value="red">红色</option>
					<option value="blue">蓝色</option>
					<option value="green">绿色</option>
				</select>
				<select id="daxiao" style="width: 57px;margin-top: 2px;"  onchange="daxiaochange();">
					<option value="20">20 磅</option>
					<option value="25">25 磅</option>
					<option value="30">30 磅</option>
					<option value="35">35 磅</option>
				</select></span>
				<span class="show-time-cons" style="width: 240px; height: 68px;margin-top: 0px;">
					<textarea id=layerText style="width: 230px; height: 68px;font-size: 13px;margin-top: 0px;"  
					hascontent="true" focused="false" onfocus="cleaNeiRong();" onblur="addNeiRong();">留下你祝福的话语:</textarea>
				</span></div></td>
				</tr>
			</table>
		</div>
		<div class="right316">
			<div class="diy-tab">
<!-- 				<div  id="tabs"> -->
					<a href="javascript:void(0);" id="xxk" class="on">选相框</a>
					<a href="javascript:void(0);" id="xzp" >选照片</a>
					<a href="javascript:void(0);" id="xyp" >贴邮票</a>
					<a href="javascript:void(0);" id="xyc">盖邮戳</a>
					<a href="javascript:void(0);" id="xsp">饰品</a>
<!-- 					<a href="javascript:void(0);" id="xyy">选音乐</a> -->
					<a href="javascript:void(0);" id="xdp" >选底图</a>
<!-- 				</div> -->
			</div>
			<div class="diy-fl" id="pictype">
				<cite>分类：</cite>
				<span id="fenleispan"></span>
			</div>
			<div class="diy-fl" id="wenjian" style="display: none;">
			<script type="text/javascript" src="../common/upload/ajaxfileupload.js"></script>
			<form id="uploadForm" enctype="multipart/form-data" method="post">  
				<span>照片上传：</span>
				<img src="../common/upload/loading.gif" id="loading" style="display: none;"/>
               <input type="file" id="file" name="file" />&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick="ajaxFileUpload();">上 传</a>
		    </form>
			</div>
		<div id="tabs-0">        
			<div id="tabs-000" class=scrollcontainer>
					<ul class="diy-imglist1" id="xxkul"></ul>
			</div>
		</div>
		<div id="tabs-1">        
			<div id="tabs-001" class=scrollcontainer>
					<ul class="diy-imglist1" id="xzpul" style="display: none;"></ul>
			</div>
		</div>
		<div id="tabs-2">        
			<div id="thumbstampdiv" class=scrollcontainer>
					<ul class="diy-imglist1" id="xypul" style="display: none;"></ul>
			</div>
		</div>
		<div id="tabs-3">        
			<div id="thumbpostmarkdiv" class=scrollcontainer>
					<ul class="diy-imglist1" id="xycul" style="display: none;"></ul>
			</div>
		</div>
		<div id="tabs-4">        
			<div id="sc" class=scrollcontainer>
					<ul class="diy-imglist1" id="xspul" style="display: none;"></ul>
			</div>
		</div>
		<div id="tabs-7">  
			<div id="sc3" class=scrollcontainer>
				<ul class="diy-imglist1" id="xdpul" style="display: none;"></ul>
			</div>
		</div>
			<div class="diy-page">
			<input type="hidden" id="paramType" value="xxkul"/>
				<a href="javascript:void(0);" class="dp1" onclick="chanegePage(1);"></a><i id="pageNums">1/1</i><a href="javascript:void(0);" class="dp2" onclick="chanegePage(2);"></a>
			</div>
		</div>
	</div>
</div>

<!-- FOOT begin-->
<jsp:include page="../foot.jsp" />
<!-- FOOT end-->

<!-- sendbox begin-->
<jsp:include page="sendBox.jsp" />
<!-- sendbox end-->

<!--发送明信片弹窗 lightbox end-->
<!--新增联系人-->
<div id="addLink" style="display:none;width: 300px;">
		<div class="lbox538-top" style="width: 300px;"><h3>联系人</h3><span class="btn-close2" title="关闭" onClick="javascript:addLink.Close();"></span></div>
			<div class="lbox538-cons" >
							<ul class="user-box">
							    <li>
									<dl id="groupContract"></dl>
							    </li>
							</ul>
			</div>
			<div class="lbox538-bot" style="width: 300px;">
				<button title="确定" class="btn1" onclick="javascript:addLink.Close();"></button>
				<button type="button" title="取消" class="btn2" onClick="javascript:addLink.Close();"></button>
			</div>
		<i class="lbox-bbg png"></i>
</div>

<!--成功 lightbox-->
	<div id="sendBox3" style="display:none;">
		<div class="lbox466">
			<i class="lbox-tbg png"></i>
			<div class="lbox-bg png">
				<div class="lbox-wrap">
					<span class="btn-close png" title="关闭"  onclick="javascript:sendBox3.Close();"></span>
					<span class="lbox-titbar">温馨提示</span>
					<span class="lbox-cons">
						<span class="alert-tips t-yes">
							<p>恭喜！发送成功啦！！</p>
						</span>
					</span>
					<span class="lbox-btns">
						<button class="btns-again" title="再发一个" type="button" onclick="javascript:sendBox3.Close();sendBox1.Show();"></button>
						<button class="btns-close" title="关闭" type="button"  onclick="javascript:sendBox3.Close();"></button>
					</span>
				</div>
			</div>
			<i class="lbox-bbg png"></i>
		</div>
	</div>
	<!--成功 lightbox end-->

<script type="text/javascript">
// 	var sendBox1 = new LightBox("sendBox1"); //发送明信片弹窗
	var sendBox3 = new LightBox("sendBox3"); //发送明信片弹窗
	var addLink=new LightBox("addLink");
	
	function loadMusic(){
		//加载背景音乐下拉框
		var music = $("#themuzics");
//		music.empty();//清除select中的 option
		var opt = $("<option>").text("请选择背景音乐").val(0);  
		music.append(opt); 
		jQuery.post(ctxPath+"/findAllBgMusic!findAll.action",
		function(data) {
			if(null!=data && ""!=data){
				for(var i = 0;i < data.list.length; i++) {
					var opt = $("<option>").text(data.list[i].name).val(data.list[i].fileUrl);  
					music.append(opt);  
				}
			}
		});
	}
	loadMusic();
	
	function play_click(){
	    var div = document.getElementById("yingyusbofas");
	    var muzicsrc = "";
		muzicsrc = $("#themuzics").val();
		if(0 == muzicsrc || "0" == muzicsrc) {
			alert("请选择音乐。");
			return;
		}
		muzicsrc = "http://211.91.224.232/resources/"+muzicsrc;
		if ( navigator.userAgent.toLowerCase().indexOf( "msie" ) != -1 ) {
				div.innerHTML = '<bgsound src="'+muzicsrc+'" loop="-1">';
			} else if ( navigator.userAgent.toLowerCase().indexOf( "firefox" ) != -1 ) {
				div.innerHTML = '<object id="bofangqi" data="'+muzicsrc+'" type="application/x-mplayer2" width="0" height="0"><param name="src" value="'+muzicsrc+'"><param name="autostart" value="1"><param name="playcount" value="infinite"></object>';
			} else {
				div.innerHTML = '<audio src="'+muzicsrc+'" autoplay="autoplay" loop="loop">'
				+'<object id="bofangqi" data="'+muzicsrc+'" type="application/x-mplayer2" width="0" height="0"><param name="src" value="'+muzicsrc+'"><param name="autostart" value="1"><param name="playcount" value="infinite">'
				+'<embed height="2" width="2" src="'+muzicsrc+'" pluginspage="http://www.apple.com/quicktime/download/" type="video/quicktime" controller="false" controls="false" autoplay="true" autostart="true" loop="true" ><br>'
				+'</embed></object></audio>';
		}
	}
	
	function stop_click(){
// 		 var bofangqi = document.getElementById('bofangqi');
// 		 try{
// 		  	bofangqi.pause();
// 		 }catch(e){
		  	document.getElementById("yingyusbofas").innerHTML = '';
// 		 }
	}
</script>
</body>
</html>
