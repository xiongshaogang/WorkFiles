package jeecg.kxcomm.service.hrm;

import jeecg.kxcomm.entity.hrm.TbCheckingInstanceEntity;
import jeecg.system.pojo.base.TSUser;

import org.jeecgframework.core.common.hibernate.qbc.HqlQuery;
import org.jeecgframework.core.common.hibernate.qbc.PageList;
import org.jeecgframework.core.common.service.CommonService;

public interface TbCheckingInstanceServiceI extends CommonService{

	/**
	 * 根据查询条件查询考勤情况.
	 *
	 * @param hqlQuery
	 * @param b
	 * @param tbCheckingInstance
	 * @param id
	 * @param user
	 * @return
	 */
	public PageList getPageList(HqlQuery hqlQuery, boolean b,TbCheckingInstanceEntity tbCheckingInstance, String starttime, String endtime,String empname);
}
