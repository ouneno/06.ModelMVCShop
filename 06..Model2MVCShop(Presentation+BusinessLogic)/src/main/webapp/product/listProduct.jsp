<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
<%@ page import="java.util.*"%>
<%@ page import="com.model2.mvc.common.*"%>
<%@ page import="com.model2.mvc.service.domain.*" %>


<%
	HashMap<String, Object> map = (HashMap<String, Object>) request.getAttribute("map");
	Search search = (Search) request.getAttribute("search");
   
   int total = 0;
   List<Product> list = null;
   if (map != null) {
      total = ((Integer) map.get("count")).intValue();
      list = (List<Product>) map.get("list");
   }
   
   int currentPage = search.getCurrentPage();
   
   int totalPage = 0;
   if (total > 0) {
      totalPage = total / search.getPageSize();
      if (total % search.getPageSize() > 0)
         totalPage += 1;
   }
   
   int pageGroup = currentPage % 5;
   int startPage = currentPage / 5 * 5 + 1;
   if(pageGroup == 0) startPage -= 5;
   int endPage = startPage + 4;
   if( endPage > totalPage ) endPage = totalPage;
   
   String menu = (String)session.getAttribute("menu");
--%>




<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetProductList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listProduct.do?menu=${! empty menu && menu == 'manage' ? 'manage' : 'search'}"  method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					
					<td width="93%" class="ct_ttl-01">${!empty menu && menu == 'manage' ? "��ǰ����" : "��ǰ�����ȸ"}</td>
							
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
								<option value="0" ${ search.searchCondition eq '0' ? 'selected' : '' }>��ǰ��ȣ</option>
								<option value="1" ${ search.searchCondition eq '1' ? 'selected' : '' }>��ǰ��</option>
								<option value="2" ${ search.searchCondition eq '2' ? 'selected' : '' }>��ǰ����</option>
			</select>
			<input 	type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
						class="ct_input_g"  style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList('1');">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			��ü ${ resultPage.totalCount } �Ǽ�, ����  ${ resultPage.currentPage } ������
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:set var="i" value="0" />
		<c:forEach var="product" items="${list}">
	<c:set var="i" value="${ i+1 }" />
		
	
	<tr class="ct_list_pop">
		<td align="center">${ i }</td>
		<td></td>
		<td align="left">
			
		<c:if test="${menu=='manage'}">
		<a href="/updateProductView.do?prodNo=${product.prodNo}&${! empty menu && menu == 'manage' ? 'menu=manage' : 'menu=search'}">${product.prodName} </a>	
		</c:if>
		<c:if test="${menu=='search'}">
		<a href="/getProduct.do?prodNo=${product.prodNo}&${! empty menu && menu == 'search' ? 'menu=search' : 'menu=manage'}">${product.prodName} </a>	
		</c:if>
			
		</td>
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="left">${product.regDate}</td>
		<td></td>
						<td align="left">
						<c:if test="${ user.role eq 'admin' && menuType eq 'manage' }"> 
							<c:choose>
								<c:when test="${ product.proTranCode eq '0' }">
									�Ǹ���
								</c:when>
								<c:when test="${ product.proTranCode eq '1' }">
									�����Ϸ�
									<a href="updateTranCodeByProd.do?prodNo=${ product.prodNo }&tranCode=2">����ϱ�</a>
								</c:when>
								<c:when test="${ product.proTranCode eq '2' }">
									�����
								</c:when>
								<c:when test="${ product.proTranCode eq '3' }">
									��ۿϷ�
								</c:when>
			               </c:choose>
		               </c:if>
		               <c:if test="${!( user.role eq 'admin' && menuType eq 'manage' )}"> 
		                   <c:choose>
								<c:when test="${ product.proTranCode eq '0' }">
									�Ǹ���
								</c:when>
								<c:otherwise>
									������
								</c:otherwise>
							</c:choose> 
		               </c:if>
					</td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
				<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
			�� ����
	</c:if>
	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
			<a href="javascript:fncGetProductList('${ resultPage.currentPage-1}')">�� ����</a>
	</c:if>
	
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
		<a href="javascript:fncGetProductList('${ i }');">${ i }</a>
	</c:forEach>
	
	<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
			���� ��
	</c:if>
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
			<a href="javascript:fncGetProductList('${resultPage.endUnitPage+1}')">���� ��</a>
	</c:if>
			
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
