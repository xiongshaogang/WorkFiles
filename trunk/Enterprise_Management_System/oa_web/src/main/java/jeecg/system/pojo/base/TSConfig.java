package jeecg.system.pojo.base;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.core.common.entity.IdEntity;

/**
 * TConfig entity. @author MyEclipse Persistence Tools
 * 系统配置类
 */
@Entity
@Table(name = "t_s_config")
public class TSConfig extends IdEntity implements java.io.Serializable {

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userid")
	private TSUser TSUser;
	
	@Column(name = "code", length = 100)
	private String code;
	
	@Column(name = "name", nullable = false, length = 100)
	private String name;
	
	@Column(name = "content", length = 300)
	private String contents;
	
	@Column(name = "note", length = 300)
	private String note;

	
	public TSUser getTSUser() {
		return this.TSUser;
	}

	public void setTSUser(TSUser TSUser) {
		this.TSUser = TSUser;
	}
	
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	
	public String getContents() {
		return this.contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	
	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}