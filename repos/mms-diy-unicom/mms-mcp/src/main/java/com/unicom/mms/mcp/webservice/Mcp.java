package com.unicom.mms.mcp.webservice;



import java.util.Date;
import java.util.List;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.unicom.mms.entity.TbBgMusic;
import com.unicom.mms.entity.TbBgPic;
import com.unicom.mms.entity.TbCardType;
import com.unicom.mms.entity.TbCollect;
import com.unicom.mms.entity.TbContacts;
import com.unicom.mms.entity.TbDecoration;
import com.unicom.mms.entity.TbDecorationType;
import com.unicom.mms.entity.TbGroups;
import com.unicom.mms.entity.TbHotBillboard;
import com.unicom.mms.entity.TbNewBillboard;
import com.unicom.mms.entity.TbPhotoFrame;
import com.unicom.mms.entity.TbPostMark;
import com.unicom.mms.entity.TbServices;
import com.unicom.mms.entity.TbStamp;
import com.unicom.mms.entity.TbTemplateCard;
import com.unicom.mms.entity.TbUserPhoto;
import com.unicom.mms.gateway.BatchSendMMS;
import com.unicom.mms.gateway.BatchSendSMS;
import com.unicom.mms.gateway.PostcardMMS;
import com.unicom.mms.gateway.RealTimeSMS;
import com.unicom.mms.mcp.activemq.InitSpringBean;
import com.unicom.mms.mcp.activemq.MsgPublisher;
import com.unicom.mms.mcp.common.Response;
import com.unicom.mms.mcp.service.BgMusicService;
import com.unicom.mms.mcp.service.BgPicService;
import com.unicom.mms.mcp.service.CardTypeService;
import com.unicom.mms.mcp.service.CollectService;
import com.unicom.mms.mcp.service.ContactsService;
import com.unicom.mms.mcp.service.DecorationService;
import com.unicom.mms.mcp.service.DecorationTypeService;
import com.unicom.mms.mcp.service.GroupsService;
import com.unicom.mms.mcp.service.HotBillboardService;
import com.unicom.mms.mcp.service.NewBillboardService;
import com.unicom.mms.mcp.service.PhotoFrameService;
import com.unicom.mms.mcp.service.PostMarkService;
import com.unicom.mms.mcp.service.SendMmsRecsService;
import com.unicom.mms.mcp.service.SendSmsRecsService;
import com.unicom.mms.mcp.service.ServiceLogService;
import com.unicom.mms.mcp.service.StampService;
import com.unicom.mms.mcp.service.TemplateCardService;
import com.unicom.mms.mcp.service.UserPhotoService;

/**
 * 
* 功能描述:WEB服务接口
* <p>版权所有：
* <p>未经本公司许可，不得以任何方式复制或使用本程序任何部分
*
* @author 刘小明 新增日期：2013-2-4
* @author 你的姓名 修改日期：2013-2-4
* @since mms-mcp
 */
@WebService(targetNamespace="http://webservice.mcp.mms.unicom.com")
public class Mcp {

	/*操作日志*/
	@Autowired(required = true)
	private ServiceLogService serviceLogService;
	/*联系人*/
	@Autowired(required = true)
	private ContactsService contactsService;
	/*模板明信片分类*/
	@Autowired(required = true)
	private CardTypeService cardTypeService;
	/*饰品分类*/
	@Autowired(required = true)
	private DecorationTypeService decorationTypeService;
	/*照片*/
	@Autowired(required = true)
	private UserPhotoService userPhotoService;
	/*收藏明信片*/
	@Autowired(required = true)
	private CollectService collectService;
	/*相框*/
	@Autowired(required = true)
	private PhotoFrameService photoFrameService;
	/*最热推荐*/
	@Autowired(required = true)
	private HotBillboardService hotBillboardService;
	/*最新推荐*/
	@Autowired(required = true)
	private NewBillboardService newBillboardService;
	/*饰品*/
	@Autowired(required = true)
	private DecorationService decorationService;
	/*背景音乐*/
	@Autowired(required = true)
	private BgMusicService bgMusicService;
	/*邮票*/
	@Autowired(required = true)
	private PostMarkService postMarkService;
	/*邮票*/
	@Autowired(required = true)
	private StampService stampService;
	/*模板明信片*/
	@Autowired(required = true)
	private TemplateCardService templateCardService;
	/*联系人分组*/
	@Autowired(required = true)
	private GroupsService groupsService;
	/*背影图*/
	@Autowired(required = true)
	private BgPicService bgPicService;
	/*JSON*/
	private Gson gson = new Gson();
	/*已发送短信*/
	@Autowired(required = true)
	private SendSmsRecsService sendSmsRecsService;
	/*已发送彩信*/
	@Autowired(required = true)
	private SendMmsRecsService sendMmsRecsService;
	
//	private static Logger _log = Logger.getLogger(Mcp.class);
	private static Logger _logError = Logger.getLogger("logError");
	
	/***
	 * 
	* 方法用途和描述: 写服务记录
	* @param tbServices
	* @return
	* @author 刘小明 新增日期：2013-2-4
	* @author 你的姓名 修改日期：2013-2-4
	* @since mms-mcp
	 */
//	@WebMethod
//	public String addServiceLog(@WebParam(name="json")String json){
//		Response res = new Response();
//		if(BlankUtil.isBlank(json)){
//			res.setMsg("参数不正确");
//			res.setResultCode(Response.FAIL);
//			return gson.toJson(res);
//		}
//		try {
//			TbServices ps = (TbServices)gson.fromJson(json, new TypeToken<TbServices>(){}.getType());
//			//serviceLogService.saveServiceLog(ps);
//			res.setMsg("操作成功！");
//			res.setResultCode(Response.SUCCESS);
//		} catch (Exception ex) {
//			res.setMsg("操作失败!"+ex.getLocalizedMessage());
//			res.setResultCode(Response.FAIL);
//			ex.printStackTrace();
//			_logError.error(ex);
//		}
//		return gson.toJson(res);
//	}
	private static Logger _log = Logger.getLogger(Mcp.class);
	/***
	 * 
	* 方法用途和描述: 添加修改删除联系人
	* @param contactList
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-4
	* @author 你的姓名 修改日期：2013-2-4
	* @since mms-mcp
	 */
	@WebMethod
	public String contactManage(@WebParam(name="param")String param,
			@WebParam(name="groupId")int groupId,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="channel")String channel,
			@WebParam(name="userMdn")String userMdn){
		Response res = new Response();
		TbServices ts = new TbServices();
		try {
			_log.info("参数1="+param+",参数2="+groupId+",参数3="+actMode+",参数4="+channel+",参数5"+userMdn);
			TbContacts entity = gson.fromJson(param, new TypeToken<TbContacts>(){}.getType());
			if(actMode==2){
				contactsService.delete(entity,groupId);
			}else{
				contactsService.saveOrUpdate(entity,groupId);
			}
			
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
			ts.setOpChannel(channel);
			ts.setOperTime(new Date());
			ts.setOperUser(userMdn);
			ts.setParam(","+groupId+","+channel+","+userMdn);
			ts.setResult("success");
			ts.setService_name("contactManage");
			_log.info(ts);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
			ts.setResult("fail:"+e.getLocalizedMessage());
			_logError.error(e.getLocalizedMessage());
		}finally{

			//serviceLogService.saveServiceLog(ts);
		}
		
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述: 模板明信片分类增、删、改方法。
	* @param cardTypeList
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String cardTypeManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode){
		Response res = new Response();
		
		try {
			List<TbCardType> list =gson.fromJson(param, new TypeToken<List<TbCardType>>(){}.getType());
			if(actMode==1){
				this.cardTypeService.saveOrUpdate(list);
			}else if(actMode==2){
				this.cardTypeService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	
	
	/***
	 * 
	* 方法用途和描述: 饰品分类增、删、改方法
	* @param list
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String decorationTypeManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode){
		Response res = new Response();
		
		try {
			List<TbDecorationType> list =gson.fromJson(param, new TypeToken<List<TbDecorationType>>(){}.getType());
			if(actMode==1){
				this.decorationTypeService.saveOrUpdate(list);
			}else if(actMode==2){
				this.decorationTypeService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述:模板明信片增删改方法
	* @param list
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String templateCardManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="fileName")String fileName){
		Response res = new Response();
		
		try {
			List<TbTemplateCard> list =gson.fromJson(param, new TypeToken<List<TbTemplateCard>>(){}.getType());
			if(actMode==1){
				this.templateCardService.saveOrUpdate(list);
			}else if(actMode==2){
				this.templateCardService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述: 添加删除邮戳
	* @param list
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String stampManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="fileName")String fileName){
		Response res = new Response();
		
		try {
			List<TbStamp> list =gson.fromJson(param, new TypeToken<List<TbStamp>>(){}.getType());
			if(actMode==1){
				this.stampService.saveOrUpdate(list);
			}else if(actMode==2){
				this.stampService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述: 添加删除邮票
	* @param list
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String postMarkManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="fileName")String fileName){
		Response res = new Response();
		
		try {
			List<TbPostMark> list =gson.fromJson(param, new TypeToken<List<TbPostMark>>(){}.getType());
			if(actMode==1){
				this.postMarkService.saveOrUpdate(list);
			}else if(actMode==2){
				this.postMarkService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述: 添加背影图
	* @param param
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-5-11
	* @author 你的姓名 修改日期：2013-5-11
	* @since mms-mcp
	 */
	@WebMethod
	public String bgPicManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode){
		Response res = new Response();
		
		try {
			List<TbBgPic> list =gson.fromJson(param, new TypeToken<List<TbBgPic>>(){}.getType());
			if(actMode==1){
				this.bgPicService.saveOrUpdate(list);
			}else if(actMode==2){
				this.bgPicService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述: 背景音乐添删改
	* @param list
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String musicManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="fileName")String fileName){
		Response res = new Response();
		
		try {
			List<TbBgMusic> list =gson.fromJson(param, new TypeToken<List<TbBgMusic>>(){}.getType());
			if(actMode==1){
				this.bgMusicService.saveOrUpdate(list);
			}else if(actMode==2){
				this.bgMusicService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述:饰品增删改
	* @param list
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String decorationManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="fileName")String fileName){
		Response res = new Response();
		
		try {
			List<TbDecoration> list =gson.fromJson(param, new TypeToken<List<TbDecoration>>(){}.getType());
			if(actMode==1){
				this.decorationService.saveOrUpdate(list);
			}else if(actMode==2){
				this.decorationService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	
	/***
	 * 
	* 方法用途和描述: 添加修改模板明信片最新推荐
	* @param tbNewBillboard
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String newBillboardManage(@WebParam(name="param")String param){
		Response res = new Response();
		
		try {
			TbNewBillboard  tbb = gson.fromJson(param, new TypeToken<TbNewBillboard>(){}.getType());
			this.newBillboardService.saveOrUpdate(tbb);
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	
	/***
	 * 
	* 方法用途和描述: 	添加修改模板明信片最热推荐
	* @param tbHotBillboard
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String hotBillboardManage(@WebParam(name="param")String param){
		Response res = new Response();
		
		try {
			TbHotBillboard  thb = (TbHotBillboard)gson.fromJson(param, new TypeToken<TbHotBillboard>(){}.getType());
			hotBillboardService.saveOrUpdate(thb);
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述:添加修改删除联系人分组
	* @param groupList
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-4
	* @author 你的姓名 修改日期：2013-2-4
	* @since mms-mcp-new
	 */
	@WebMethod
	public String groupManage(@WebParam(name="param")String param,
			@WebParam(name="contactList")String contactList,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="channel")String channel,
			@WebParam(name="userMdn")String userMdn){
		Response res = new Response();
		TbServices ts = new TbServices();
		try {
			_log.info(param+" " +contactList +" " + actMode +" "+ channel+ " "+userMdn+"  fff");
			TbGroups ps =gson.fromJson(param, new TypeToken<TbGroups>(){}.getType());
			List<TbContacts> tcList =null;
			if(contactList!=null){
				tcList = gson.fromJson(contactList, new TypeToken<List<TbContacts>>(){}.getType());
			}
			
			if(actMode==2){
				groupsService.delete(ps);
			}else{
				groupsService.saveOrUpdate(ps,tcList);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
			ts.setOpChannel(channel);
			ts.setOperTime(new Date());
			ts.setOperUser(userMdn);
			ts.setParam(channel+","+userMdn);
			ts.setResult("success");
			ts.setService_name("groupManage");
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
			ts.setResult("fail:"+e.getLocalizedMessage());
		}finally{
			//serviceLogService.saveServiceLog(ts);
		}
		
		return gson.toJson(res);
	}
	

	/***
	 * 
	* 方法用途和描述: 添加删除相框
	* @param photoFrameList
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String photoFrameManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode,
			@WebParam(name="fileName")String fileName){
		Response res = new Response();
		
		try {
			List<TbPhotoFrame> list =gson.fromJson(param, new TypeToken<List<TbPhotoFrame>>(){}.getType());
			if(actMode==1){
				this.photoFrameService.saveOrUpdate(list);
			}else if(actMode==2){
				this.photoFrameService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	
	/***
	 * 
	* 方法用途和描述: 收藏模板明信片
	* @param collectList
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp-new
	 */
	@WebMethod
	public String collectionManage(@WebParam(name="param")String param,
			@WebParam(name="actMode")int actMode){
		Response res = new Response();
		
		try {

			List<TbCollect> list =gson.fromJson(param, new TypeToken<List<TbCollect>>(){}.getType());
			if(actMode==1){
				this.collectService.saveOrUpdate(list);
			}else if(actMode==2){
				this.collectService.delete(list);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
		}
		return gson.toJson(res);
	}
	/***
	 * 
	* 方法用途和描述: 发送明信片彩信
	* @param 
	* @return
	* @author 刘小明 新增日期：2013-2-5
	* @author 你的姓名 修改日期：2013-2-5
	* @since mms-mcp
	 */
	@WebMethod
	public String sendPostcardMms(@WebParam(name="param")String param){
		Response res = new Response();
		TbServices ts = new TbServices();
		try {
			PostcardMMS  msg = gson.fromJson(param, new TypeToken<PostcardMMS>(){}.getType());
			//把发送彩信的内容保存到已发送表
//			sendMmsRecsService.save(msg);
			//TODO 请在重新定义接口的入参和返回结果
			InitSpringBean initSpringBean = InitSpringBean.getSingleInstance();
			MsgPublisher msgPublisher = initSpringBean.getMsgPublisher();
			msgPublisher.send(msg);
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
			ts.setResult("fail:"+e.getLocalizedMessage());
		}
//		serviceLogService.saveServiceLog(ts);
		return gson.toJson(res);
	}
	
	/**
	 * 
	 * 群发彩信
	 * 
	 * @param param
	 * @param channel
	 * @param userMdn
	 * @return
	 * @author zhangjh 新增日期：2013-9-27
	 * @since mms-mcp
	 */
	@WebMethod
	public String sendBatchMms(@WebParam(name="param")String param,
			@WebParam(name="channel")String channel,
			@WebParam(name="userMdn")String userMdn){
		Response res = new Response();
		TbServices ts = new TbServices();
		try {
			BatchSendMMS  msg = gson.fromJson(param, new TypeToken<BatchSendMMS>(){}.getType());
			//TODO 请在重新定义接口的入参和返回结果
			InitSpringBean initSpringBean = InitSpringBean.getSingleInstance();
			MsgPublisher msgPublisher = initSpringBean.getMsgPublisher();
			msgPublisher.send(msg);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
			ts.setResult("fail:"+e.getLocalizedMessage());
		}
		//serviceLogService.saveServiceLog(ts);
		return gson.toJson(res);
	}
	
	/**
	 * 
	 * 群发短信
	 * 
	 * @param param
	 * @param channel
	 * @param userMdn
	 * @return
	 * @author zhangjh 新增日期：2013-9-27
	 * @since mms-mcp
	 */
	@WebMethod
	public String sendBatchSms(@WebParam(name="param")String param){
		Response res = new Response();
		TbServices ts = new TbServices();
		try {
			BatchSendSMS  msg = gson.fromJson(param, new TypeToken<BatchSendSMS>(){}.getType());
			//TODO 请在重新定义接口的入参和返回结果
			InitSpringBean initSpringBean = InitSpringBean.getSingleInstance();
			MsgPublisher msgPublisher = initSpringBean.getMsgPublisher();
			msgPublisher.send(msg);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
			ts.setResult("fail:"+e.getLocalizedMessage());
		}
		//serviceLogService.saveServiceLog(ts);
		return gson.toJson(res);
	}
	
	/**
	 * 
	 * 实时发送短信接口
	 * 
	 * @param param
	 * @param channel
	 * @param userMdn
	 * @return
	 * @author zhangjh 新增日期：2013-9-27
	 * @since mms-mcp
	 */
	@WebMethod
	public String sendRealtimeSms(@WebParam(name="param")String param){
		Response res = new Response();
		TbServices ts = new TbServices();
		try {
			RealTimeSMS msg = gson.fromJson(param, new TypeToken<RealTimeSMS>(){}.getType());
			//把发送短信的内容保存到已发送表
			sendSmsRecsService.save(msg);
			//TODO 请在重新定义接口的入参和返回结果
			InitSpringBean initSpringBean = InitSpringBean.getSingleInstance();
			MsgPublisher msgPublisher = initSpringBean.getMsgPublisher();
			msgPublisher.send(msg);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
			ts.setResult("fail:"+e.getLocalizedMessage());
		}
		//serviceLogService.saveServiceLog(ts);
		return gson.toJson(res);
	}
	
	
	/***
	 * 
	* 方法用途和描述:照片
	* @param param
	* @param actMode
	* @return
	* @author 刘小明 新增日期：2013-5-6
	* @author 你的姓名 修改日期：2013-5-6
	* @since mms-mcp
	 */
	@WebMethod
	public String userPhotoManage(@WebParam(name="param")String param,
									@WebParam(name="actMode")int actMode,
									@WebParam(name="channel")String channel,
									@WebParam(name="userMdn")String userMdn){
		Response res = new Response();
		TbServices ts = new TbServices();
		try {
			_log.info("param="+param+" "+actMode+" | "+channel+" |" +userMdn);
			TbUserPhoto userPhoto = gson.fromJson(param, new TypeToken<TbUserPhoto>(){}.getType());
			if(actMode==1){
				this.userPhotoService.saveOrUpdate(userPhoto);
			}else if (actMode==2){
				this.userPhotoService.delete(userPhoto);
			}
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
			ts.setOpChannel(channel);
			ts.setOperTime(new Date());
			ts.setOperUser(userMdn);
			ts.setParam(channel+","+userMdn);
			ts.setResult("success");
			ts.setService_name("sendMms");
			res.setMsg("操作成功！");
			res.setResultCode(Response.SUCCESS);
		} catch (Exception e) {
			res.setMsg("操作失败!"+e.getLocalizedMessage());
			res.setResultCode(Response.FAIL);
			e.printStackTrace();
			ts.setResult("fail:"+e.getLocalizedMessage());
		}
		//serviceLogService.saveServiceLog(ts);
		return gson.toJson(res);
	}
}
