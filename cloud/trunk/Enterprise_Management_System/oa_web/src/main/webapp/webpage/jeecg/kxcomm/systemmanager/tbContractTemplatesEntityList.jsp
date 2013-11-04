<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="tbContractTemplatesEntityList" title="合同模板" actionUrl="tbContractTemplatesEntityController.do?datagrid" idField="id" fit="true" onClick="detail">
   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
   <t:dgCol title="名称" field="name" ></t:dgCol>
   <t:dgCol title="状态" field="status" replace="审核中_0,未审核_1,区域经理审核通过_2,区域经理审核未通过_3,法律人员审核通过_4,法律人员审核未通过_5,副经理审核通过_6,副经理审核未通过_7,经理审核通过_8,经理审核未通过_9"></t:dgCol>
   <t:dgCol title="创建时间" field="createTime" formatter="yyyy-MM-dd hh:mm:ss"></t:dgCol>
<%--    <t:dgCol title="操作" field="opt" width="100"></t:dgCol> --%>
<%--    <t:dgDelOpt title="删除" url="tbContractTemplatesEntityController.do?del&id={id}&status={status}" /> --%>
<%--    <t:dgFunOpt funname="detail(id,status)" title="明细"></t:dgFunOpt> --%>
   <t:dgToolBar title="录入" icon="icon-add" url="tbContractTemplatesEntityController.do?addorupdate" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbContractTemplatesEntityController.do?addorupdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="删除" icon="icon-remove" url="tbContractTemplatesEntityController.do?del" funname="delone"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbContractTemplatesEntityController.do?addorupdate" funname="detail"></t:dgToolBar>
  </t:datagrid>
  </div>
  
  <div region="south" style="height:300px;overflow: hidden;" split="true" border="false">
	<div class="easyui-panel" title="" style="padding:1px;" fit="true" border="false" id="contractTemplatesDetailpanel"></div>
  </div>
 </div>
 
<script type="text/javascript">
 function detail(rowIndex, rowData) {
	 $('#contractTemplatesDetailpanel').panel("refresh", "tbContractTemplatesEntityController.do?queryInfo&temple_id="+rowData.id+"&statsvalues=" +rowData.status);
 }
 
 function delone(title,url, id) {
	 	var rowData = $('#'+id).datagrid('getSelected');
	 	if (!rowData) {
	 		tip('请选择删除模板');
	 		return;
	 	}
	 	url += '&id='+rowData.id+'&status='+rowData.status;
	 	delObj(url,id);	 	
 }
</script>