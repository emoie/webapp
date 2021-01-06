
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
		        <div class="col-md-9 col-12 cartitem">
		            
		            <%
		           int userid = (Integer) session.getAttribute("u_id");
		            
			       Connection conn = DbConfiguration.getDatabaseConnection();
			       String sqlcomm = "SELECT * FROM tbl_cart WHERE user_id=?";
			       PreparedStatement stmt = conn.prepareStatement(sqlcomm);
			       stmt.setInt(1,userid);
			       
			       ResultSet rs = stmt.executeQuery();
		
			       	int rows = 0;
					while(rs.next()){
					rows++;	
		
					}
					
					
					if(rows < 1 ){//if no products are available in the cart.
					%>
						<jsp:include page="emptycart.jsp"></jsp:include>
					<%
					}else{//if products are available in the cart.
					%>
						<jsp:include page="cartitempanel.jsp"></jsp:include>
					<%
					}
		   			%> 
		            
		
		        </div>
		
		        <div class="col-md-3 cartsummery <%if (rows < 1){ %>invisibel <%}%>">
		        
		        <%
					String sql = "SELECT SUM(i.discount*c.quantities) as Total FROM tbl_cart c INNER JOIN tbl_item i WHERE c.item_id =i.id AND c.user_id=?";
					PreparedStatement stmmt = conn.prepareStatement(sql);
					stmmt.setInt(1, userid);
					
					ResultSet rss = stmmt.executeQuery();
					
					int rowss = 0;
					while(rss.next()){
					rowss++;	
					
					int subtotal = rss.getInt("Total");
					int shippingfee = 150;
					int total = subtotal+shippingfee;
					
				%>
					        
		            <div class="summery">
		                <label class="unselectabel headingsummery mt-1">Order Summary</label>
		
		                <div class="dropdown-divider dealsdivider divider1  mb-3"></div>
		
		                <div class="subtotal">
		                    <label class="unselectabel">Subtotal</label>
		                    <label  id="subtot" class="unselectabel right"></label>               
		                </div>
		
		                <div class="subtotal">
		                    <label class="unselectabel">Shipping Fee</label>
		                    <label  id="shippingfee" class="unselectabel right"></label>               
		                </div>
		
		                <div class="dropdown-divider dealsdivider divider1 mb-2"></div>
		
		                <div class="subtotal1">
		                    <label class="unselectabel"><b>Total</b></label>
		                    <b><label id="grandtotal" class="unselectabel right"></label></b>               
		                </div>
						
						<form action="ordercheckout" method="post">
			                <div class="col-md-12 p-0 mt-2 mb-2">
			                    <a><button class="btn btn-primary form-control signinbtn checkoutbtn" type="submit" name="step" value="1" ><b>PROCEED TO CHECKOUT</b></button></a>
			                </div>
						</form>
		                    <script> 
		                        function formatMoney(amount, decimalCount = 2, decimal = ".", thousands = ",") {  try {  decimalCount = Math.abs(decimalCount); decimalCount = isNaN(decimalCount) ? 2 : decimalCount; const negativeSign = amount < 0 ? "-" : ""; let i = parseInt(amount = Math.abs(Number(amount) || 0).toFixed(decimalCount)).toString(); let j = (i.length > 3) ? i.length % 3 : 0; return negativeSign + (j ? i.substr(0, j) + thousands : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : ""); } catch (e) { console.log(e) } };
		                        document.getElementById("subtot").innerText =  "Rs. " + formatMoney(<%out.print(subtotal); %>);
		                        document.getElementById("shippingfee").innerText =  "Rs. " + formatMoney(<%out.print(shippingfee); %>);
		                        document.getElementById("grandtotal").innerText =  "Rs. " + formatMoney(<%out.print(total); %>);
		                    </script>
		                    
		                    
		            </div>
				<%} %>
		
		        </div>
		    </div>
		</div>


		
<%
}else{	
	response.sendRedirect("signin.jsp");
}
%>		

<jsp:include page="footer.jsp"></jsp:include>