package com.unicom.mms.gateway;

import java.util.Date;

/**
 * 
 * 群发彩信消息体<br/>
 * 
 * @author zhangjh 新增日期：2013-9-25
 * @since mms-share
 */
public class BatchSendMMS extends BaseMessage{
	private static final long serialVersionUID = 6320838727372728442L;
	/**
	 * 标题
	 */
	private String subject;
	/**
	 * 图片路径
	 */
	private String imagePath;
	/**
	 * 图片类型,见<code>SharePublicContants</code>的IMAGES_xxx
	 */
	private String imageType;
	
	/**
	 * 开始发送时间
	 */
	private Date startSendTime;
	/**
	 * 结束发送时间
	 */
	private Date endSendTime;
	
	public Date getStartSendTime() {
		return startSendTime;
	}
	public void setStartSendTime(Date startSendTime) {
		this.startSendTime = startSendTime;
	}
	public Date getEndSendTime() {
		return endSendTime;
	}
	public void setEndSendTime(Date endSendTime) {
		this.endSendTime = endSendTime;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getImageType() {
		return imageType;
	}
	public void setImageType(String imageType) {
		this.imageType = imageType;
	}
	@Override
	public String toString() {
		return "BatchSendMMS [subject=" + subject + ", imagePath=" + imagePath
				+ ", imageType=" + imageType + ", startSendTime="
				+ startSendTime + ", endSendTime=" + endSendTime
				+ ", getSender()=" + getSender() + ", getMsgSequence()="
				+ getMsgSequence() + ", getReceiver()=" + getReceiver()
				+ ", getChannel()=" + getChannel() + ", getMsgType()="
				+ getMsgType() + ", getContent()=" + getContent() + "]";
	}

}
