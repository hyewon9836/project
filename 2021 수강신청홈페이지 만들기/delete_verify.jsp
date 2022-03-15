<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head> 
<title>수강신청 취소</title>
</head>

<%@ include file="top.jsp"%>
<body>
   <%

    Connection myConn = null; 
    String result = "";
    String dbdriver = "oracle.jdbc.driver.OracleDriver";
    String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
    String user = "db1816461"; String passwd = "oracle";
    CallableStatement cstmt;
    
    
    try{

      Class.forName(dbdriver);
       myConn =  DriverManager.getConnection (dburl, user, passwd);
    } catch(SQLException ex) {
        System.err.println("SQLException: " + ex.getMessage());
   }
    String s_id = (String)session.getAttribute("user");
    String c_id = request.getParameter("c_id");
    int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
    
    cstmt = myConn.prepareCall("{call DeleteEnroll(?,?,?,?)}");
       cstmt.setString(1,s_id);
       cstmt.setString(2,c_id);
       cstmt.setInt(3,c_id_no);
       cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
       
       CallableStatement cstmt2 = myConn.prepareCall("{call countstudent(?,?)}");
      cstmt2.setString(1,c_id);
      cstmt2.setInt(2,c_id_no);
      
       try{
          cstmt.execute();
          cstmt2.execute();
          result = cstmt.getString(4);
    %>
       <script>
          alert("<%=result%>");
          location.href="delete.jsp";
       </script>
    <%
       }catch(SQLException ex) {
          System.err.println("SQLException : " + ex.getMessage());
       }finally{
          if(cstmt != null) {
             try{
                myConn.commit();
                cstmt.close();
                myConn.close();
             }catch(SQLException ex) {}
          }
       }
             
             
          
    %>
 </body>
 </html>