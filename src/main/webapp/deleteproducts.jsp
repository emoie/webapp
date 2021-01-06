<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>


<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>



	<form class="needs-validation mt-5 addpro" novalidate action="deleteproductid" method="post"> 
	    <div class="row mb-5">    
	        <div class=" col-md-2 offset-md-5">
	            <label class="proname">Enter Product ID*</label>
	        </div>
	        <div class="col-md-3">
	            <input id="productname" value="<%if(request.getAttribute("productid") != null){ out.print(request.getAttribute("productid")); } %>" name="productid" type="text" class="form-control" placeholder="" required>
	        </div>
	        <div class="col-md-2">
	            <button name="Credit-Card" class="btn btn-primary btn-block" type="submit"><b>Search Product</b></button>
	        </div>
	    </div>
	    	<%if(request.getAttribute("productdelete") != null){ %>
			    <div class="col-md-4 offset-md-8">
			    <span class="spansize"><% out.print(request.getAttribute("productdelete")); %></span>
			    </div>
			<%} %>
	</form>

	<%if(request.getAttribute("productid") != null){ 
	
	String productid = request.getAttribute("productid").toString();
	
  	Connection conn = DbConfiguration.getDatabaseConnection();
	String sql4 = "SELECT * FROM tbl_item WHERE id=?";
	PreparedStatement stmt4 = conn.prepareStatement(sql4); 
	stmt4.setString(1, productid); 
	ResultSet rs4 = stmt4.executeQuery();
	
	int rows4 = 0;
	
	while(rs4.next()) {
		rows4++;
		
	%>


	<form class="needs-validation mt-5 addpro" novalidate action="deleteprodcts" method="post"> 
	  <hr class="mb-5">
	  <table class="table table-striped table-hover ">
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
	    <tbody class="tbdy">
	        <tr>
	        <th scope="row"><%out.print(rs4.getString("id"));%></th>
	        <td><%out.print(rs4.getString("name"));%></td>
	        <td><%out.print(rs4.getString("brand"));%></td>
	        <td><%out.print(rs4.getString("description"));%></td>
	        <td><%out.print(rs4.getString("warrenty"));%></td>
	        <td><%out.print(rs4.getString("quantity"));%></td>
	        <td><%out.print(rs4.getString("price"));%></td>
	        <td><%out.print(rs4.getString("discount"));%></td>
	        </tr>
	    </tbody>
	  </table>
	
	  <div class="row mb-5">    
	      <div class="col-md-4 offset-md-8">
	          <button name="productiid" value="<%out.print(rs4.getString("id"));%>" class="btn btn-primary btn-block update" type="submit"><b>Delete Selected Product Details</b></button>
	      </div>
	  </div>
	</form>


	<%
	}if(rows4 > 0) {
		
	}else {
		%>
		<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
		<%
	}
	
	}%>
	



<%}else{
	response.sendRedirect("signin.jsp");	
}%> 

