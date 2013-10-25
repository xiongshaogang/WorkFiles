package com.unicom.mms.mcp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Service;

import com.unicom.mms.entity.TbContacts;
import com.unicom.mms.entity.TbGroupContacts;
import com.unicom.mms.entity.TbGroups;
import com.unicom.mms.mcp.dao.ContactsDAO;
import com.unicom.mms.mcp.dao.GroupContactsDAO;
/***
 * 
* 功能描述:联系人
* <p>版权所有：中太数据
* <p>未经本公司许可，不得以任何方式复制或使用本程序任何部分
*
* @author 刘小明 新增日期：2013-2-18
* @author 你的姓名 修改日期：2013-2-18
* @since mms-mcp
 */
@Service("contactsService")
public class ContactsService {
	@Autowired(required = true)
	private ContactsDAO contactsDAO;
	@Autowired(required = true)
	private GroupContactsDAO groupContactsDAO;
	public void saveOrUpdate(List<TbContacts> list)throws RuntimeException{
		if(list!=null&&!list.isEmpty()){
			this.contactsDAO.getHibernateTemplate().saveOrUpdateAll(list);
		}
	}
	
	public void saveOrUpdate(TbContacts entity,int groupId)throws RuntimeException{
			System.out.println(entity+ " "+ groupId+" fffff");
			this.contactsDAO.getHibernateTemplate().saveOrUpdate(entity);
			if(groupId!=0){
				System.out.println(entity+ " "+ groupId+" ffffff");
				TbGroups tg = new TbGroups();
				tg.setId(groupId);
				TbContacts tc = entity;
				TbGroupContacts tgc = new TbGroupContacts();
				tgc.setContacts(tc);
				tgc.setGroups(tg);
				groupContactsDAO.getHibernateTemplate().saveOrUpdate(tgc);
			}
	}
		
	public void delete(TbContacts entity,int groupId)throws RuntimeException{
		
		System.out.println("ffff"+groupId);
		if(groupId!=0){
			TbGroups tg = new TbGroups();
			tg.setId(groupId);
			TbContacts tc = entity;
			TbGroupContacts tgc = new TbGroupContacts();
			tgc.setContacts(tc);
			tgc.setGroups(tg);
			String hql = "delete TbGroupContacts tgc where tgc.groups.id ="+groupId+" and tgc.contacts.id="+entity.getId();
			Object[] obj = null;
			//TODO 。。。重写这个方法 
//			groupContactsDAO.deleteByHql(hql, obj);
		}
		this.contactsDAO.getHibernateTemplate().delete(entity);
}
}
