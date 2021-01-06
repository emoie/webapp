<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>


	<div class="row mb-5 addpro">  
	
			<% if(request.getAttribute("addedproduct") != null){  %>
		        <div class="col-md-12 mt-2 mb-4">
		            <span class="spansize"><% out.print(request.getAttribute("addedproduct")); %></span>
		        </div>
		   	<%}%>
	  
        <div class=" col-md-6">
        	<form action="cate" method="post">
	            <label class="procate">Select Product Category*</label>
	            <select type ="select" name="catego" id="cate" onchange='if(this.value != 0){this.form.submit();}'  class="custom-select form-control loginemail customerf" required autofocus >
	
					<option value="" selected>Select</option>
	            
	
					<%
				  	
				  	Connection conn = DbConfiguration.getDatabaseConnection();
					String sql4 = "SELECT * FROM tbl_category";
					PreparedStatement stmt4 = conn.prepareStatement(sql4);
					ResultSet rs4 = stmt4.executeQuery();
					
					int rows4 = 0;
					
					while(rs4.next()) {
						rows4++;
				
					%>
	
	            		<option <%if(session.getAttribute("catego")!=null && rs4.getString("id").equals( session.getAttribute("catego"))){out.print("selected");} %> value="<%out.print(rs4.getInt("id"));%>"><%out.print(rs4.getString("name"));%></option>
	            
	            	<% 
					}				
				  	%>
				  	
	            </select>
	        </form>
        </div>
        <div class="col-md-6">
        	<form action="cate" method="post">
	            <label class="procate">Select Product Sub-Category*</label>
	            <select type ="select" name="subcate" id="subcate" onchange='if(this.value != 0) { this.form.submit(); }'  class="custom-select form-control loginemail customerf" required autofocus >
	            
	            		<%
		                		
		        		if(request.getAttribute("catego") != null){
		        			
		        			%><option value="" selected>Select</option><%
		        				
	        				String cate = session.getAttribute("catego").toString();
	
						  	String sql = "SELECT * FROM tbl_subcategory WHERE cate_id=?";
							PreparedStatement stmt = conn.prepareStatement(sql);
							stmt.setString(1, cate);
							ResultSet rs = stmt.executeQuery();
							
							int rows = 0;
							
							while(rs.next()) {
								rows++;
					
							%>
		
		            			<option value="<%out.print(rs.getInt("id"));%>"><%out.print(rs.getString("name"));%></option>
		            
		            		<% 
							}
								
		        		} else if (request.getAttribute("subcate") != null){
		        			
		        			%><option value="" selected>Select</option><%
		        			
		        			String cate = session.getAttribute("catego").toString();
	
						  	String sql = "SELECT * FROM tbl_subcategory WHERE cate_id=?";
							PreparedStatement stmt = conn.prepareStatement(sql);
							stmt.setString(1, cate);
							ResultSet rs = stmt.executeQuery();
							
							int rows = 0;
							
							while(rs.next()) {
								rows++;
					
							%>
		
		            			<option <%if(session.getAttribute("subcate")!=null && rs.getString("id").equals( session.getAttribute("subcate"))){out.print("selected");} %> value="<%out.print(rs.getInt("id"));%>"><%out.print(rs.getString("name"));%></option>
		            
		            		<% 
							}								
		        		}
					  	%>
	
	            </select>
	        </form>
        </div>
    </div>



<form  class="needs-validation mt-5 addpro" novalidate action="additem" method="post" enctype="multipart/form-data"> 

	<div class="row mb-5">    
        <div class=" col-md-2">
            <label class="proname">Product Name*</label>
        </div>
        <div class="col-md-8">
            <input id="productname" name="productnameq" type="text" class="form-control" required>
        </div>
    </div>
    
    <div class="row mb-5">
        <div class=" col-md-2">
            <label class="proname">Brand*</label>
        </div>
        <div class="col-md-5">
            <input  name="brand" type="text" class="form-control" required>
        </div>
    </div>
	

    <div class=" mb-5">
        <label for="cc-number">Product Destription*</label>
        <textarea name="pdec" rows="8" class="form-control" id="product-dec" placeholder="" required></textarea>
    </div>
    
    
    

    <div class="row mb-5">    
        <div class=" col-md-2">
            <label for="proimg">Product image*</label>
        </div>
        <div class="col-md-3 choosefile">
            <input name="imgpng" class="choosefile" type="file" onchange="readURL(this); " accept="image/png" required/>
        </div>
        <div class="col-md-1 ">
            <div class="imgpreview">
                <img class="justifycenter" src="#" id="blah" >
            </div>
        </div>
    </div>

	


    <div class="row mb-5">
        <div class=" col-md-2">
            <label class="proname">Warrenty Period*</label>
        </div>
        <div class="col-md-5">
            <select type ="select" name="warrenty" id="cate"  class="custom-select form-control loginemail customerf" required autofocus >
            <option selected>No Warrenty</option>
            <option value="Female">6 Months Warrenty</option>
            <option value="Female">1 Year Warrenty</option>
            <option value="Female">2 Year Warrenty</option>
            <option value="Female">3 Year Warrenty</option>
            <option value="Female">5 Year Warrenty</option>
            </select>
        </div>
    </div>  


    <div class="row mb-5">
        <div class=" col-md-2">
            <label class="proname">Product Price*</label>
        </div>
        <div class="col-md-3">
            <input id="productname" name="productprice" type="number" min="0.00" step="0.01" class="form-control" placeholder="" required>
        </div>

        <div class=" col-md-2">
            <label class="proname">Special Price*</label>
        </div>
        <div class="col-md-3">
            <input id="productname" name="discount" type="number" min="0.00" step="0.01" class="form-control" placeholder="" required>
        </div>
    </div>  


    <div class="row mb-5">
        <div class=" col-md-2">
            <label class="proname">Quatitity*</label>
        </div>
        <div class="col-md-3">
            <input id="productname" name="qnt" type="number" value="1" min="1" class="form-control" placeholder="" required>
        </div>
    </div>  
    

    
    <hr class="mb-4">

    <div class="row mb-5">
        <div class=" col-md-6">
            <a role="button" href="products.jsp" name="Credit-Card" class="btn btn-warning  btn-block" type="submit"><b>Cancel</b></a>
        </div>
        <div class="col-md-6">
            <button name="Credit-Card" class="btn btn-primary btn-block" type="submit"><b>Upload Product</b></button>
        </div>
    </div>  

</form>


<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
