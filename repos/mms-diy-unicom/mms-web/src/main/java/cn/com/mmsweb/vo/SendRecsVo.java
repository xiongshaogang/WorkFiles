package cn.com.mmsweb.vo;

public class SendRecsVo {
   private String id;
   private String picUrl;     //地址
   private String sendTime;   //发送时间
   private String sendType;  //发送类型
   private String userName;
   private String reciver;   //接收人号码
   private String musicUrl;  //音乐地址
   private String title;   //标题
   
   
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getPicUrl() {
	return picUrl;
}
public void setPicUrl(String picUrl) {
	this.picUrl = picUrl;
}
public String getSendTime() {
	return sendTime;
}
public void setSendTime(String sendTime) {
	this.sendTime = sendTime;
}
public String getSendType() {
	return sendType;
}
public void setSendType(String sendType) {
	this.sendType = sendType;
}
public String getUserName() {
	return userName;
}
public void setUserName(String userName) {
	this.userName = userName;
}
public String getReciver() {
	return reciver;
}
public void setReciver(String reciver) {
	this.reciver = reciver;
}
public String getMusicUrl() {
	return musicUrl;
}
public void setMusicUrl(String musicUrl) {
	this.musicUrl = musicUrl;
}
@Override
public String toString() {
	return "SendRecsVo [id=" + id + ", picUrl=" + picUrl + ", sendTime="
			+ sendTime + ", sendType=" + sendType + ", userName=" + userName
			+ ", reciver=" + reciver + ", musicUrl=" + musicUrl + ", title="
			+ title + "]";
}

   
}
   
