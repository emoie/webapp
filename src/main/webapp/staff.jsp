<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>


<jsp:include page="adminpage-header.jsp"></jsp:include>



	<div class="alert alert-info mb-4 unselectabel" role="alert">Staff...</div>
	
	<div class="col-5 col-md-11 mr-5 ml-5">
	
	    <nav>
	        <div class="nav nav-tabs tabnav" id="nav-tab" role="tablist">
	            <a class="nav-item nav-link active tabnav" data-toggle="tab" href="#staff-details" role="tab" aria-controls="staff-details" aria-selected="true">Staff Details</a>
	            <a class="nav-item nav-link tabnav <%if(session.getAttribute("u_position").equals(5) || session.getAttribute("u_position").equals(4)){out.print("disabled");} %>" data-toggle="tab" href="#add-staff" role="tab" aria-controls="add-staff" aria-selected="false">Add New Employees</a>
	            <a class="nav-item nav-link tabnav <%if(session.getAttribute("u_position").equals(5) || session.getAttribute("u_position").equals(4)){out.print("disabled");} %>" data-toggle="tab" href="#update-staff" role="tab" aria-controls="update-staff" aria-selected="false">Update Employee Information</a>
	            <a class="nav-item nav-link tabnav <%if(session.getAttribute("u_position").equals(5) || session.getAttribute("u_position").equals(4) || session.getAttribute("u_position").equals(2)){out.print("disabled");} %>" data-toggle="tab" href="#delete-staff" role="tab" aria-controls="delete-staff" aria-selected="false">Delete Employees</a>
	        </div>
	    </nav>
	
	    <div class="tab-content mt-4" id="nav-tabContent">
	
	        <div class="tab-pane fade show active unselectabel" id="staff-details" role="tabpanel">  <jsp:include page="staffinfor.jsp"></jsp:include>   </div>
	        
	        <%if(!session.getAttribute("u_position").equals(5) && !session.getAttribute("u_position").equals(4)){%>
	        <div class="tab-pane fade unselectabel" id="add-staff" role="tabpanel">  <jsp:include page="addstaff.jsp"></jsp:include>   </div>
	        <div class="tab-pane fade unselectabel" id="update-staff" role="tabpanel">  <jsp:include page="updatestaff.jsp"></jsp:include>   </div>
	        	<%if(!session.getAttribute("u_position").equals(2)){%>
	        		<div class="tab-pane fade unselectabel" id="delete-staff" role="tabpanel">  <jsp:include page="deletestaff.jsp"></jsp:include>   </div>
			<%}	}%>
	    </div>
	
	</div>


<jsp:include page="adminpage-footer.jsp"></jsp:include>





<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
