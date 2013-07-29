<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>员工表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
 </head>
 <body style="overflow-y: hidden" scroll="no">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tbEmployeeController.do?save">
			<input id="id" name="id" type="hidden" value="${tbEmployeePage.id }">
			<table style="width: 800px;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
			<td colspan="4" bgcolor="#BFEFFF" style="font-size: 14px;">员工基本信息</td>
			</tr>
				<tr>
				<td align="right">
						<label class="Validform_label">
							工号:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="jobNo" name="jobNo" 
							   value="${tbEmployeePage.jobNo}" datatype="s1-20">
						<span class="Validform_checktip"></span>
					</td>
				<td align="right">
						<label class="Validform_label">
							员工姓名:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="empName" name="empName" 
							   value="${tbEmployeePage.empName}" datatype="s2-50">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
				
					<td align="right">
						<label class="Validform_label">
							身份证:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="identityCard" name="identityCard" 
							   value="${tbEmployeePage.identityCard}" datatype="s6-18">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							出生年月:
						</label>
					</td>
					<td class="value">
						<input class="Wdate" onClick="WdatePicker()"  style="width: 150px" id="birthday" name="birthday" ignore="ignore"
							   value="<fmt:formatDate value='${tbEmployeePage.birthday}' type="date" pattern="yyyy-MM-dd"/>">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							家庭地址:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="address" name="address" datatype="s0-100"
							   value="${tbEmployeePage.address}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							联系电话:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="orgenPhone" name="orgenPhone" datatype="s0-11"
							   value="${tbEmployeePage.orgenPhone}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							籍贯:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="nativePlace" name="nativePlace" datatype="s0-10"
							   value="${tbEmployeePage.nativePlace}">
						<span class="Validform_checktip"></span>
					</td>
						<td align="right">
						<label class="Validform_label">
							户口所在地:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="domicilePlace" name="domicilePlace" datatype="s0-50"
							   value="${tbEmployeePage.domicilePlace}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
				<td align="right">
						<label class="Validform_label">
							户口性质:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="householdProperties" name="householdProperties" datatype="s0-2"
							   value="${tbEmployeePage.householdProperties}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							直系亲属:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="immediateFamily" name="immediateFamily" datatype="s0-50"
							   value="${tbEmployeePage.immediateFamily}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							毕业时间:
						</label>
					</td>
					<td class="value">
						<input class="Wdate" onClick="WdatePicker()"  style="width: 150px" id="graduationDate" name="graduationDate" ignore="ignore"
							   value="<fmt:formatDate value='${tbEmployeePage.graduationDate}' type="date" pattern="yyyy-MM-dd"/>">
						<span class="Validform_checktip"></span>
					</td>
						<td align="right">
						<label class="Validform_label">
							毕业学校:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="graduateSchool" name="graduateSchool" datatype="s0-50"
							   value="${tbEmployeePage.graduateSchool}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							专业:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="major" name="major" datatype="s0-20"
							   value="${tbEmployeePage.major}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							学历:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="educationBackground" name="educationBackground" datatype="s0-20"
							   value="${tbEmployeePage.educationBackground}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							婚否:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="marry" name="marry" datatype="s0-20"
							   value="${tbEmployeePage.marry}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							民族:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="nation" name="nation" datatype="s0-20"
							   value="${tbEmployeePage.nation}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							性别:
						</label>
					</td>
					<td class="value">
						<select id="sex"  name="sex"  datatype="*">
					        <option value="1"  >
					        男
					        </option>
					           <option value="2">
					        女
					        </option>
				      	</select>
						<span class="Validform_checktip">请选择性别</span>
					</td>
					<td align="right">
						<label class="Validform_label">
							政治面貌:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="politicsStatus" name="politicsStatus" datatype="s0-20"
							   value="${tbEmployeePage.politicsStatus}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
			<td colspan="4" bgcolor="#BFEFFF" style="font-size: 14px;">公司信息</td>
			</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							所属机构:
						</label>
					</td>
					<td class="value">
						<select id="orgenId.id"  name="orgenId.id"  datatype="*">
					       <c:forEach items="${orgenList}" var="orgen">
					        <option value="${orgen.id }"  <%-- <c:if test="${depart.id==tbOrdersPage.channelId.id}">selected="selected"</c:if> --%>>
					         ${orgen.permName}
					        </option>
					       </c:forEach>
				      	</select>
						<span class="Validform_checktip">请选择机构</span>
					</td>
						<td align="right">
						<label class="Validform_label">
							所属岗位:
						</label>
					</td>
					<td class="value">
						<select id="postId.id"  name="postId.id"  datatype="*">
					       <c:forEach items="${postList}" var="post">
					        <option value="${post.id }"  <%-- <c:if test="${depart.id==tbOrdersPage.channelId.id}">selected="selected"</c:if> --%>>
					         ${post.postName}
					        </option>
					       </c:forEach>
				      	</select>
						<span class="Validform_checktip">请选择岗位</span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							入职时间:
						</label>
					</td>
					<td class="value">
						<input class="Wdate" onClick="WdatePicker()"  style="width: 150px" id="datesEmployed" name="datesEmployed" ignore="ignore"
							   value="<fmt:formatDate value='${tbEmployeePage.datesEmployed}' type="date" pattern="yyyy-MM-dd"/>">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							司龄:
						</label>
					</td>
					<td class="value">
							<input class="inputxt" id="workingTime" name="workingTime" datatype="s0-50"
							   value="${tbEmployeePage.workingTime}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							邮箱:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="eMail" name="eMail" datatype="s0-50"
							   value="${tbEmployeePage.eMail}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							状态:
						</label>
					</td>
					<td class="value">
						<select id="status"  name="status"  datatype="*">
					        <option value="1"  <%-- <c:if test="${depart.id==tbOrdersPage.channelId.id}">selected="selected"</c:if> --%>>
					        正式员工
					        </option>
					             <option value="2">
					        实习员工
					        </option>
				      	</select>
						<span class="Validform_checktip">请选择岗位</span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							银行卡开户行:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="openingBank" name="openingBank" datatype="s0-50"
							   value="${tbEmployeePage.openingBank}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							银行卡号:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="cardNo" name="cardNo" datatype="s0-20"
							   value="${tbEmployeePage.cardNo}" datatype="d">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							职称:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="jobTitle" name="jobTitle" datatype="s0-20"
							   value="${tbEmployeePage.jobTitle}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							职称级别:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="titleLevel" name="titleLevel" datatype="s0-20"
							   value="${tbEmployeePage.titleLevel}">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							岗位变动:
						</label>
					</td>
					<td class="value">
						<input class="inputxt" id="changeJobs" name="changeJobs" datatype="s0-20"
							   value="${tbEmployeePage.changeJobs}">
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label">
							社保保险缴费起始月:
						</label>
					</td>
					<td class="value">
						<input class="Wdate" onClick="WdatePicker()"  style="width: 150px" id="socialSecurityTime" name="socialSecurityTime" ignore="ignore"
							   value="<fmt:formatDate value='${tbEmployeePage.socialSecurityTime}' type="date" pattern="yyyy-MM-dd"/>">
						<span class="Validform_checktip"></span>
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>