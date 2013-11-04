package cn.com.kxcomm.systemcenter.vm.service;

import java.util.List;

import cn.com.kxcomm.systemcenter.disk.model.HardDiskModel;
import cn.com.kxcomm.systemcenter.vm.model.VmModel;

/**
 * 
* 功能描述:虚拟机操作接口api
* 版权所有：康讯通讯
* 未经本公司许可，不得以任何方式复制或使用本程序任何部分
* @author chenliang 新增日期：2013-10-21
* @author chenliang 修改日期：2013-10-21
* @since system_center_sdk
 */
public interface VmServiceApi {
	
	/**
	 * 
	* 方法用途和描述: 启动虚拟机
	* @param vmname 虚拟机名称 
	* @return
	* @author chenliang 新增日期：2013-10-21
	* @since system_center_sdk
	 */
	public VmModel bootVM(String vmname)  throws Exception ;
	
	/**
	 * 
	* 方法用途和描述: 停止
	* @param vmname 虚拟机名称
	* @return
	* @author chenliang 新增日期：2013-10-21
	* @since system_center_sdk
	 */
	public VmModel shutDownVM(String vmname)  throws Exception ;
	
	/**
	 * 
	* 方法用途和描述: 获取所有的虚拟机
	* @return
	* @author chenliang 新增日期：2013-10-22
	* @since system_center_sdk
	 */
	public List<VmModel> getAllVM() throws Exception;
	
	
	/**
	 * 
	* 方法用途和描述: 创建虚拟机
	* @author chenliang 新增日期：2013-10-22
	* @since system_center_sdk
	 */
	public VmModel addVM(VmModel vmModel) throws Exception;
	
	/**
	 * 
	* 方法用途和描述: 设置vm的cpu大小
	* @param vmName vm名称
	* @param cupCount cpu个数
	* @author chenliang 新增日期：2013-10-23
	 * @throws Exception 
	* @since system_center_sdk
	 */
	public VmModel setVmCPU(String vmname,Integer cpu) throws Exception;
	
	/**
	 * 
	* 方法用途和描述: 设置vm的内存
	* @param vmname vm名称
	* @param memory 内存大小 单位MB
	* @author chenliang 新增日期：2013-10-23
	 * @throws Exception 
	* @since system_center_sdk
	 */
	public VmModel setVmMemory(String vmname,Integer memory) throws Exception;
	
	/**
	 * 
	* 方法用途和描述: 设置vm的硬盘
	* @param vmname
	* @param harddisk
	* @return
	* @throws Exception
	* @author chenliang 新增日期：2013-10-30
	* @since system_center_sdk
	 */
	public VmModel setVmHardDisk(String vmname,Integer harddisk) throws Exception;
	
	/**
	 * 
	* 方法用途和描述: 重置
	* @param vmname vm名称
	* @author chenliang 新增日期：2013-10-23
	 * @throws Exception 
	* @since system_center_sdk
	 */
	public VmModel resetVm(String vmname) throws Exception;
	
	/**
	 * 
	* 方法用途和描述: 删除vm
	* @param vmname
	* @throws Exception
	* @author chenliang 新增日期：2013-10-23
	* @since system_center_sdk
	 */
	public VmModel deleteVm(String vmname) throws Exception;
	
	/**
	 * 
	* 方法用途和描述: 恢复
	* @param vmname
	* @throws Exception
	* @author chenliang 新增日期：2013-10-24
	* @since system_center_sdk
	 */
	public VmModel resumeVm(String vmname) throws Exception;
	
	/**
	 * 
	* 方法用途和描述: 暂停
	* @param vmname
	* @throws Exception
	* @author chenliang 新增日期：2013-10-24
	* @since system_center_sdk
	 */
	public VmModel suspendVm(String vmname) throws Exception;
	
	
}
