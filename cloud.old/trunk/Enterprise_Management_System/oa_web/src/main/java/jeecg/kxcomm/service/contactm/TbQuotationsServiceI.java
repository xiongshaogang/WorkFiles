package jeecg.kxcomm.service.contactm;

import java.util.List;

import jeecg.kxcomm.entity.contactm.TbConfigModelsEntity;
import jeecg.kxcomm.entity.contactm.TbQuotationsEntity;
import jeecg.kxcomm.entity.systemmanager.TbDataRecordEntityEntity;
import jeecg.kxcomm.vo.systemmanager.TbDataRecordVo;

import org.jeecgframework.core.common.hibernate.qbc.HqlQuery;
import org.jeecgframework.core.common.hibernate.qbc.PageList;
import org.jeecgframework.core.common.service.CommonService;

public interface TbQuotationsServiceI extends CommonService{

	public List<TbDataRecordVo> listConfigModelDataById(String id);
	
	public List<List<TbDataRecordVo>> listConfigModelData(List<TbConfigModelsEntity> configModelsList);
	public PageList getPageList(HqlQuery hqlQuery, boolean b,TbQuotationsEntity tbQuotations);
}
