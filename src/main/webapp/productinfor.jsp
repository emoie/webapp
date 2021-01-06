<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>



<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>


<table class="table table-striped table-hover">
  <thead class="thead-dark">
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Product Name</th>
      <th scope="col">Brand</th>
      <th scope="col">Description</th>
      <th scope="col">Warrenty</th>
      <th scope="col">Quantity</th>
      <th scope="col">Price</th>
      <th scope="col">Special Price</th>
    </tr>
  </thead>
  <tbody>
  
  	<%
  	
  	Connection conn = DbConfiguration.getDatabaseConnection();
	String sql4 = "SELECT * FROM tbl_item";
	PreparedStatement stmt4 = conn.prepareStatement(sql4);

	ResultSet rs4 = stmt4.executeQuery();
	
	int rows4 = 0;
	
	while(rs4.next()) {
		rows4++;
		
	%>
  
    <tr>
      <th scope="row"><%out.print(rs4.getInt("id"));%></th>
      <td><%out.print(rs4.getString("name"));%></td>
      <td><%out.print(rs4.getString("brand"));%></td>
      <td><%out.print(rs4.getString("description"));%></td>
      <td><%out.print(rs4.getString("warrenty"));%></td>
      <td><%out.print(rs4.getInt("quantity"));%></td>
      <td id = "<%out.print(rs4.getInt("id")+rs4.getInt("price"));%>"></td>
      <td id = "<%out.print(rs4.getInt("id")+rs4.getInt("discount"));%>"></td>
      
			<script> 
				document.getElementById(<%out.print(rs4.getInt("id")+rs4.getInt("price"));%>).innerText =  "Rs. " + formatMoney(<%out.print(rs4.getInt("price"));%>);
				document.getElementById(<%out.print(rs4.getInt("id")+rs4.getInt("discount"));%>).innerText =  "Rs. " + formatMoney(<%out.print(rs4.getInt("discount"));%>);
			</script>
      
    </tr>
   
   <% 
	}if(rows4 > 0) {
		
	}else {
		%>
		<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
		<%
	}
	
	
  	%>
    
  </tbody>
</table>


<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
