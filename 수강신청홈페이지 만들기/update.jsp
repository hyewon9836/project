<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>수강신청 사용자 정보 수정</title></head>	
<body>
	<%@ include file="top.jsp"%>
	<%
   if (session_id==null) 
      response.sendRedirect("login.jsp"); 
	%>
	<%
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "db1816461"; String passwd = "oracle";
		
		Connection myConn = null; 
		Statement stmt = null;
		ResultSet myResultSet = null; 
		String mySQL = "";

		String userPassword=""; String userName="";

			try {
				
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection (dburl, user, passwd);
				stmt = myConn.createStatement();	
				mySQL = "select s_name, s_pwd from student where s_id='" + session_id + "'" ;
				myResultSet = stmt.executeQuery(mySQL);
				}
			
				catch(SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
				
				}finally{
					if(myResultSet != null) {
						if(myResultSet.next()) {
							userName = myResultSet.getString("s_name");
							userPassword = myResultSet.getString("s_pwd");
						}
					}
				}
		
		%>

		<form method="post" action="update_verify.jsp">
		<br>
		<table align ="center" border id="update_table">
					<tr>
				 	<td align="center" id="update_td">아이디</td>
					 <td align="center" colspan="3"><input id="update_id_in" type="text" name="id" size="50" style="text-align: center;" value="<%=session_id%>" ReadOnly></td>
					</tr>
					<tr>
					<td align="center" id="update_td">이름</td>
					<td align="center" colspan="3"><input id="update_name_in" type="text" name="name" size="50" style="text-align: center;" value="<%=userName%>"></td>
					</tr>
					<tr>
					  <td align="center" id="update_td">비밀번호</td>
					  <td><input id="update_pw_in" type="password" name="password" size="20" value=<%=userPassword%>></td>
					  <td id="update_td">확인</td>
					  <td><input id="update_pw_in" type="password" name="passwordConfirm" size="20" ></td>
					</tr>
					 <tr>
					  <td colspan="5"><div align="center">
					  <input id="update_btn" type="SUBMIT" NAME="Submit" size="30" style="text-align:center;" value="수정 완료" ></div></td>
					 </tr>
					 </table>
					</form>
				<% 
				stmt.close(); 
				myConn.close();
				%>
		</body>
		</html>
