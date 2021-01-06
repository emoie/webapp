<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>


<jsp:include page="adminpage-header.jsp"></jsp:include>




	<div class="alert alert-info mb-4 unselectabel" role="alert">Orders...</div>
	
	<div class="col-5 col-md-11 mr-5 ml-5">
	
	    <nav>
	        <div class="nav nav-tabs tabnav" id="nav-tab" role="tablist">
	            <a class="nav-item nav-link <%if(request.getAttribute("orderid") == null && request.getAttribute("ship") == null ){ out.print("active");} %>  tabnav" data-toggle="tab" href="#pending-orders" role="tab" aria-controls="pending-orders" aria-selected="true">Pending Orders</a>
	            <a class="nav-item nav-link <%if(request.getAttribute("orderid") != null && request.getAttribute("ship") == null){ out.print("active");} %> tabnav" data-toggle="tab" href="#order-details" role="tab" aria-controls="order-details" aria-selected="false">Order Details</a>
	            <a class="nav-item nav-link <%if(request.getAttribute("orderid") == null && request.getAttribute("ship") != null){ out.print("active");} %> tabnav" data-toggle="tab" href="#redy-to-ship" role="tab" aria-controls="redy-to-ship" aria-selected="false">Ready to Ship Orders</a>
	            <a class="nav-item nav-link tabnav" data-toggle="tab" href="#delivered-orders" role="tab" aria-controls="delivered-orders" aria-selected="false">Succussfully Deliverd Orders</a>
	        </div>
	    </nav>
	
	    <div class="tab-content mt-4" id="nav-tabContent">
	
	        <div class="tab-pane fade <%if(request.getAttribute("orderid") == null && request.getAttribute("ship") == null ){ out.print("show active");} %> " id="pending-orders" role="tabpanel">  <jsp:include page="pendingorders.jsp"></jsp:include>   </div>
	        <div class="tab-pane fade <%if(request.getAttribute("orderid") != null && request.getAttribute("ship") == null){ out.print("show active");} %> unselectabel" id="order-details" role="tabpanel">  <jsp:include page="orderdetails.jsp"></jsp:include>   </div>
	        <div class="tab-pane fade <%if(request.getAttribute("orderid") == null && request.getAttribute("ship") != null){ out.print("show active");} %> unselectabel" id="redy-to-ship" role="tabpanel">  <jsp:include page="readytoship.jsp"></jsp:include>   </div>
	        <div class="tab-pane fade unselectabel" id="delivered-orders" role="tabpanel">  <jsp:include page="deliverdorders.jsp"></jsp:include>   </div>
	
	    </div>
	
	</div>




<jsp:include page="adminpage-footer.jsp"></jsp:include>

<%}else{
	response.sendRedirect("signin.jsp");	
}%> 