package jeecg.kxcomm.entity.contactm;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.core.annotation.excel.Excel;
import org.jeecgframework.core.annotation.excel.ExcelEntity;

import javax.persistence.SequenceGenerator;

/**   
 * @Title: Entity
 * @Description: 产品明细
 * @author zhangdaihao
 * @date 2013-09-24 15:45:02
 * @version V1.0   
 *
 */
@Entity
@Table(name = "tb_order_detail", schema = "")
@SuppressWarnings("serial")
public class TbOrderDetailEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**orderId*/
	private java.lang.String orderId;
	@ExcelEntity
	private TbOrderEntity tbOrder = new TbOrderEntity();
	/**name*/
	@Excel(exportName="商品名称",exportFieldWidth=20,exportConvertSign=0, importConvertSign = 0)
	private java.lang.String name;
	/**type*/
	@Excel(exportName="商品类型",exportFieldWidth=20,exportConvertSign=0, importConvertSign = 0)
	private java.lang.String type;
	/**price*/
	@Excel(exportName="商品单价",exportFieldWidth=20,exportConvertSign=0, importConvertSign = 0)
	private java.lang.String price;
	/**number*/
	@Excel(exportName="商品数量",exportFieldWidth=20,exportConvertSign=0, importConvertSign = 0)
	private java.lang.String number;
	/**totalprice*/
	@Excel(exportName="商品价格",exportFieldWidth=20,exportConvertSign=0, importConvertSign = 0)
	private java.lang.String totalprice;
	/**
	 * 采购价
	 */
	@Excel(exportName="采购价格",exportFieldWidth=20,exportConvertSign=0, importConvertSign = 0)
	private String purchaseprice;
	
	/**
	 * 采购状态,0 待采购|1 采购中|2 已采购
	 */
	private String status;
	
	
	@Column(name ="status",nullable=true,length=20)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name ="purchase_price",nullable=true,length=85)
	public String getPurchaseprice() {
		return purchaseprice;
	}

	public void setPurchaseprice(String purchaseprice) {
		this.purchaseprice = purchaseprice;
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=85)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  id
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
//	/**
//	 *方法: 取得java.lang.String
//	 *@return: java.lang.String  orderId
//	 */
//	@Column(name ="ORDER_ID",nullable=true,length=85)
//	public java.lang.String getOrderId(){
//		return this.orderId;
//	}
//
//	/**
//	 *方法: 设置java.lang.String
//	 *@param: java.lang.String  orderId
//	 */
//	public void setOrderId(java.lang.String orderId){
//		this.orderId = orderId;
//	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "order_id")
	public TbOrderEntity  getTbOrder() {
		return this.tbOrder;
	}

	public void setTbOrder(TbOrderEntity tbOrder) {
		this.tbOrder = tbOrder;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  name
	 */
	@Column(name ="NAME",nullable=true,length=85)
	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  name
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  type
	 */
	@Column(name ="TYPE",nullable=true,length=85)
	public java.lang.String getType(){
		return this.type;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  type
	 */
	public void setType(java.lang.String type){
		this.type = type;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  price
	 */
	@Column(name ="PRICE",nullable=true,length=85)
	public java.lang.String getPrice(){
		return this.price;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  price
	 */
	public void setPrice(java.lang.String price){
		this.price = price;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  number
	 */
	@Column(name ="NUMBER",nullable=true,length=85)
	public java.lang.String getNumber(){
		return this.number;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  number
	 */
	public void setNumber(java.lang.String number){
		this.number = number;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  totalprice
	 */
	@Column(name ="TOTALPRICE",nullable=true,length=85)
	public java.lang.String getTotalprice(){
		return this.totalprice;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  totalprice
	 */
	public void setTotalprice(java.lang.String totalprice){
		this.totalprice = totalprice;
	}
}
