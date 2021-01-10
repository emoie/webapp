<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>



<jsp:include page="adminpage-header.jsp"></jsp:include>







    <div class="alert alert-info mb-4 unselectabel" role="alert">Products...</div>

    <div class="col-5 col-md-11 mr-5 ml-5">

        <nav>
            <div class="nav nav-tabs tabnav" id="nav-tab" role="tablist">
                <a class="nav-item nav-link <%if(request.getAttribute("catego") == null && request.getAttribute("subcate") == null && request.getAttribute("addedproduct") == null && request.getAttribute("productid") == null && request.getAttribute("productdelete") == null && request.getAttribute("produid") == null && request.getAttribute("productupdatek") == null){ out.print("active");} %> tabnav" data-toggle="tab" href="#product-details" role="tab" aria-controls="product-details" aria-selected="true">Product Details</a>
                <a class="nav-item <%if(session.getAttribute("u_position").equals(4)){ out.print("disabled"); } %> nav-link <%if(request.getAttribute("catego") != null || request.getAttribute("subcate") != null || request.getAttribute("addedproduct") != null){ out.print("active");} %> tabnav" data-toggle="tab" href="#add-products" role="tab" aria-controls="add-products" aria-selected="false">Add New Products</a>
                <a class="nav-item <%if(session.getAttribute("u_position").equals(4)){ out.print("disabled"); } %> nav-link <%if(request.getAttribute("produid") != null || request.getAttribute("productupdatek") != null){ out.print("active");} %>  tabnav" data-toggle="tab" href="#update-products" role="tab" aria-controls="update-products" aria-selected="false">Update Products</a>
                <a class="nav-item <%if(session.getAttribute("u_position").equals(5) || session.getAttribute("u_position").equals(4)){ out.print("disabled"); } %> nav-link <%if(request.getAttribute("productid") != null || request.getAttribute("productdelete") != null){ out.print("active");} %> tabnav" data-toggle="tab" href="#delete-products" role="tab" aria-controls="delete-products" aria-selected="false">Delete Products</a>
            </div>
        </nav>

        <div class="tab-content mt-4" id="nav-tabContent">

            <div class="tab-pane fade unselectabel <%if(request.getAttribute("catego") == null && request.getAttribute("subcate") == null && request.getAttribute("addedproduct") == null && request.getAttribute("addedproduct") == null && request.getAttribute("productid") == null && request.getAttribute("productdelete") == null && request.getAttribute("produid") == null && request.getAttribute("productupdatek") == null){ out.print("show active");} %>" id="product-details" role="tabpanel">  <jsp:include page="productinfor.jsp"></jsp:include>   </div>
            <%if(!session.getAttribute("u_position").equals(4)){%>
	            <div class="tab-pane fade unselectabel <%if(request.getAttribute("catego") != null || request.getAttribute("subcate") != null || request.getAttribute("addedproduct") != null){ out.print("show active");} %>" id="add-products" role="tabpanel">  <jsp:include page="addproducts.jsp"></jsp:include>   </div>
	            <div class="tab-pane fade unselectabel <%if(request.getAttribute("produid") != null || request.getAttribute("productupdatek") != null){ out.print("show active");} %> " id="update-products" role="tabpanel">  <jsp:include page="updateproducts.jsp"></jsp:include>   </div>
	            <%if(!session.getAttribute("u_position").equals(5)){%>
	            	<div class="tab-pane fade unselectabel <%if(request.getAttribute("productid") != null || request.getAttribute("productdelete") != null){ out.print("show active");} %> " id="delete-products" role="tabpanel">  <jsp:include page="deleteproducts.jsp"></jsp:include>   </div>
			<%}	}%>
        </div>

    </div>
    
    
    
<jsp:include page="adminpage-footer.jsp"></jsp:include>



<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
