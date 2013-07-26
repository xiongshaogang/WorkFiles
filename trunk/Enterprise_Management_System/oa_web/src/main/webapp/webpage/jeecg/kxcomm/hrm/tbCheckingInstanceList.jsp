<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
<!--   <div id="tbCheckingInstanceListtb" style="padding: 3px; height: 25px"> -->
<!-- 			<div style="float: left;"> -->
<!-- 				<a href="tbCheckingInstanceController.do?addorupdate" class="easyui-linkbutton" iconCls="icon-add" -->
<!-- 					onclick="tbCheckingInstanceListadd()">新增</a> -->
<!-- 				<a href="tbCheckingInstanceController.do?addorupdate" class="easyui-linkbutton" iconCls="icon-edit" -->
<!-- 					onclick="tbCheckingInstanceListedit()">编辑</a> -->
<!-- 				开始时间:<input class="Wdate" onClick="WdatePicker()" -->
<!-- 					style="width: 150px" name="happenday" ignore="ignore"> -->
<!-- 				截止时间:<input class="Wdate" onClick="WdatePicker()" -->
<!-- 					style="width: 150px" name="empId.birthday" ignore="ignore"> <a -->
<!-- 					href="#" class="easyui-linkbutton" iconCls="icon-search" -->
<!-- 					onclick="tbCheckingInstanceListsearch()">查询</a> -->
<!-- 			</div> -->
<!-- 	</div> -->
		<t:datagrid name="tbCheckingInstanceList" actionUrl="tbCheckingInstanceController.do?datagrid" idField="id" fit="true">
	   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	   <t:dgCol title="主键id" field="empId" hidden="false"></t:dgCol>
	   <t:dgCol title="时间" field="happenday" formatter="yyyy-MM-dd"></t:dgCol>
	   <t:dgCol title="员工姓名" field="empId_empName" ></t:dgCol>
	   <t:dgCol title="机构名称" field="empId_orgenId_permName" ></t:dgCol>
	   <t:dgCol title="应到" field="empDue" ></t:dgCol>
	   <t:dgCol title="实到" field="empActual" ></t:dgCol>
	   <t:dgCol title="旷工" field="neglectWork" ></t:dgCol>
	   <t:dgCol title="迟到" field="empLate" ></t:dgCol>
	   <t:dgCol title="早退" field="leaveEarly" ></t:dgCol>
	   <t:dgCol title="加班" field="overtime" ></t:dgCol>
	   <t:dgCol title="请假" field="empLeave" ></t:dgCol>
	   <t:dgCol title="公出" field="empAway" ></t:dgCol>
	   <t:dgCol title="周末-加班" field="weekendOvertime" ></t:dgCol>
	   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	   <t:dgDelOpt title="删除" url="tbCheckingInstanceController.do?del&id={id}" />
	   <t:dgDelOpt title="详情" url="tbCheckingInstanceController.do?del&id={id}" />
	   <t:dgToolBar title="录入" icon="icon-add" url="tbCheckingInstanceController.do?addorupdate" funname="add"></t:dgToolBar>
	   <t:dgToolBar title="编辑" icon="icon-edit" url="tbCheckingInstanceController.do?addorupdate" funname="update"></t:dgToolBar>
	   <t:dgToolBar title="查看" icon="icon-search" url="tbCheckingInstanceController.do?queryInfo" funname="detail"></t:dgToolBar>
	  </t:datagrid>
  </div>
</div>