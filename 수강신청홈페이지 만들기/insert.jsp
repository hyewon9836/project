<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
   <head>
      <title>수강신청</title>
   </head>
<body>
<%@ include file="top.jsp" %>
<% 
   if (session_id==null) 
      response.sendRedirect("login.jsp"); 
%>

<table width="75%" align="center" border>
<br>
   <tr>
      <th>학과전공</th>
      <th>과목번호</th>
      <th>분반</th>
      <th>과목명</th>
      <th>시간</th>
      <th>학점</th>
      <th>신청인원</th>
      <th>수강신청</th>
   </tr>

      <%
      
      request.setCharacterEncoding("UTF-8");
      
      String search_major = request.getParameter("search_major");
      if(search_major == null) {
         search_major = "";
      }
      String dbdriver = "oracle.jdbc.driver.OracleDriver";
      String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
      String user = "db1816461"; String passwd = "oracle";
      
      Connection myConn = null; 
      Statement stmt = null;
      ResultSet myResultSet = null; 
      
      String SQL1 = ""; String SQL2 = ""; String SQL3="";
      String mySQL = "";
      String studentCount ="";
      

      try {
            Class.forName(dbdriver);
            myConn = DriverManager.getConnection (dburl, user, passwd);
            stmt = myConn.createStatement();
      }catch(SQLException ex) {
            System.err.println("SQLException: " + ex.getMessage());
            }
      
      SQL1 = "{? = call Date2EnrollYear(SYSDATE)}";
      CallableStatement cstmt = myConn.prepareCall(SQL1);
      cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
      cstmt.execute();
      int nYear = cstmt.getInt(1);
      
      SQL2 = "{? = call Date2EnrollSemester(SYSDATE)}";
      CallableStatement cstmt2 = myConn.prepareCall(SQL2);
      cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
      cstmt2.execute();
      int nSemester = cstmt2.getInt(1);

      %>
      
      <p align = "center" class="title">
      <%=nYear%>년도
      <%=nSemester%>학기 수강신청
      </p>
      <div align = "center">
      <form method="post" width="75%" align="center" action="insert.jsp"> 
      학과전공: <input type="text" name="search_major" value="<%=search_major %>" size="10"/>
               <input type="SUBMIT" NAME="submit" size="30" style="text-align:center;" value="검색" >      
      <br/><br/>
      </form>
      </div>
      
      
      <% 
      if (search_major.equals(""))   
         mySQL = "select c_major,c_id,c_id_no,c_name,c_unit,c_time,c_pop,c_max from course where c_year =" + nYear + "and c_semester = " + nSemester 
               + " and (c_id,c_id_no) not in (select c_id,c_id_no from enroll where s_id='" + session_id + "') order by c_major,c_id,c_id_no";
      else if (search_major.equals("컴퓨터공학과"))
         mySQL = "select c_major,c_id,c_id_no,c_name,c_unit,c_time,c_pop,c_max from comscience where c_year =" + nYear + "and c_semester = " + nSemester 
               + " and (c_id,c_id_no) not in (select c_id,c_id_no from enroll where s_id='" + session_id + "') order by c_major,c_id,c_id_no";
      else if(search_major.equals("통계학과"))
         mySQL = "select c_major,c_id,c_id_no,c_name,c_unit,c_time,c_pop,c_max from statistics where c_year =" + nYear + "and c_semester = " + nSemester 
               + " and (c_id,c_id_no) not in (select c_id,c_id_no from enroll where s_id='" + session_id + "') order by c_major,c_id,c_id_no";
      else
      {
      %>
         <script>
         alert("검색 결과가 없습니다.");
         </script>
      <% 
         mySQL = "select c_major,c_id,c_id_no,c_name,c_unit,c_time,c_pop,c_max from course where c_year =" + nYear + "and c_semester = " + nSemester 
               + " and (c_id,c_id_no) not in (select c_id,c_id_no from enroll where s_id='" + session_id + "') order by c_major,c_id,c_id_no";
         }
      
      myResultSet = stmt.executeQuery(mySQL);
      if (myResultSet != null) {
         while (myResultSet.next()) {
            String c_major = myResultSet.getString("c_major"); 
            String c_id = myResultSet.getString("c_id"); 
            int c_id_no = myResultSet.getInt("c_id_no");
            String c_name = myResultSet.getString("c_name");
            int c_time = myResultSet.getInt("c_time");
            int c_unit = myResultSet.getInt("c_unit");
            int c_pop = myResultSet.getInt("c_pop");
            int c_max = myResultSet.getInt("c_max");
            
%>

      <tr>
         <td align="center" ><%= c_major %></td>
         <td align="center" ><%= c_id %></td> 
         <td align="center" ><%= c_id_no %></td>
         <td align="center"><%= c_name %></td>
         <td align="center"><%= c_time %></td>
         <td align="center"><%= c_unit %></td>
         <td align="center"><%= c_pop %> <%="/"%> <%=c_max %></td>
         <td align="center"><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%=c_id_no %>">신청</a></td>
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
