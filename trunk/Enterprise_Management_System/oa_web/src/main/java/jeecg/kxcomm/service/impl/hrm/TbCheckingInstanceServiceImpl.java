package jeecg.kxcomm.service.impl.hrm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jeecg.kxcomm.entity.hrm.TbCheckingInstanceEntity;
import jeecg.kxcomm.entity.hrm.TbEmployeeEntity;
import jeecg.kxcomm.entity.hrm.TbOrgenEntity;
import jeecg.kxcomm.service.hrm.TbCheckingInstanceServiceI;
import jeecg.system.pojo.base.TSUser;

import org.hibernate.SQLQuery;
import org.jeecgframework.core.common.hibernate.qbc.HqlQuery;
import org.jeecgframework.core.common.hibernate.qbc.PageList;
import org.jeecgframework.core.common.hibernate.qbc.PagerUtil;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("tbCheckingInstanceService")
@Transactional
public class TbCheckingInstanceServiceImpl extends CommonServiceImpl implements TbCheckingInstanceServiceI {

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
	@Override
	public PageList getPageList(HqlQuery hqlQuery, boolean b,TbCheckingInstanceEntity tbCheckingInstance, String starttime, String endtime, String empname) {
		//条件拼接，根据登陆不同的角色，看到的订单不同
		StringBuffer whereSql = new StringBuffer();
		if(null != starttime && !("").equals(starttime)) {
			whereSql.append(" and date_format(a.happenday,'%Y-%m-%d') >= date_format('"+starttime+" 00:00:00','%Y-%m-%d') ");
		}
		if(null != endtime && !("").equals(endtime)) {
			whereSql.append(" and date_format(a.happenday,'%Y-%m-%d') <= date_format('"+endtime+" 23:59:59','%Y-%m-%d') ");
		}
		if(null != empname && !("").equals(empname)) {
			whereSql.append(" and b.emp_name like '%"+empname+"%' ");
		}
		//主干sql
		StringBuffer hql = new StringBuffer();
		hql.append(" select max(a.id),sum(a.emp_due),sum(a.emp_actual),sum(a.neglect_work),sum(a.emp_late)," +
				"sum(a.leave_early),sum(a.overtime),sum(a.emp_leave),sum(a.emp_away),sum(a.weekend_overtime)," +
				"b.id,max(b.emp_name),max(c.perm_name) ");
		hql.append(" from tb_checking_instance a,tb_employee b,tb_orgen c where 1=1 and a.emp_id = b.id and b.orgen_id = c.id ");
		hql.append(whereSql.toString());
		hql.append("group by b.id");
		hqlQuery.setQueryString(hql.toString());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("1", 1);
		hqlQuery.setMap(map);
		hqlQuery.setClass1(TbCheckingInstanceEntity.class);
		
		SQLQuery query = getSession().createSQLQuery(hqlQuery.getQueryString());
		int allCounts = query.list().size();
		int curPageNO = hqlQuery.getCurPage();
		int offset = PagerUtil.getOffset(allCounts, curPageNO, hqlQuery.getPageSize());
		query.setFirstResult(offset);
		query.setMaxResults(hqlQuery.getPageSize());
	 	List list= query.list();
		List<TbCheckingInstanceEntity> volist = new ArrayList<TbCheckingInstanceEntity>();
		Object[]  obj = new Object[volist.size()];
		for (int i = 0; i < list.size(); i++) {
			obj = (Object[]) list.get(i);
			TbCheckingInstanceEntity vo = new TbCheckingInstanceEntity();
			vo.setId(""+obj[0]);
			vo.setEmpDue(Integer.parseInt(""+obj[1]));
			vo.setEmpActual(Integer.parseInt(""+obj[2]));
			vo.setNeglectWork(Integer.parseInt(""+obj[3]));
			vo.setEmpLate(Integer.parseInt(""+obj[4]));
			vo.setLeaveEarly(Integer.parseInt(""+obj[5]));
			vo.setOvertime(Integer.parseInt(""+obj[6]));
			vo.setEmpLeave(Integer.parseInt(""+obj[7]));
			vo.setEmpAway(Integer.parseInt(""+obj[8]));
			vo.setWeekendOvertime(Integer.parseInt(""+obj[9]));
			TbEmployeeEntity employeeEntity = new TbEmployeeEntity();
			employeeEntity.setId(""+obj[10]);
			employeeEntity.setEmpName(""+obj[11]);
			TbOrgenEntity entity = new TbOrgenEntity();
			entity.setPermName(""+obj[12]);
			employeeEntity.setOrgenId(entity);
			vo.setEmpId(employeeEntity);
			volist.add(vo);
		}
		return new PageList(hqlQuery, volist, offset, curPageNO, allCounts);
	}
}