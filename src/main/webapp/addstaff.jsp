<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>

		
		
		
		
		<form class="needs-validation mt-5 addpro" novalidate action="addstaff" method="post"> 
		
		    <%if(request.getAttribute("addedstaff") != null){%>
			    <div class="col-md-12 mt-4 mb-5 pl-0">
			      	<span class="spansize"><%out.print(request.getAttribute("addedstaff"));%></span>
			    </div>
		    <%}%>
		    
		    <div class="row mb-5">    
		        <div class=" col-md-2">
		            <label class="fullname">Full Name*</label>
		        </div>
		        <div class="col-md-6">
		            <input id="fullname" name="fname" type="text" class="form-control" placeholder="John" required>
		        </div>
		    </div>
		
		
		    <div class="row mb-5">    
		        <div class=" col-md-2">
		            <label class="email">Email Address*</label>
		        </div>
		        <div class="col-md-5">
		            <input id="email" name="email" type="text" class="form-control" placeholder="infor@123.com" required>
		        </div>
		    </div>
		
		
		    <div class="row mb-5">    
		        <div class=" col-md-2">
		            <label class="newpass">Password*</label>
		        </div>
		        <div class="col-md-4">
		            <input id="newpass" name="password" type="password" class="form-control" placeholder="*********" required>
		        </div>
		    </div>
		
			
			<div class="row mb-5">    
		        <div class=" col-md-2">
		            <label class="newpass">Address*</label>
		        </div>
		        <div class="col-md-5">
		            <input name="address" type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" required>
		        </div>
		    </div>
			
		
		    <div class="row mb-5">    
		        <div class=" col-md-2">
		            <label class="phone">Phone Number*</label>
		        </div>
		        <div class="col-md-4">
		            <input name="phone" type="tel" class="form-control" id="inputCity" maxlength="10" minlength="10" pattern="[0]{1}[7]{1}[0-8]{1}[0-9]{7}" placeholder="07X XXX XXXX" required>
		        </div>
		    </div>
		
		
		    <div class="row mb-5">
		        <div class=" col-md-2">
		            <label class="proname">Employee Position*</label>
		        </div>
		        <div class="col-md-5">
		            <select type ="select" name="position" id="cate"  class="custom-select form-control uppercase loginemail customerf" required autofocus >
		            <option value="3" selected>Standerd-Customer</option>
		            <option value="4">Standerd-Staff Member</option>
		            <option value="5">Branch Manager</option>
		            <option value="2">Chief Manager</option>
		            <option value="1">Admin</option>
		            </select>
		        </div>
		    </div>  
		
		    
		    <hr class="mb-4">
		
		    <div class="row mb-5">
		        <div class=" col-md-6">
		            <a role="button" href="staff.jsp" name="Credit-Card" class="btn btn-warning btn-block" type="submit"><b>Cancel</b></a>
		        </div>
		        <div class="col-md-6">
		            <button name="Credit-Card" class="btn btn-primary btn-block" type="submit"><b>Create Employee Account</b></button>
		        </div>
		        
		    </div>  
		
		</form>
		



<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
		