<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>



<table class="table table-striped table-hover">
  <thead class="thead-dark unselectabel">
    <tr>
      <th scope="col">Order ID</th>
      <th scope="col">Delivery Address</th>
      <th scope="col">Delivery Company</th>
      <th scope="col"><center>Status</center></th>
    </tr>
  </thead>
  <tbody>
  
   <%  	
  	Connection conn = DbConfiguration.getDatabaseConnection();
	String sql4 = "SELECT o.order_id, o.address, d.company_name FROM tbl_order o INNER JOIN  tbl_delivery d WHERE o.delivery_id=d.id AND status=?";
	PreparedStatement stmt4 = conn.prepareStatement(sql4);
	stmt4.setString(1, "Ready to Ship");
	ResultSet rs4 = stmt4.executeQuery();
	
	int rows4 = 0;
	
	while(rs4.next()) {
		rows4++;

	%>
   
	    <tr>
	      <form action="ship" method="post"> 
	        <th scope="row"><%out.print(rs4.getString("order_id"));%></th>
	        <td id="address3"><%out.print(rs4.getString("address"));%></td>
	        <td class="unselectabel" ><%out.print(rs4.getString("company_name"));%></td>
	        <td class="unselectabel" > <button name="orderid" value="<%out.print(rs4.getString("order_id"));%>" class="btn btn-primary col-md-12 redytoship" type="submit"><b>Shipped</b></button> </td>
	      </form>
	    </tr>
	    <tr>
    
    <% 
	}
	%>
    
  </tbody>
</table>


	<%  	
	if(rows4 > 0) {
		
	}else {
		%>
		<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
		<%
	}	
  	%>
    
			<div class="colom03 col-md-12 mt-3 pl-0">
                <label class="spansize2 col-md-12 p-0">  
	               <%				    
				    if(request.getAttribute("ship") != null || request.getAttribute("errorship") != null){
				    
					  	if(request.getAttribute("ship") != null){
					  		
					  		 out.print(request.getAttribute("ship"));
				    		
						 }else if (request.getAttribute("errorship") != null){
						    
							 out.print(request.getAttribute("errorship"));
						 }
				    }									  	
				  	%>	
				</label>
            </div>

<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
