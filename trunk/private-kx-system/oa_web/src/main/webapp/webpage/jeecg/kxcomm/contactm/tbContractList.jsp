<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="tbContractList" fitColumns="true" title="销售合同" actionUrl="tbContractController.do?datagrid" idField="id" fit="true">
   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
   <t:dgCol title="合同编号" field="contractNo" query="true"></t:dgCol>
   <t:dgCol title="合同金额" field="contractPrice" ></t:dgCol>
   <t:dgCol title="开票日期" field="billingDate" formatter="yyyy-MM-dd "></t:dgCol>
   <t:dgCol title="到货款回款日期" field="daohuoPaymentDate" formatter="yyyy-MM-dd "></t:dgCol>
   <t:dgCol title="初验款回款日期" field="chuyanPaymentDate" formatter="yyyy-MM-dd "></t:dgCol>
   <t:dgCol title="终验款回款日期" field="zhongyanPaymentDate" formatter="yyyy-MM-dd "></t:dgCol>
   <t:dgCol title="合同归档日期" field="contractFilingDate" formatter="yyyy-MM-dd "></t:dgCol>
   <t:dgCol title="合同签订日期" field="contractSigningDate" formatter="yyyy-MM-dd "></t:dgCol>
   <t:dgCol title="备注" field="remark" ></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt funname="contractDetail(id)" title="产品明细"></t:dgFunOpt>
   <t:dgDelOpt title="删除" url="tbContractController.do?del&id={id}" />
   <t:dgToolBar title="录入" icon="icon-add" url="tbContractController.do?addorupdate" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbContractController.do?addorupdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbContractController.do?addorupdate" funname="detail"></t:dgToolBar>
  </t:datagrid>
  </div>
  
  <div region="south"  style="height:200px;overflow: hidden;" split="true" border="false">
	<div class="easyui-panel" title="产品信息" style="padding:1px;" fit="true" border="false" id="contractDetailpanel">
		
  	</div>
  </div>
 </div>
<script type="text/javascript">
 function contractDetail(id)
 {
	 $('#contractDetailpanel').panel("refresh", "tbContractController.do?contractDetail&id="+id);
 }
</script>