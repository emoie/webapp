
<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<table class="table table-striped table-hover">
  <thead class="thead-dark unselectabel">
    <tr>
      <th scope="col">Order ID</th>
      <th scope="col">Date & Time</th>
      <th scope="col">Delivery Address</th>
      <th scope="col">Payment Method</th>
      <th scope="col">Delivery Company</th>
      <th scope="col">Status</th>
    </tr>
  </thead>
  <tbody>
  
  	<%
  	
  	Connection conn = DbConfiguration.getDatabaseConnection();
	String sql4 = "SELECT * FROM tbl_order WHERE status=?";
	PreparedStatement stmt4 = conn.prepareStatement(sql4);
	stmt4.setString(1, "Order Confirmed");
	ResultSet rs4 = stmt4.executeQuery();
	
	int rows4 = 0;
	
	while(rs4.next()) {
		rows4++;
	
		%>
		
		    <tr>
		      <form action="readytoship" method="post"> 
		        <th scope="row"><%out.print(rs4.getString("order_id"));%></th>
		        <td class="unselectabel" ><%out.print(rs4.getString("date&time"));%></td>
		        <td id="address3"><%out.print(rs4.getString("address"));%></td>
		        
		        
			        <%
			      	//=====================Payment Method================================
			        String sql5 = "SELECT * FROM tbl_payment WHERE id =?";
					PreparedStatement stmt5 = conn.prepareStatement(sql5);
					stmt5.setString(1, rs4.getString("payment_id"));
					ResultSet rs5 = stmt5.executeQuery();
					
					int rows5 = 0;
					
					while(rs5.next()) {
						rows5++;
			        %>
		           		<td class="unselectabel" ><%out.print(rs5.getString("paymethod"));%></td>
		        	<%
					}
					%>
					
					
					
					<%
					//=====================Delivery company name================================
			        String sql6 = "SELECT * FROM tbl_delivery WHERE id =?";
					PreparedStatement stmt6 = conn.prepareStatement(sql6);
					stmt6.setString(1, rs4.getString("delivery_id"));
					ResultSet rs6 = stmt6.executeQuery();
					
					int rows6 = 0;
					
					while(rs6.next()) {
						rows6++;
			        %>
		           		<td class="unselectabel" ><%out.print(rs6.getString("company_name"));%></td>
		        	<%
					}
					%>
		        
		        <td class="unselectabel" > <button name="orderid" value="<%out.print(rs4.getString("order_id"));%>" class="btn btn-primary col-md-12 redytoship" type="submit"><b>Ready to Ship</b></button> </td>
		      </form>
		    </tr>
		    
		    <%} %>
    
    		
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
				    if(request.getAttribute("succuss") != null || request.getAttribute("error") != null){
				    
					  	if(request.getAttribute("succuss") != null){
					  		
					  		 out.print(request.getAttribute("succuss"));
				    		
						 }else if (request.getAttribute("error") != null){
						    
							 out.print(request.getAttribute("error"));
						 }
				    }									  	
				  	%>	
				</label>
            </div>
            
            
   
<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
   