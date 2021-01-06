<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<form class="needs-validation mt-5 addpro" novalidate action="orderid" method="post"> 
    <div class="row mb-5">    
        <div class=" col-md-2">
            <label class="proname">Order ID*</label>
        </div>
        <div class="col-md-3">
            <input id="productname" value="<%if(request.getAttribute("orderid") != null){out.print(request.getAttribute("orderid"));}%>" name="orderid" type="text" class="form-control" placeholder="" required>
        </div>
        <div class="col-md-3">
            <button name="Credit-Card" class="btn btn-primary btn-block" type="submit"><b>Search Order Details</b></button>
        </div>
    </div>
    <hr class="mb-4">
</form>

<%if(request.getAttribute("orderid") != null){ 

	String orderid = request.getAttribute("orderid").toString();
%>

		  <table class="table table-striped col-md-9 table-hover ">
		    <thead class="thead-dark">
		    <tr>
		      <th width="100" scope="col"><center>Item Code</center></th>
		      <th scope="col">Product Name</th>
		      <th width="150"scope="col"><center>Quantity</center></th>
		      <th width="150"scope="col"><center>Total Price</center></th>
		    </tr>
		    </thead>
		    <tbody class="tbdy">
		    	
			    <%
			  	
			  	Connection conn = DbConfiguration.getDatabaseConnection();
				String sql4 = "SELECT  o.item_id, i.name, i.description, o.quantity, o.price FROM tbl_orderinfor o INNER JOIN tbl_item i WHERE o.item_id=i.id AND order_id=?";
				PreparedStatement stmt4 = conn.prepareStatement(sql4);
				stmt4.setString(1, orderid);
				ResultSet rs4 = stmt4.executeQuery();
				
				int rows4 = 0;
				
				while(rs4.next()) {
					rows4++;
			
				%>
		    
		        <tr>
		            <td align="center" name="fullname"><%out.print(rs4.getString("item_id"));%></td>
		            <td name="fullname"><%out.print(rs4.getString("name")+" "+rs4.getString("description"));%></td>
		            <td name="fullname"><center><%out.print(rs4.getString("quantity"));%></center></td>
		            <td align="center" id="<%out.print(rs4.getInt("item_id"));%>"></td>
		            
		            <script> 
						document.getElementById(<%out.print(rs4.getInt("item_id"));%>).innerText =  "Rs. " + formatMoney(<%out.print(rs4.getInt("price"));%>);
					</script>
		            
		        </tr>
		        
		        <% 
				}				
			  	%>
		        
		
		    </tbody>
		  </table>

				<% 
				if(rows4 > 0) {
					
				}else {
					%>
					<div class="col-12 col-md-9 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
					<%
				}
				
				
			  	%>



<%}%>


<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
