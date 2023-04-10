<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head> 
<title>수강신청취소 페이지입니다</title>
</head>
<body>
<%@ include file="top.jsp"%>
<%
   if (session_id==null) 
      response.sendRedirect("login.jsp"); 
%>

<table width = "75%" class="classtable" border="1" align="center" >
<tr>
   <th>과목번호</th>
   <th>분반</th>
   <th>과목명</th>
   <th>학점</th>
   <th>수강취소</th>
</tr>
<%   
   String dbdriver = "oracle.jdbc.driver.OracleDriver";
   String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
   String user = "db1816461"; String passwd = "oracle";
   
   Connection myConn = null;
   Statement stmt = null;   
   ResultSet myResultSet = null; 
   String SQL1 = "";
   String SQL2 = "";
   String mySQL = "";
       
   try {
      Class.forName(dbdriver);
       myConn =  DriverManager.getConnection (dburl, user, passwd);
      stmt = myConn.createStatement();   
    } catch(SQLException ex) {
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
%>
<p class="title" align = "center">
   <%=nYear%>년도 <%=nSemester%>학기 수강삭제
</p>
<%
   mySQL = "select c_id, c_id_no, c_name, c_unit from course where (c_id, c_id_no) in (select c_id, c_id_no from enroll where e_year =" 
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
     <td align="center"><%= c_id %></td>
      <td align="center"><%= c_id_no %></td>
     <td align="center"><%= c_name %></td>
     <td align="center"><%= c_unit %></td>
     <td align="center"><a href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>" >삭제</a></td>
   </tr>
<%
   }
   }
   stmt.close(); 
   myConn.close();
%>
</table>
</body>
</html>
