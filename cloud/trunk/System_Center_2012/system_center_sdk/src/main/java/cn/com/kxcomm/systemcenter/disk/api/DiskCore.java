package cn.com.kxcomm.systemcenter.disk.api;

import java.awt.List;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import sun.misc.Cleaner;

import cn.com.kxcomm.common.constant.BusinessConstants;
import cn.com.kxcomm.systemcenter.Command;
import cn.com.kxcomm.systemcenter.MapsCore;
import cn.com.kxcomm.systemcenter.entity.Maps;
import cn.com.kxcomm.util.AppConfig;

/**
 * 
* 功能描述:硬盘api
* 版权所有：康讯通讯
* 未经本公司许可，不得以任何方式复制或使用本程序任何部分
* @author chenliang 新增日期：2013-10-22
* @author chenliang 修改日期：2013-10-22
* @since system_center_sdk
 */
public class DiskCore extends MapsCore {

	private static final Logger LOGGER = Logger.getLogger(DiskCore.class);
	
	//powershell输出字段值
	private static String output  = "OperatingSystem,VHDType,VHDFormatType,MaximumSize,Location,State,Size,HostName,VMHost,Owner,Name,Description,AddedTime,ModifiedTime,Enabled,MostRecentTask,MostRecentTaskIfLocal";
	/**
	 * 
	* 方法用途和描述: 获取硬盘信息
	* @return
	* @author chenliang 新增日期：2013-10-31
	* @since system_center_sdk
	 */
	public static GetHardDisk getHardDisk(String vmname){
		return new GetHardDisk(vmname);
	}
	
	/**
	 * 
	* 方法用途和描述: 获取库中的vhdx信息
	* @param libServer
	* @return
	* @author chenliang 新增日期：2013-10-31
	* @since system_center_sdk
	 */
	public static GetVhdxInLib getVhdxInLib(String libServer){
		return new GetVhdxInLib(libServer);
	}
	
	//获取硬盘信息
	public static class GetHardDisk implements Command<Maps>{

		private String vmname; //虚拟机名字
		
		public GetHardDisk(String vmname){
			this.vmname =  vmname;
		}
		
		@Override
		public Maps execute(String clientType) throws Exception {
			try {
				if(BusinessConstants.TYPE_SYSTEMCENTER.equals(clientType)){
					LOGGER.info("SystemCenter execute.");
					StringBuffer diskCommand = new StringBuffer();
					diskCommand.append("Get-SCVirtualHardDisk");
					if(null != vmname && !"".equals(vmname)){
						diskCommand.append(" -vm \""+vmname+"\" ");
					}
					Maps maps = executeScript(diskCommand.toString(), output);
					return maps;
				}else if(BusinessConstants.TYPE_OPENSTACK.equals(clientType)){
					LOGGER.info("OpenStack execute.");
				}else {
					LOGGER.info("Other execute.");
				}
				return null;
			} catch (Exception e) {
				LOGGER.error("Exception Get HardDisk error.",e);
				throw e;
			}
		}
		
	}
	
	//获取某库中所有的vhdx
	public static class GetVhdxInLib implements Command<Maps>{

		private String libServer;
		
		public GetVhdxInLib(String libServer){
			this.libServer = libServer;
		}
		
		@Override
		public Maps execute(String clientType) throws Exception {
			try {
				AppConfig appconfig = AppConfig.getInstance();
				String vmmServer = appconfig.getString("vmmServer");
				if(null == vmmServer || "".equals(vmmServer)){
					LOGGER.info("error vmmServer is null.");
					throw new Exception("Exception vmmServer is null.");
				}
				if(BusinessConstants.TYPE_SYSTEMCENTER.equals(clientType)){
					LOGGER.info("SystemCenter execute.");
					StringBuffer vhdxCommand = new StringBuffer();
					vhdxCommand.append("Get-SCVirtualHardDisk -VMMServer \""+vmmServer+"\" | where { $_.LibraryServer -eq \""+libServer+"\"}");
					Maps maps = executeScript(vhdxCommand.toString(), output);
					return maps;
				}else if(BusinessConstants.TYPE_OPENSTACK.equals(clientType)){
					LOGGER.info("OpenStack execute.");
				}else {
					LOGGER.info("Other execute.");
				}
				return new Maps();
			} catch (Exception e) {
				LOGGER.error("Execption getVhdxInLib error.",e);
				throw e;
			}
		}
		
	}
	
}
