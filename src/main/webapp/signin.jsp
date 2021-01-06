

<%@page import="java.awt.List"%>
<jsp:include page="header.jsp"></jsp:include>



	<div class="col-10 offset-1 col-md-6 offset-md-3 mt-5 signinbox">
	    <form class="px-3 py-3 needs-validation" action="signin" method="post" novalidate>
	
	        <div class="modal-header">
	            <h4 class="modal-title" id="exampleModalLongTitle"><b>Welcome to 7-Star! Please login.</b></h4>
	        </div>
	
	        <div class="modal-body">         
	        
	            <div class="form-group">
	                <label for="exampleDropdownFormEmail1">Email address</label>
	                <input name="u-email" type="email" class="form-control" id="exampleDropdownFormEmail1" placeholder="email@example.com" required>
	            </div>
	            <div class="form-group">
	                <label for="exampleDropdownFormPassword1">Password</label>
	                <input name="u-pass" type="password" class="form-control" id="exampleDropdownFormPassword1" minlength="8" placeholder="Password" required>
	            </div>
	            <div class="form-check">
	                <input name="remember-me" type="checkbox" class="form-check-input" id="dropdownCheck">
	                <label class="form-check-label" for="dropdownCheck">
	                    Remember me
	                </label>
	            </div>  
	
	        </div>
	
	        <div class="modal-footer">
	            <button type="submit" class="btn btn-primary form-control signinbtn">Sign in</button>
	        </div>   
	        <%
	        String error = "";
	        error = (String) request.getAttribute("loginfail");
	                		
	        if(error != null){
	        	
	        %>
	        <div class="modal-body pb-0 pt-0">  
		        <div class="form-group">
	                <label id="errormglogin"><b> <% out.print(request.getAttribute("loginfail")); %> </b></label>
	            </div>              
		    </div>  
	    	<%} %>
	    	
	        <a class="m-3" href="signup.jsp">New around here? Sign up</a><br/>
	        <a class="m-3 forgotpass" href="#">Forgot password?</a>
	
	    </form>
	</div> 



<jsp:include page="footer.jsp"></jsp:include>