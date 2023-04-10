<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>수강신청 조회</title>
</head>

<body>
<%@ include file="top.jsp"%>
<%
	if (session_id==null) 
		response.sendRedirect("login.jsp"); 
%>
	<form id="select_form" method="post">
 	<table class="classtable" width="75%" align="center" border>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
			<th>학점</th>
		</tr>
		<%
			String result1 = null;
			String result2 = null;
			Connection myConn = null;
			Statement stmt = null;
			Statement stmt2 = null;
			ResultSet myResultSet = null;
			
			String SQL1 = "";
			String SQL2 = "";
			String mySQL = "";
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "db1816461"; String passwd = "oracle";
			
			try {
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection(dburl, user, passwd);
				stmt = myConn.createStatement();
			} catch (SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			}
			
			SQL1 = "{? = call Date2EnrollYear(SYSDATE)}";
			CallableStatement cstmt1 = myConn.prepareCall(SQL1);
			cstmt1.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt1.execute();
			int nYear = cstmt1.getInt(1);
			
		 	SQL2 = "{? = call Date2EnrollSemester(SYSDATE)}";
			CallableStatement cstmt2 = myConn.prepareCall(SQL2);
			cstmt2.registerOutParameter(1,java.sql.Types.INTEGER);
			cstmt2.execute();
			int nSemester = cstmt2.getInt(1);
			
			mySQL = "select c_id, c_name, c_id_no, c_unit from course where (c_id, c_id_no) in (select c_id, c_id_no from enroll where e_year ="
					+ nYear + " and e_semester ="+ nSemester + " and s_id='" + session_id + "')";
			myResultSet = stmt.executeQuery(mySQL);
						
			if (myResultSet != null) {
				while (myResultSet.next()) {
					String c_id = myResultSet.getString("c_id");
					String c_name = myResultSet.getString("c_name");
					int c_id_no = myResultSet.getInt("c_id_no");
					int c_unit = myResultSet.getInt("c_unit");
		%>
		<tr>
			<td width = "5%" align="center"><%=c_id%></td>
			<td  width = "3%" align="center"><%=c_id_no%></td>
			<td  width = "10%" align="center"><%=c_name%></td>
			<td width = "3%"  align="center"><%=c_unit%></td>
		</tr>
<%      
		}
		}
			CallableStatement cstmt = myConn.prepareCall("{call SelectTimeTable(?,?,?,?,?)}");
			cstmt.setString(1, session_id);
			cstmt.setInt(2, nYear);
			cstmt.setInt(3, nSemester);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			
			try {
				cstmt.execute();
				result1 = cstmt.getString(4);
				result2 = cstmt.getString(5);
				%>
				<p align = "center" class="view">
					<%=nYear%>년도 <%=nSemester%>학기 수강조회
				</p>
				
				<table align = "center" class="simpletable">
				<br>
				<tr>
					<td>총 신청 과목 수</td>
					<td><%=result1%></td>
				</tr>
			
				<tr>
					<td>총 신청 학점 수</td>
					<td><%=result2%></td>
				</tr>
				</table>
		<%
			} catch (SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			} finally {
				if (cstmt != null)
					try {
						myConn.commit();
						cstmt.close();
						myConn.close();
					} catch (SQLException ex) {
					}
			}
		%>
</table>
</form>
</body>
</html>
