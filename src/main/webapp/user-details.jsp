<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%

if(session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){
	
%>		
		
<jsp:include page="myaccount-header.jsp"></jsp:include>


	<form action="updateuserdetails" method="post">
	
	    <div class="container">
	        <div class="row userdetails">
	        
	        	<div class="alert mb-4 accountdetailstile unselectabel col-md-12" role="alert"><span>Account Details...</span></div>
	        
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
	            
			            <div class="colom02 col-md-4">
			                <div class="form-group">
			                    <label for="fullnameuserdetails" class="form-label">Full Name</label>
			                    <input name="fname" value="<% out.print(rs.getString("name"));%>" type="text" class="form-control" id="fullnameuserdetails" placeholder="John Alan">
			                </div>
			            </div>
			
			            <div class="colom02 col-md-4">
			                <div class="form-group">
			                    <label for="emailuserdetails" class="form-label">Email address</label>
			                    <input name="email" value="<% out.print(rs.getString("email"));%>" type="email" class="form-control" id="emailuserdetails" placeholder="email@7-star.com">
			                </div>
			            </div>
			
			            <div class="colom03 col-md-4">
			                <div class="form-group">
			                    <label for="inputCity">Phone Number</label>
			                    <input name="phone" value="<% out.print(rs.getString("phone"));%>" type="tel" class="form-control" id="inputCity" maxlength="10" minlength="10" placeholder="07X XXX XXXX">
			                </div>
			            </div> 
			
			        </div>
			               	
			        
			
			        <div class="row userdetails center">
			        
				               
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
				            			            
			            
			            <div class="colom03 col-md-6">
			                <div class="form-group col-md-6 offset-md-6 p-0">
			                    <button type="submit" class="btn mt-1 btn-primary form-control updatebntuserdetails">Save Changers</button>
			                </div>
			            </div>
			        </div>
	        <%       		
        	}	        	
        	%>
	
	    </div>
	
	</form>
	

<%} %>	
	
	
<jsp:include page="myaccount-footer.jsp"></jsp:include>