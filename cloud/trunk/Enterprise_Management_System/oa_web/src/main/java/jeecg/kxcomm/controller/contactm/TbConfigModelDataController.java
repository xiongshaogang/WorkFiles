package jeecg.kxcomm.controller.contactm;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jeecg.kxcomm.entity.contactm.TbConfigModelDataEntity;
import jeecg.kxcomm.entity.contactm.TbConfigModelsEntity;
import jeecg.kxcomm.entity.contactm.TbQuotationsEntity;
import jeecg.kxcomm.entity.systemmanager.TbDataRecordEntityEntity;
import jeecg.kxcomm.entity.systemmanager.TbProductTypeEntity;
import jeecg.kxcomm.service.contactm.TbConfigModelDataServiceI;
import jeecg.kxcomm.util.CommonUtil;
import jeecg.kxcomm.util.ExportQuotations;
import jeecg.kxcomm.util.PathConstants;
import jeecg.kxcomm.vo.systemmanager.DataBean;
import jeecg.kxcomm.vo.systemmanager.TbDataRecordVo;
import jeecg.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**   
 * @Title: Controller
 * @Description: 配置单数据
 * @author zhangdaihao
 * @date 2013-10-24 10:09:26
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/tbConfigModelDataController")
public class TbConfigModelDataController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(TbConfigModelDataController.class);

	@Autowired
	private TbConfigModelDataServiceI tbConfigModelDataService;
	@Autowired
	private SystemService systemService;
	private String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	/**
	 * 配置单数据列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "tbConfigModelData")
	public ModelAndView tbConfigModelData(HttpServletRequest request) {
		return new ModelAndView("jeecg/kxcomm/contactm/tbConfigModelDataList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(TbConfigModelDataEntity tbConfigModelData,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TbConfigModelDataEntity.class, dataGrid);
		
		String configId = request.getParameter("configId");
		String tbProductCategoryId = request.getParameter("tbProductCategoryId");
		if(null!=tbProductCategoryId && !("".equals(tbProductCategoryId))){
			cq.createAlias("tbDataRecord", "tbDataRecord");
			cq.createAlias("tbDataRecord.tbProductType", "tbProductType");
			cq.createAlias("tbDataRecord.tbProductType.tbProductCategory", "tbProductCategory");
			cq.eq("tbProductCategory.id",tbProductCategoryId);
			cq.add();
		}
		cq.createAlias("tbConfigModels", "tbConfigModels");
		cq.eq("tbConfigModels.id",configId);
		cq.add();
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tbConfigModelData);
		this.tbConfigModelDataService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除配置单数据
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TbConfigModelDataEntity tbConfigModelData, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		tbConfigModelData = systemService.getEntity(TbConfigModelDataEntity.class, tbConfigModelData.getId());
		message = "删除成功";
		tbConfigModelDataService.delete(tbConfigModelData);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
		j.setMsg(message);
		return j;
	}


	
//	@RequestMapping(params = "save")
//	@ResponseBody
//	public AjaxJson save(TbConfigModelDataEntity tbConfigModelData, HttpServletRequest request) {
//		AjaxJson j = new AjaxJson();
//		if (StringUtil.isNotEmpty(tbConfigModelData.getId())) {
//			message = "更新成功";
//			TbConfigModelDataEntity t = tbConfigModelDataService.get(TbConfigModelDataEntity.class, tbConfigModelData.getId());
//			try {
//				MyBeanUtils.copyBeanNotNull2Bean(tbConfigModelData, t);
//				tbConfigModelDataService.saveOrUpdate(t);
//				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		} else {
//			message = "添加成功";
//			tbConfigModelDataService.save(tbConfigModelData);
//			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
//		}
//		
//		return j;
//	}

	/**
	 * 配置单数据列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TbConfigModelDataEntity tbConfigModelData, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tbConfigModelData.getId())) {
			tbConfigModelData = tbConfigModelDataService.getEntity(TbConfigModelDataEntity.class, tbConfigModelData.getId());
			req.setAttribute("tbConfigModelDataPage", tbConfigModelData);
		}
		return new ModelAndView("jeecg/kxcomm/contactm/tbConfigModelData");
	}
	
	@RequestMapping(params = "changePageById")
	public ModelAndView changePageById(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		String configId = ""+session.getAttribute("configId");
		List<DataBean> volist = (List<DataBean>)session.getAttribute("volist");
		request.setAttribute("configId", configId);
		request.setAttribute("volist", volist);
		return new ModelAndView("jeecg/kxcomm/contactm/tbConfigModelDataList");
	}
	
	/**
	 * 添加配置单数据
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		
		double afterDiscountNowPrice=0;
		/**折扣后价格*/
		double afterDiscountPrice=0;
		/**目录合价*/
		double catalogTotalPrice=0;
		double totalPrice=0;
		
		String str = request.getParameter("vo");
		String[] primarSouce = str.split(",");
		
		TbConfigModelsEntity tbConfigModels = systemService.getEntity(TbConfigModelsEntity.class, primarSouce[primarSouce.length-1]);
		String hql0 = "from TbConfigModelDataEntity where 1 = 1 AND tbConfigModels = ? ";
		List<TbConfigModelDataEntity> tbConfigModelDataOldList = systemService.findHql(hql0, tbConfigModels);
		tbConfigModelDataService.deleteAllEntitie(tbConfigModelDataOldList);
		
		for(int i=0;i<primarSouce.length;i=i+13){
			int n=i;

			TbConfigModelDataEntity tbConfigModelData = new TbConfigModelDataEntity();
					
			BigDecimal b = new BigDecimal(primarSouce[n]); 
			tbConfigModelData.setQuantity(b);
			tbConfigModelData.setCatalogPrice(primarSouce[n+1]);
			tbConfigModelData.setDiscountrate(primarSouce[n+2]);
			tbConfigModelData.setDiscountedPrice(primarSouce[n+3]);
			tbConfigModelData.setDiscountedAfterPrice(primarSouce[n+4]);
			tbConfigModelData.setFirstYear(primarSouce[n+5]);
			tbConfigModelData.setSecondYear(primarSouce[n+6]);
			tbConfigModelData.setThirdYear(primarSouce[n+7]);
			tbConfigModelData.setTotalPrice(primarSouce[n+8]);
			tbConfigModelData.setExchangeRate(primarSouce[n+11]);		
			TbDataRecordEntityEntity tbDataRecord = systemService.getEntity(TbDataRecordEntityEntity.class, primarSouce[n+9]);
			tbConfigModelData.setTbDataRecord(tbDataRecord);
					
			//TbConfigModelsEntity tbConfigModel = systemService.getEntity(TbConfigModelsEntity.class, primarSouce[n+11]);
			tbConfigModelData.setTbConfigModels(tbConfigModels);
			tbConfigModelDataService.save(tbConfigModelData);	
				
		}
		
		String hql = "from TbConfigModelDataEntity where 1 = 1 AND tbConfigModels = ? ";
		List<TbConfigModelDataEntity> tbConfigModelDataList = systemService.findHql(hql, tbConfigModels);
		for(int i=0;i<tbConfigModelDataList.size();i++){
			catalogTotalPrice += Double.parseDouble( tbConfigModelDataList.get(i).getCatalogPrice());
			afterDiscountPrice +=Double.parseDouble( tbConfigModelDataList.get(i).getDiscountedPrice());
			afterDiscountNowPrice +=Double.parseDouble( tbConfigModelDataList.get(i).getDiscountedAfterPrice());
			totalPrice +=Double.parseDouble( tbConfigModelDataList.get(i).getTotalPrice());
		}
		tbConfigModels.setAfterDiscountNowPrice(CommonUtil.getInstance().numberFormat(afterDiscountNowPrice+"", 4, true));
		tbConfigModels.setAfterDiscountPrice(CommonUtil.getInstance().numberFormat(afterDiscountPrice+"", 4, true));
		tbConfigModels.setCatalogTotalPrice(CommonUtil.getInstance().numberFormat(catalogTotalPrice+"", 4, true));
		tbConfigModels.setTotalPrice(CommonUtil.getInstance().numberFormat(totalPrice+"", 4, true));
		systemService.updateEntitie(tbConfigModels);
		
		
		message = "保存成功";
		j.setMsg(message);
		return j;
		
	}
	
	@RequestMapping(params = "back")
	public ModelAndView back(HttpServletRequest req) {
		String id = req.getParameter("configId");
		
	    TbConfigModelsEntity tbConfigModels = systemService.getEntity(TbConfigModelsEntity.class, id);
	    //systemService.getEntity(TbQuotationsEntity.class, tbConfigModels.getTbQuotations().getId());
	   
	    req.setAttribute("quotation",tbConfigModels.getTbQuotations().getId());
		
		return new ModelAndView("jeecg/kxcomm/contactm/tbConfigModelsList");
	}
	
	
	@RequestMapping(params = "checkBack")
	public ModelAndView checkBack(HttpServletRequest req) {
		String id = req.getParameter("configId");
		
	    TbConfigModelsEntity tbConfigModels = systemService.getEntity(TbConfigModelsEntity.class, id);
	    //systemService.getEntity(TbQuotationsEntity.class, tbConfigModels.getTbQuotations().getId());
	   
	    req.setAttribute("quotation",tbConfigModels.getTbQuotations().getId());
		
		return new ModelAndView("jeecg/kxcomm/contactm/tbConfigModelsCheckList");
	}
	
	@RequestMapping(params = "getDiscountRate")
	@ResponseBody
	public String getDiscountRate(HttpServletRequest req) {
		String id = req.getParameter("endid");
		
	    TbDataRecordEntityEntity tbDataRecord = systemService.getEntity(TbDataRecordEntityEntity.class, id);
		
		return tbDataRecord.getDiscountrate();
	}
}
