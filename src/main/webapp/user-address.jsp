<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>

<jsp:include page="myaccount-header.jsp"></jsp:include>

<%

if(session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){
	
%>	

	
		<form action="updateaddress" method="post">
		
		    <div class="container">
		        <div class="row userdetails">
		            
		            <div class="alert mb-4 accountdetailstile unselectabel col-md-12" role="alert"><span>Address...</span></div>
		            
		            <%
		            int userid = (Integer)session.getAttribute("u_id");
		        	
		        	Connection conn  = DbConfiguration.getDatabaseConnection();
		        	String sql = "SELECT * FROM tbl_user WHERE user_id =?";
		        	PreparedStatement stmt = conn.prepareStatement(sql);
		        	
		        	stmt.setInt(1, userid);
		        	
		        	ResultSet rs = stmt.executeQuery();
		        	
		        	int rows = 0;
		        	
		        	while(rs.next()) {
		        		rows++;
		        	%>
			        	<div class="colom01 col-md-12">
			                <div class="form-group col-md-8">
			                    <label for="fullnameuserdetails" class="form-label">Delivery Address</label>
			                    <textarea name="address" type="text" class="form-control" id="addressuserview" placeholder="John Alan"> <%out.print(rs.getString("address"));%></textarea>
			                </div>
			                <div class="form-group col-md-3 ">
			                    <button type="submit" class="btn mt-1 btn-primary form-control updatebntuserdetails">Save Changers</button>
			                </div>
			                
			                <div class="colom03 col-md-6">
				                <label class="spansize2 col-md-6 p-0">  
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
				            
			            </div>
		        	
		        	<%       		
		        	}	        	
		        	%>
		
		            
		
		        </div>
		    </div>
		
		</form>


<%
}
%>


<jsp:include page="myaccount-footer.jsp"></jsp:include>