<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>

<jsp:include page="header.jsp"></jsp:include>



	<div class="container">
	  <div class="row">
	
	   <!---------------categories--------------------->
	   <div class="col-md-3 col-8 col-sm-3 displaypic nav-links"> 
	     <div class="CATEFRAME  ">
	
	       <div class="CATE">Categories</div>
	       
	       <%
	       Connection conn = DbConfiguration.getDatabaseConnection();
	       String sqlcomm = "SELECT * FROM tbl_category";
	       PreparedStatement stmt = conn.prepareStatement(sqlcomm);
	       
	       ResultSet rss = stmt.executeQuery();

	       	int rowss = 0;
			while(rss.next()){
			rowss++;	
			
			String cateid = rss.getString("id");
			
	       %>
	
	       	   <!-- Default drop-left button -->
		       <div class="CATEFRAME dropleft">
		
		         <div class="dropdown-divider dividercolor"></div>
		         <a class="dropdown-item overflow"  href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><% out.print(rss.getString("name")); %></a>
		         
		         <div class="dropdown-menu">
		         
		         <%
			       String sqlcom1 = "SELECT * FROM tbl_subcategory WHERE cate_id=?";
			       PreparedStatement stmt1 = conn.prepareStatement(sqlcom1);
			       
			     	//bind values
					stmt1.setString(1, cateid);
					
			       ResultSet rs1 = stmt1.executeQuery();
		
			       	int rows1 = 0;
					while(rs1.next()){
					rows1++;	
					
			       %>
		
			           <a class="dropdown-item"  href="searchresults.jsp?subcategory=<% out.print(rs1.getString("id")); %>"> <% out.print(rs1.getString("name")); %> </a>
			           <div class="dropdown-divider dividercolor"></div>
			           
			       <%
					}
				   %>
		
		         </div>
		         
		       </div>
	       
	       
	       <%
			}
			
			//if no post available.
			if(rowss < 1 ){
			%>
				<div class="alert alert-secondary" role="alert">
				  No posts yet!.
				</div>
			<%
			}
   			%> 
	
	     
	
	     </div>
	     
	   </div> <br/>
	
	
	 
	   <!----------------------carousel slide--------------------->
	
	   <div class="col-12 col-md-9 displaypic">
	           
	     <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
	       <ol class="carousel-indicators">
	         <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
	         <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
	         <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	       </ol>
	       <div class="carousel-inner">
	         <div class="carousel-item active">
	           <img class="d-block w-100" src="imagers/imghome1.png" width="auto" height="80%" alt="First slide">
	         </div>
	         <div class="carousel-item">
	           <img class="d-block w-100" src="imagers/imghome2.png" width="auto" height="50%" alt="Second slide">
	         </div>
	         <div class="carousel-item">
	           <img class="d-block w-100" src="imagers/imghome3.png" width="auto" height="80%" alt="Third slide">
	         </div>
	       </div>
	       <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
	         <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	         <span class="sr-only">Previous</span>
	       </a>
	       <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
	         <span class="carousel-control-next-icon" aria-hidden="true"></span>
	         <span class="sr-only">Next</span>
	       </a>
	     </div>
	     <br/>
	
	     <!----------------------Flash Deals--------------------->
	     <p class="flashdeals">Flash Deals </p>
	     <div class="dropdown-divider dealsdivider"></div><br/>
	
	       <div class="container-fluid ">
	         <div class="row itemrow">
	         
	         
				<%
					
					String sql = "SELECT * FROM tbl_item";
					PreparedStatement stmts = conn.prepareStatement(sql);
					
					ResultSet rs = stmts.executeQuery();
					
					int rows = 0;
					while(rs.next()){
						rows++;
						%>
							
						   <!----------------------Item view--------------------->
				           <div class="col-6 col-md-3  clo1">
				
				               <div class="class1">
				
				                  <div class="imgagebox1">
				                      <img  class="imgageitm" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rs.getString("name")); %>.png">
				                  </div>
				
				                  
				                  <div class="dropdown-divider dividercolor1"></div>
				
				                  <div class="itemname">
				                      <p> <% out.print(rs.getString("name") + " "  + rs.getString("description")); %></p>                 
				                  </div>
				
				                  <div class="itemdiscountprice justifycenter">
				                      <span id="<% out.print(rs.getString("discount")+rs.getString("id")+rs.getString("discount")); %>"></span>                 
				                  </div>
				
				                  <div class="itemprice mb-2 justifycenter">
				                    <del><span id="<% out.print(rs.getString("price")+rs.getString("id")+rs.getString("price")); %>"></span></del>              
				                  </div>
				
				                  <div class="itemaviewbtn justifycenter">  				                    
				                      <a type="submit" class="btn btn-warning viewbtn" href="itempage.jsp?id=<% out.print(rs.getString("id"));%>">View Details</a>
				                  </div>
				           
				
				               </div>
				
				           </div>
							
							<!-- -------currency format-------- -->
							<script> 	               	
				               document.getElementById("<% out.print(rs.getString("price")+rs.getString("id")+rs.getString("price")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("price")); %>);
				               document.getElementById("<% out.print(rs.getString("discount")+rs.getString("id")+rs.getString("discount")); %>").innerText =  "Rs. " + formatMoney(<% out.print(rs.getString("discount")); %>);
				            </script>
							
						<%
					}
					
					//if no post available.
					if(rows < 1 ){
					%>
						<div class="alert alert-secondary" role="alert">
						  No posts yet!.
						</div>
					<%
					}
		   			%>    
			         
	         
	           
	           
	             
	
	         </div>
	       </div>
	
	
	    </div>
	
	  </div>
	</div>






<jsp:include page="footer.jsp"></jsp:include>