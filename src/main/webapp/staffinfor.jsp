<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>



<table class="table table-striped table-hover">
  <thead class="thead-dark">
    <tr>
      <th scope="col">Employee ID</th>
      <th scope="col">Full Name</th>
      <th scope="col">E-mail Address</th>
      <th scope="col">Phone Number</th>
      <th scope="col">Position</th>
    </tr>
  </thead>
  <tbody>
  
  	<%  	
  	Connection conn = DbConfiguration.getDatabaseConnection();
	String sql4 = "SELECT u.user_id, u.`name`, u.email, u.phone, p.name as pociname FROM tbl_user u INNER JOIN tbl_position p WHERE u.`position_id` = p.`position_id` AND u.position_id!=?";
	PreparedStatement stmt4 = conn.prepareStatement(sql4);
	stmt4.setInt(1, 3);
	ResultSet rs4 = stmt4.executeQuery();
	
	int rows4 = 0;
	
	while(rs4.next()) {
		rows4++;
		
	%>
  
    <tr>
      <th scope="row"> <center> <%out.print(rs4.getString("user_id"));%> </center> </th>
      <td class="uppercase"><%out.print(rs4.getString("name"));%></td>
      <td><%out.print(rs4.getString("email"));%></td>
      <td><%out.print(rs4.getString("phone"));%></td>
      <td class="uppercase"><%out.print(rs4.getString("pociname"));%></td>
    </tr>
    
    <% 
	}	
  	%>
    
  </tbody>
</table>






<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
