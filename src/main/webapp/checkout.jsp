	
	
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<jsp:include page="header.jsp"></jsp:include>	
	
<%
if(session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){

%>
	
	<div class="container">
	    <div class="row">
	
	        <div class="cartdetails col-md-4 order-md-1">
	            <div class="col-md-12 order-md-2 mb-4">
	
	                <div class="alert alert-info titlecheckout unselectabel" role="alert">Your Cart...</div>
	
	                <ul class="list-group mb-3">
	                
	                	<%
	                	
	                	int userid = (Integer) session.getAttribute("u_id");
	                	
	                	Connection conn = DbConfiguration.getDatabaseConnection();
	                	String sql = "SELECT c.item_id, c.quantities, i.name, i.description, i.discount FROM tbl_item i INNER JOIN tbl_cart c WHERE c.item_id=i.id AND c.user_id=?";
	                	PreparedStatement stmt = conn.prepareStatement(sql);
	                	
	                	stmt.setInt(1, userid);
	                	
	                	ResultSet rs = stmt.executeQuery();
	                	
	                	int rows = 0;
	                	while(rs.next()) {
	        				rows++;
	        				
	        				int qnt = rs.getInt("quantities");
	        				int price = rs.getInt("discount");
	        				
	        				int tot = price * qnt;
	        				
	        				%>
	        				
	        				<li class="list-group-item d-flex justify-content-between lh-condensed">
		                        <div class="col-md-6 p-0">
		                            <h6 class="my-0 cheoutproductname"><%out.print(rs.getString("name")); %></h6>
		                            <small class="text-muted "><p class="maxhightfordec p-0 m-0"><%out.print(rs.getString("description")); %></p></small>
		                        </div>
		                        <span id="<%out.print(rs.getString("item_id")); %>" class="text-muted col-md-6 p-0 cheoutitemprice"></span>
		                    </li>
		                    
		                    <script> 
								document.getElementById("<%out.print(rs.getString("item_id")); %>").innerText = "Rs. " + formatMoney(<% out.print(tot); %>);    
			                </script>
	        				
	        				<%
	        				
	        			}
	        			
	        			//checking whether user entered data match with the database row
	        			if(rows > 0) {
	        				
	        				//Successfully logged in
	        				
	        				//System.out.println("Successfully logged in");
	        				
	        			}else {
	        				//login failed
	        				response.sendRedirect("cart.jsp");
	        			}
	                	
	                	%>
	                
	                                     
	                    
	                      <%
	                   	String sql1 = "SELECT SUM(c.quantities*i.discount) as total FROM tbl_item i INNER JOIN tbl_cart c WHERE c.item_id=i.id AND c.user_id =? ";
	                	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	                	stmt1.setInt(1, userid);
	                	
	                	ResultSet rs1 = stmt1.executeQuery();
	                	
	                	int rows1 = 0;
	                	while(rs1.next()) {
	        				rows1++;
	        				
	        			%>                     
	                   
		                    <li class="list-group-item d-flex justify-content-between">
		                        <strong><b>Total</b></strong>
		                        <b><strong id="tot"></strong></b>
		                    </li>
		                    
		                    <script> 
		                        document.getElementById("tot").innerText = "Rs. " + formatMoney(<% out.print(rs1.getString("total")); %>);    
			                </script>
				                    
	                    <%} %>
	                </ul>
	
	
	            </div>
	        </div>
	
	        <div class="billingdetails col-md-8 order-md-2">
	
	            <form class="needs-validation billingaddress" action="ordercheckout" method="post" novalidate>
	
	                <div class="alert alert-info mb-4 titlecheckout unselectabel" role="alert">Billing Address...</div>
	
	                <div class="chechout">
	
	                    <div class="form-group">
	                        <label for="inputname">Full Name*</label>
	                        <input name="fullname" type="text" class="form-control" id="inputname" placeholder="John Wick" required>
	                        <div class="invalid-feedback"> Full name required. </div>
	                    </div>
	                    <div class="form-row">
	                        <div class="form-group col-md-7">
	                            <label for="inputEmail4">Email*</label>
	                            <input name="email" type="email" class="form-control" id="inputEmail4" placeholder="Email" required>
	                            <div class="invalid-feedback"> Email required. </div>
	                        </div>
	                        <div class="form-group col-md-5">
	                            <label for="inputCity">Phone Number*</label>
	                            <input name="phone" type="tel" class="form-control" id="inputCity" maxlength="10" minlength="10" placeholder="07X XXX XXXX" required>
	                            <div class="invalid-feedback"> Mobile Number required. </div>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label for="inputAddress">Address*</label>
	                        <textarea name="address" type="text" class="form-control checkoutaddress" id="inputAddress" placeholder="1234 Main St" required></textarea>
	                        <div class="invalid-feedback"> Address required. </div>
	                    </div>
	
	                    <div class="row">
	                        <div class="col-md-5 mb-3">
	                            <label for="country">Country</label>
	                            <select name="country" class="custom-select d-block w-100" id="country" required>
	                            <option value="">Choose...</option>
	                            <option>Sri Lanka</option>
	                            </select>
	                            <div class="invalid-feedback"> Select Your Country</div>
	                        </div>
	                        <div class="col-md-4 mb-3">
	                            <label for="state">State</label>
	                            <select name="state" class="custom-select d-block w-100" id="state" required>
	                            <option value="">Choose...</option>
	                            <option>Colombo</option>
	                            </select>
	                            <div class="invalid-feedback"> Select Your State</div>
	                        </div>
	                        <div class="col-md-3 mb-3">
	                            <label for="zip">Zip</label>
	                            <input name="zip" type="text" class="form-control" id="zip" placeholder="" required>
	                            <div class="invalid-feedback"> Zip code required. </div>
	                        </div>
	                    </div>
	
	                    <div class="dropdown-divider "></div>
	
	                    <div class="col-md-12 p-0 mt-3" novalidate >
	                        <button type="submit" name="step" value="2" class="btn btn-primary form-control signinbtn">Continue to checkout</button>
	                    </div>
	
	                </div>     
	            
	            </form>
	            
	        </div>
	        
	
	    </div>
	</div>

	
<%
}else{
	
	response.sendRedirect("signin.jsp");
}
%>
	
	
<jsp:include page="footer.jsp"></jsp:include>	