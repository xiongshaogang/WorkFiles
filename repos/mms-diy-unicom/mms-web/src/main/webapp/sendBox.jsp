<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>沃爱彩信</title>
<meta name="keywords" content="沃爱彩信" />
<meta name="description" content="沃爱彩信" />

<%-- <jsp:include page="common/jsp/head.jsp" /> --%>
<script type="text/javascript">
function addShouCang()
{
	var cardId=$("#cardId").val();
	  $.post(ctxPath+'/myShouCang!addShouCang.action',{//
			'cardId':cardId
		},
		function(data) {
		//	var data = eval('(' + data + ')');
			if(null!=data && ""!=data){
				if(data.msg=="error"){
					//			$("#titleContant").html("请先登录！");
					//			sendBox5.Show();
								window.location.href = ctx+"timeout.jsp";
							}
				else if(data.msg=="ok"){
					alert("收藏成功！");
				}else if(data.msg=="no")
					{
					alert("收藏失败");
					}
			}
	});
}
</script>
</head>
<!-- <body> -->
		<!--发送明信片弹窗 lightbox-->
	<div id="sendBox1" style="display:none">
		<div class="lbox608">
			<i class="lbox-tbg png"></i>
			<div class="lbox-bg png">
				<form>
				<div class="lbox-wrap">
					<span class="btn-close png" title="关闭" onClick="javascript:sendBox1.Close();"></span>
					<span class="lbox-titbar">发送彩信</span>
					<span style="text-align: left;" class="lbox-cons cons1">
						<!-- <span class="show-img1">
							<span class="yp1 png"></span>
							<img src="" id="sendTemplateImg" />
						</span>
						<span class="show-text1">
							<cite>留言：</cite>
							<textarea id ="liuyanTitle" name="ly" onclick="onceClear(id);">也许岁月将往事褪色，或许空间将彼此隔离。但值得珍惜的依然是知心的友谊。想再次对你说声：2013，新年快乐！</textarea>
						</span>  -->
						 <!-- <span class="show-text1"> margin: 300px 0px 0px 78px; margin-top:300px;margin-left:78px;-->
						 <textarea style="background:transparent; margin-left : 0px;margin-top : 0px;color: rgb(0, 0, 0); font-size: 16px;position: absolute;
													z-index: 2;
													overflow-x: hidden;
													overflow-y: auto;
													word-break: break-all;
													word-wrap: break-word;
													background: transparent;
													font: normal 16px \6977\4F53_GB2312;
													line-height: 23px;
													border: none;
													outline: none;
													resize: none;"
										id ="liuyanTitle" onclick="onceClear(id);"  hascontent="true" focuspos="" focused="false"></textarea><!-- class="contentext" -->
						<!-- </span>  -->
						<div style='margin: 6px 0px 0px; width: 540px; height: 453px; color: rgb(0, 0, 0); position: relative;z-index: 1;-moz-user-select: none;'
							 class="mask defaultsize" unselectable="on"><img src="" id="sendTemplateImg"  style="width: 540px; height: 453px;" /></div>
					 <span id = "msgcount" class="show-tips1"></span>
					</span>
					<span class="lbox-btns">
					    <input type="hidden" id="cardId"/>
						<button class="btns-next" title="下一步" onClick="closeFirstWindow();" type="button"> </button>
						<button class="btns-sc" title="收藏" type="button" onclick="addShouCang();" > </button>
						<button class="btns-cancel" title="取消" onClick="closed();" type="button"> </button>
					</span>
				</div>
				</form>
			</div>
			<i class="lbox-bbg png"></i>
		</div>
	</div>
	<!--发送明信片弹窗 lightbox end-->
	
	<!--发送明信片弹窗 lightbox-->
	<div id="sendBox2" style="display:none">
		<div class="lbox608">
			<i class="lbox-tbg png"></i>
			<div class="lbox-bg png">
				<form>
				<div class="lbox-wrap">
					<span class="btn-close png" title="关闭" onClick="javascript:sendBox2.Close();"></span>
					<span class="lbox-titbar">发送彩信</span>
					<span class="lbox-cons cons2">
						<span class="lbox-l">
							<span class="lbox-sj">
								<cite>收件人：</cite>
								<span><!-- onkeyup="pressKeyup(id)" -->
									<textarea id="shoujianren" name="sjr" style="background: white;" onkeyup="pressKeyup(id,event)"></textarea>
									<input type="hidden" id="addressee" />
								</span>
							</span>
							<input type="hidden" id="content"></input>
							<span class="lbox-sjts">可填写多个收件人，每个人收到的是单独发送的明信片。</span>
							<span class="show-img2">
								<!-- <span class="yp2 png"></span>
								<img src="common/testImages/countryfastever/1.jpg">
								<span class="show-text2">
									<cite>留言：</cite>
									<p id = "iscontext">也许岁月将往事褪色，或许空间将彼此隔离。但值得珍惜的依然是知心的友谊。想再次对你说声：2013，新年快乐！</p>
								</span> -->
								<img src="" id="alreadyImg" />
							</span>
							<span class="show-music">
								<input type="checkbox" name="chemusic" id="checkBoxMusic" />
								<cite>背景音乐</cite>
								<select id="bgMusic">
								</select>
							</span>
							<span class="show-time">
								<span class="show-time-titbar"><input type="checkbox" name="chetime" id="checkBoxChetime" />定时发送<em>(选择定时发送的时间)</em></span>
								<span class="show-time-cons">
									<select name="" id="year" style="width:60px;">
									</select>
									<em>年</em>
									<select name="" id="month">
									</select>
									<em>月</em>
									<select name="" id="day">
									</select>
									<em>日</em>
									<select name="" id="hour">
									</select>
									<em>时</em>
									<select name="" id="minute">
									</select>
									<em>分</em>
								</span>
								<!-- <p>彩信将在 今天下午5:00 投递到对方手机</p> -->
							</span>
						</span>
						<div class="ch-left">
							<!-- <h3>联系人</h3> -->
							<div class="ch-box">
								<!-- <div class="ch-sou">
									<button type="button" title="搜索"></button>
									<input type="text" name="" value="查找联系人..." onFocus="if (this.value=='查找联系人...'){this.value='';}; this.style.color='#666';" onBlur="if (this.value==''){this.value='查找联系人...';this.style.color='#666';}" />
								</div> -->
								<ul class="user-box">
									<li>
										<p>联系人</p>
										<dl id="groupContract">
										</dl>
									</li>
								</ul>
							</div>
						</div>
					</span>
					<span class="lbox-btns">
						<button class="btns-send" title="发送" type="button" onClick="sendCard();"></button>
						<!-- <input type="button" class="btns-send" title="发送" onclick="sendCard();" /> -->
						<button class="btns-modify" title="修改" type="button" onClick="javascript:sendBox2.Close();sendBox1.Show();"></button>
						<button class="btns-cancel" title="取消" type="button" onClick="javascript:sendBox2.Close();"></button>
					</span>
				</div>
				</form>
			</div>
			<i class="lbox-bbg png"></i>
		</div>
	</div>
	<!--发送明信片弹窗 lightbox end-->
	
	<!--成功 lightbox-->
	<div id="sendBox3" style="display:none">
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
	
	<!--失败 lightbox-->
	<div id="sendBox4" style="display:none">
		<div class="lbox466">
			<i class="lbox-tbg png"></i>
			<div class="lbox-bg png">
				<div class="lbox-wrap">
					<span class="btn-close png" title="关闭"  onclick="javascript:sendBox4.Close();"></span>
					<span class="lbox-titbar">温馨提示</span>
					<span class="lbox-cons">
						<span class="alert-tips t-no">
							<p>发送失败！请重新再试！！</p>
						</span>
					</span>
					<span class="lbox-btns">
						<button class="btns-again" title="再发一个" type="button" onclick="javascript:sendBox4.Close();sendBox1.Show();"></button>
						<button class="btns-close" title="关闭" type="button"  onclick="javascript:sendBox4.Close();"></button>
					</span>
				</div>
			</div>
			<i class="lbox-bbg png"></i>
		</div>
	</div>
	<!--失败 lightbox end-->
	
	<!--验证 lightbox-->
	<div id="sendBox5" style="display:none">
		<div class="lbox466">
			<i class="lbox-tbg png"></i>
			<div class="lbox-bg png">
				<div class="lbox-wrap">
					<span class="btn-close png" title="关闭"  onclick="javascript:sendBox5.Close();"></span>
					<span class="lbox-titbar">温馨提示</span>
					<span class="lbox-cons">
						<span class="alert-tips t-no">
							<p id="titleContant"></p>
						</span>
					</span>
					<span class="lbox-btns">
						<button class="btns-again" title="确定" type="button" onclick="javascript:sendBox5.Close();"></button>
						<button class="btns-close" title="关闭" type="button"  onclick="javascript:sendBox5.Close();"></button>
					</span>
				</div>
			</div>
			<i class="lbox-bbg png"></i>
		</div>
	</div>
	<!--验证 lightbox end-->
	
	<script type="text/javascript">
		var sendBox1 = new LightBox("sendBox1"); //制定发送明信片弹窗
		var sendBox2 = new LightBox("sendBox2"); //确认发送明信片弹窗
		var sendBox3 = new LightBox("sendBox3"); //发送明信片成功弹窗
		var sendBox4 = new LightBox("sendBox4"); //发送明信片成功弹窗 */
		var sendBox5 = new LightBox("sendBox5"); //发送明信片成功弹窗 */
// 		sendBox1.Show();//默认显示出来
	</script>
<!-- </body> -->
</html>
