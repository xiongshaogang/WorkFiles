package cn.com.mmsweb.service;


import java.util.List;

import cn.com.mmsweb.vo.PhotoFrameVo;

import com.unicom.mms.entity.TbUserPhoto;

public interface UserPhotoService extends CommonService<TbUserPhoto> {

	/**
	 * 
	* 方法用途和描述:查询页面需要展示的图片
	* @return
	* @author lizl 新增日期：2013-4-25
	* @since mms-web
	 */
	public List<PhotoFrameVo> queryUserPhotosPage(int pageSize, int pageNow,int pictype);
}
