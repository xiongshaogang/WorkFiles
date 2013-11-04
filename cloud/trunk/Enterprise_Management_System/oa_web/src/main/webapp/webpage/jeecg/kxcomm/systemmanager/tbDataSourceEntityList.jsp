<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <div class="easyui-panel" style="padding:1px;" fit="true"  border="false" id="dataSourceDetailPanel">
  <t:datagrid name="tbDataSourceEntityList" title="数据源" actionUrl="tbDataSourceEntityController.do?datagrid" idField="id" fit="true">
   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
   
   <t:dgCol title="数据源名称" field="sourcename" ></t:dgCol>
   <t:dgCol title="描述" field="description" ></t:dgCol>
   <t:dgCol title="创建时间" field="createtime" formatter="yyyy-MM-dd"></t:dgCol>
   
   <t:dgToolBar title="上传" icon="icon-add" url="tbDataSourceEntityController.do?addorupdate" funname="openuploadwin"></t:dgToolBar>
   <t:dgToolBar title="添加数据明细" icon="icon-add" url="tbDataRecordEntityController.do?addorupdate" funname="add"></t:dgToolBar>
   <t:dgToolBar title="查看详情" icon="icon-search" url="tbDataSourceEntityController.do?dataSourceDetail" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="删除" icon="icon-remove" url="tbDataSourceEntityController.do?del" funname="delone"></t:dgToolBar>
  </t:datagrid>
  </div>
  </div>
 </div>
 <script type="text/javascript">
 function detail(title,url, id){
	 var rowData = $('#'+id).datagrid('getSelected');
		if (!rowData) {
			tip('请选择查看项目');
			return;
		}
	url += '&id='+rowData.id;
	$('#dataSourceDetailPanel').panel("refresh", url);
 }
//********************
 function delone(title,url, id) {
 	var rowData = $('#'+id).datagrid('getSelected');
 	if (!rowData) {
 		tip('请选择删除项目');
 		return;
 	}
 	
 	url += '&id='+rowData.id;
 	delObj(url,id);
 	
 }
</script>