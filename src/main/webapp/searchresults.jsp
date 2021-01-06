


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>

<%if(request.getParameter("search") != null && request.getParameter("search") != "" || request.getParameter("category") != null || request.getParameter("subcategory") != null){ %>

<jsp:include page="header.jsp"></jsp:include>


	<% 
	
	String search = "";
	String category = "";
	String subcategory = "";
	String sort ="BM";
	
	System.out.println(search);
	
	if(request.getAttribute("sort") != null){
	sort = request.getAttribute("sort").toString();
	}
	
	if(request.getParameter("search") != null){
		 search = request.getParameter("search").toString();
		 session.setAttribute("search", search);
		 session.setAttribute("searchname", "search=");
		 
		 
	}else if(request.getParameter("category") != null){
		 category = request.getParameter("category").toString();
		 session.setAttribute("search", category);
		 session.setAttribute("searchname", "category=");
		 
		 
	}else if(request.getParameter("subcategory") != null){
		subcategory = request.getParameter("subcategory").toString();
		session.setAttribute("search", subcategory);
		session.setAttribute("searchname", "subcategory=");
		
	}
	
	
	
	
	%>
	
	<form action="sort" method="post">
	<div class="container-fluid">
	    <div class="row">
	
	        
	
	        <div class="searchresults col-md-10 offset-md-1">
	
	            
	            <div class="adver col-md- color01">
	                <img width="100%" height="auto" alt="N/A" src="imagers/AAAA.png">
	            </div>
	
	            <div class="dropdown-divider removepaddingon"></div>
	
	            <div class="searchheader center">
	                <div class="searchedkeyword col-6 col-md-9 ">
	                    <span class="mr-2 searchtext3">Your search - <%if(request.getParameter("search") != null){ out.print(search); }%> </span>  
	                </div>        
	                <div class="sort col-md-3 col-6 center">
	                    <div class="searchedkeyword p-0 col-md-4 col-4 ">
	                        <span class="sorttextsite center">Sort by : </span>            
	                    </div>  
	                    
	                    <div class="col-md- p-0 col-8">
		                    
		                        <select name="sort" type="select" id="cate" onchange='if(this.value != 0) { this.form.submit(); }'  class="custom-select form-control uppercase loginemail customerf sizeofsorttext" required autofocus >
		                            <option <%if(sort.equals("BM")){out.print("selected");}%>>Best Match</option>
		                            <option <%if(sort.equals("PLH")){out.print("selected");}%>>Price Low to High</option>
		                            <option <%if(sort.equals("PHL")){out.print("selected");}%>>Price High to Low</option>
		                            
		                        </select>      
	                    </div>
	                    	                    
	                </div>
	            </div>
	        
	
	            <div class="dropdown-divider"></div>
	
	
	            <div class="row results">
	            
	            <%
	            
	            Connection conn = DbConfiguration.getDatabaseConnection();
	            
	            if(request.getParameter("search") != null){
	            	
	            	if(sort.equals("PLH")){	            	
	            		String sql = "SELECT `id`, `name`, `description`, `price`, `discount` FROM tbl_item WHERE `name` LIKE CONCAT('%',?)  OR `brand` LIKE CONCAT('%',?) OR `description` LIKE CONCAT('%',?) ORDER BY price ASC";
	            		PreparedStatement stmt = conn.prepareStatement(sql);
			            
			            stmt.setString(1, search);
			            stmt.setString(2, search);
			            stmt.setString(3, search);
			            
						ResultSet rs = stmt.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							
							%>		
							<!----------------------Item view--------------------->
			                <div class="col-6 col-md-3  clo1">
			
			                    <div class="class1 bocsearch">
			
			                        <div class="imgagebox1 searchitemimgage">
			                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
			                        </div>
			
			                        
			                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
			
			                        <div class="itemnames moditiemname justifycenter">
			                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
			                        </div>
			
			                        <div class="itemdiscountprice disprofd">
			                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
			                        </div>
			
			                        <div class="itemprice realptices justifycenter">
			                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
			                        </div>
			
			                        <div class="itemaviewbtn padseds justifycenter">
				                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
			                        </div>
			                        
			                        <!-- -------currency format-------- -->
									<script> 	               	
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
						            </script>
			                
			
			                    </div>
			
			                </div>
			                
						<%
							
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}
	            	
	            	}else if(sort.equals("PHL")){	            	
	            		String sql = "SELECT `id`, `name`, `description`, `price`, `discount` FROM tbl_item WHERE `name` LIKE CONCAT('%',?)  OR `brand` LIKE CONCAT('%',?) OR `description` LIKE CONCAT('%',?) ORDER BY price DESC";
	            		PreparedStatement stmt = conn.prepareStatement(sql);
			            
			            stmt.setString(1, search);
			            stmt.setString(2, search);
			            stmt.setString(3, search);
			            
						ResultSet rs = stmt.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							
							%>		
							<!----------------------Item view--------------------->
			                <div class="col-6 col-md-3  clo1">
			
			                    <div class="class1 bocsearch">
			
			                        <div class="imgagebox1 searchitemimgage">
			                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
			                        </div>
			
			                        
			                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
			
			                        <div class="itemnames moditiemname justifycenter">
			                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
			                        </div>
			
			                        <div class="itemdiscountprice disprofd">
			                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
			                        </div>
			
			                        <div class="itemprice realptices justifycenter">
			                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
			                        </div>
			
			                        <div class="itemaviewbtn padseds justifycenter">
				                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
			                        </div>
			                        
			                        <!-- -------currency format-------- -->
									<script> 	               	
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
						            </script>
			                
			
			                    </div>
			
			                </div>
			                
						<%
							
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}
	            	
	            	}else if(sort.equals("BM")){
	            		String sql = "SELECT `id`, `name`, `description`, `price`, `discount` FROM tbl_item WHERE `name` LIKE CONCAT('%',?)  OR `brand` LIKE CONCAT('%',?) OR `description` LIKE CONCAT('%',?)";
	            		PreparedStatement stmt = conn.prepareStatement(sql);
			            
			            stmt.setString(1, search);
			            stmt.setString(2, search);
			            stmt.setString(3, search);
			            
						ResultSet rs = stmt.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							
							%>		
							<!----------------------Item view--------------------->
			                <div class="col-6 col-md-3  clo1">
			
			                    <div class="class1 bocsearch">
			
			                        <div class="imgagebox1 searchitemimgage">
			                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
			                        </div>
			
			                        
			                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
			
			                        <div class="itemnames moditiemname justifycenter">
			                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
			                        </div>
			
			                        <div class="itemdiscountprice disprofd">
			                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
			                        </div>
			
			                        <div class="itemprice realptices justifycenter">
			                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
			                        </div>
			
			                        <div class="itemaviewbtn padseds justifycenter">
				                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
			                        </div>
			                        
			                        <!-- -------currency format-------- -->
									<script> 	               	
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
						            </script>
			                
			
			                    </div>
			
			                </div>
			                
						<%
							
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}
					}
	            	
	            	
	            	         
		            
		       	}else if(request.getParameter("subcategory") != null){
		       		
		       		if(sort.equals("PLH")){
		       			
		       			String sqli = "SELECT * FROM tbl_item WHERE subcate_id=? ORDER BY price ASC";
	            		PreparedStatement stmti = conn.prepareStatement(sqli);
			            
			            stmti.setString(1, subcategory);

						ResultSet rs = stmti.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							%>		
							<!----------------------Item view--------------------->
			                <div class="col-6 col-md-3  clo1">
			
			                    <div class="class1 bocsearch">
			
			                        <div class="imgagebox1 searchitemimgage">
			                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
			                        </div>
			
			                        
			                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
			
			                        <div class="itemnames moditiemname justifycenter">
			                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
			                        </div>
			
			                        <div class="itemdiscountprice disprofd">
			                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
			                        </div>
			
			                        <div class="itemprice realptices justifycenter">
			                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
			                        </div>
			
			                        <div class="itemaviewbtn padseds justifycenter">
				                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
			                        </div>
			                        
			                        <!-- -------currency format-------- -->
									<script> 	               	
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
						            </script>
			                
			
			                    </div>
			
			                </div>
			                
						<%
							
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}
		       			
		       			
		       		}else if(sort.equals("PHL")){
		       			
		       			String sqli = "SELECT * FROM tbl_item WHERE subcate_id=? ORDER BY price DESC";
	            		PreparedStatement stmti = conn.prepareStatement(sqli);
			            
			            stmti.setString(1, subcategory);

						ResultSet rs = stmti.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							%>		
							<!----------------------Item view--------------------->
			                <div class="col-6 col-md-3  clo1">
			
			                    <div class="class1 bocsearch">
			
			                        <div class="imgagebox1 searchitemimgage">
			                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
			                        </div>
			
			                        
			                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
			
			                        <div class="itemnames moditiemname justifycenter">
			                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
			                        </div>
			
			                        <div class="itemdiscountprice disprofd">
			                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
			                        </div>
			
			                        <div class="itemprice realptices justifycenter">
			                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
			                        </div>
			
			                        <div class="itemaviewbtn padseds justifycenter">
				                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
			                        </div>
			                        
			                        <!-- -------currency format-------- -->
									<script> 	               	
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
						            </script>
			                
			
			                    </div>
			
			                </div>
			                
						<%
							
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}
		       			
		       		}else if(sort.equals("BM")){
		       			
		       			String sqli = "SELECT * FROM tbl_item WHERE subcate_id=?";
	            		PreparedStatement stmti = conn.prepareStatement(sqli);
			            
			            stmti.setString(1, subcategory);

						ResultSet rs = stmti.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							%>		
							<!----------------------Item view--------------------->
			                <div class="col-6 col-md-3  clo1">
			
			                    <div class="class1 bocsearch">
			
			                        <div class="imgagebox1 searchitemimgage">
			                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
			                        </div>
			
			                        
			                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
			
			                        <div class="itemnames moditiemname justifycenter">
			                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
			                        </div>
			
			                        <div class="itemdiscountprice disprofd">
			                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
			                        </div>
			
			                        <div class="itemprice realptices justifycenter">
			                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
			                        </div>
			
			                        <div class="itemaviewbtn padseds justifycenter">
				                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
			                        </div>
			                        
			                        <!-- -------currency format-------- -->
									<script> 	               	
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
						               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
						            </script>
			                
			
			                    </div>
			
			                </div>
			                
						<%
							
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}
		       			
		       		}
		       		
	            		
		       		
		            

		       	}else if(request.getParameter("category") != null){
		       		
		       		if(sort.equals("PLH")){
		       			
		       			String sql = "SELECT cate.`cate_id`, i.`id`, i.`name`, i.`description`, i.`price`, i.`discount` FROM tbl_item i INNER JOIN tbl_subcategory cate WHERE i.subcate_id=cate.id AND cate.cate_id=? ORDER BY price ASC";
	            		PreparedStatement stmt = conn.prepareStatement(sql);
			            
			            stmt.setString(1, category);
			            
			            ResultSet rs = stmt.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							
							%>		
								<!----------------------Item view--------------------->
				                <div class="col-6 col-md-3  clo1">
				
				                    <div class="class1 bocsearch">
				
				                        <div class="imgagebox1 searchitemimgage">
				                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
				                        </div>
				
				                        
				                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
				
				                        <div class="itemnames moditiemname justifycenter">
				                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
				                        </div>
				
				                        <div class="itemdiscountprice disprofd">
				                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
				                        </div>
				
				                        <div class="itemprice realptices justifycenter">
				                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
				                        </div>
				
				                        <div class="itemaviewbtn padseds justifycenter">
					                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
				                        </div>
				                        
				                        <!-- -------currency format-------- -->
										<script> 	               	
							               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
							               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
							            </script>
				                
				
				                    </div>
				
				                </div>
				                
							<%					
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}
		       			
		       		}else if(sort.equals("PHL")){
		       			
		       			String sql = "SELECT cate.`cate_id`, i.`id`, i.`name`, i.`description`, i.`price`, i.`discount` FROM tbl_item i INNER JOIN tbl_subcategory cate WHERE i.subcate_id=cate.id AND cate.cate_id=? ORDER BY price DESC";
	            		PreparedStatement stmt = conn.prepareStatement(sql);
			            
			            stmt.setString(1, category);
			            
			            ResultSet rs = stmt.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							
							%>		
								<!----------------------Item view--------------------->
				                <div class="col-6 col-md-3  clo1">
				
				                    <div class="class1 bocsearch">
				
				                        <div class="imgagebox1 searchitemimgage">
				                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
				                        </div>
				
				                        
				                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
				
				                        <div class="itemnames moditiemname justifycenter">
				                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
				                        </div>
				
				                        <div class="itemdiscountprice disprofd">
				                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
				                        </div>
				
				                        <div class="itemprice realptices justifycenter">
				                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
				                        </div>
				
				                        <div class="itemaviewbtn padseds justifycenter">
					                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
				                        </div>
				                        
				                        <!-- -------currency format-------- -->
										<script> 	               	
							               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
							               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
							            </script>
				                
				
				                    </div>
				
				                </div>
				                
							<%					
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}

		       			
		       		}else if(sort.equals("BM")){
		       			
		       			String sql = "SELECT cate.`cate_id`, i.`id`, i.`name`, i.`description`, i.`price`, i.`discount` FROM tbl_item i INNER JOIN tbl_subcategory cate WHERE i.subcate_id=cate.id AND cate.cate_id=?";
	            		PreparedStatement stmt = conn.prepareStatement(sql);
			            
			            stmt.setString(1, category);
			            
			            ResultSet rs = stmt.executeQuery();
			            
			            int rows = 0;
						
						while(rs.next()) {
							rows++;
							
							%>		
								<!----------------------Item view--------------------->
				                <div class="col-6 col-md-3  clo1">
				
				                    <div class="class1 bocsearch">
				
				                        <div class="imgagebox1 searchitemimgage">
				                            <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
				                        </div>
				
				                        
				                        <div class="dropdown-divider dividercolor1 paddingsix"></div>
				
				                        <div class="itemnames moditiemname justifycenter">
				                            <p><% out.print(rs.getString("name") + " " + rs.getString("description")); %></p>                 
				                        </div>
				
				                        <div class="itemdiscountprice disprofd">
				                            <span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
				                        </div>
				
				                        <div class="itemprice realptices justifycenter">
				                            <del><span id="<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
				                        </div>
				
				                        <div class="itemaviewbtn padseds justifycenter">
					                            <a type="button" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>" >View Details</a>
				                        </div>
				                        
				                        <!-- -------currency format-------- -->
										<script> 	               	
							               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
							               document.getElementById("<% out.print(rs.getString("id")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
							            </script>
				                
				
				                    </div>
				
				                </div>
				                
							<%					
							
						}if(rows > 0) {
							
						}else {
							%>
							<div class="col-12 col-md-12 clo1 mt-5 pb-0"><center>No Products Found</center></div>					
							<%
						}

		       		}

		       	}
	            
	            
	            
	            
	            %>

	
	                
	                
	            </div>
	
	        </div>
	    </div>
	</div>
</form>	
	

<%}else{
	response.sendRedirect("index.jsp");
}%>



<jsp:include page="footer.jsp"></jsp:include>