package jeecg.system.pojo.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 系统用户父类表
 * 
 */
@Entity
@Table(name = "t_s_base_user")
@Inheritance(strategy = InheritanceType.JOINED)
public class TSBaseUser extends IdEntity implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	
	@Column(name = "username", nullable = false, length = 50)
	private String userName;// 用户名
	
	@Column(name = "realname", length = 50)
	private String realName;// 真实姓名
	
	@Column(name = "browser", length = 20)
	private String browser;// 用户使用浏览器类型
	
	@Column(name = "userkey", length = 200)
	private String userKey;// 用户验证唯一标示
	
	@Column(name = "password", length = 100)
	private String password;//用户密码
	
	@Column(name = "activitisync")
	private Short activitiSync;//是否同步工作流引擎
	
	@Column(name = "status" )
	private Short status;// 状态1：在线,2：离线,0：禁用
	
	@Column(name = "signature")
	private byte[] signature;// 签名文件
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "departid")
	private TSDepart TSDepart = new TSDepart();// 部门
	
	
	public byte[] getSignature() {
		return signature;
	}
	public void setSignature(byte[] signature) {
		this.signature = signature;
	}

	
	public String getBrowser() {
		return browser;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}

	
	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	
	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}
	public Short getActivitiSync() {
		return activitiSync;
	}
	
	public void setActivitiSync(Short activitiSync) {
		this.activitiSync = activitiSync;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public TSDepart getTSDepart() {
		return this.TSDepart;
	}

	public void setTSDepart(TSDepart TSDepart) {
		this.TSDepart = TSDepart;
	}
	
	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getRealName() {
		return this.realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

}