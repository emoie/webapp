

<%@page import="java.sql.ResultSet"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<jsp:include page="header.jsp"></jsp:include>	



	<div class="container">
	    <div class="row justify-content-center">
	
	    <div class="col-md-4 cartsummery32  order-md-2">
	        
	        <%
	        int userid = (Integer) session.getAttribute("u_id");
	        
	        Connection conn = DbConfiguration.getDatabaseConnection();
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
	            <label class="unselectabel titlecheckout sixetxt mt-1">Order Summary</label>
	
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
	                <label id="totalprice" class="unselectabel right"></label>               
	            </div>
	                <script> 
                       document.getElementById("subtot").innerText =  "Rs. " + formatMoney(<%out.print(subtotal); %>);
                       document.getElementById("shippingfee").innerText =  "Rs. " + formatMoney(<%out.print(shippingfee); %>);
                       document.getElementById("totalprice").innerText =  "Rs. " + formatMoney(<%out.print(total); %>);
                    </script>                    
		                    
            </div>
		<%} %>
	
	
	    </div>
	
	        <div class="paymentdetails col-md-5 order-md-1">
	
	            <div class="alert alert-info mb-4 titlecheckout unselectabel" role="alert">Select Payment Method...</div>
	            
	            <div class="payment">
	                <nav class="mb-4">
	                    <div class="nav nav-tabs paymethod" id="nav-tab" role="tablist">
	                        <a class="nav-item nav-link active paymethod" id="nav-card-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Credit/Debit Card</a>
	                        <a class="nav-item nav-link paymethod" id="nav-cod-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Cash On Delivery</a>
	                    </div>
	                </nav>
	
	                <div class="tab-content" id="nav-tabContent">
	                    <div class="tab-pane fade show active paymethoddiv" id="nav-home" role="tabpanel" aria-labelledby="nav-card-tab">
	
	                        <form class="needs-validation" novalidate action="ordercheckout" method="post"> 
	                            <div class=" mb-2">
	                                <label for="cc-number">Credit card number</label>
	                                <input name="method" type="tel" inputmode="numeric" pattern="[0-9\s]{13,19}" autocomplete="cc-number" class="form-control" 		="16" maxlength="16" id="cc-number" placeholder="" required>
	                            </div>
	                            <div class=" mb-2">
	                                <label for="cc-name">Name on card</label>
	                                <input name="cardname" type="text" class="form-control" id="cc-name" placeholder="" required>
	                            </div>                            
	                            <div class="row">
	                                <div class="col-md-3 mb-2">
	                                    <label for="cc-expiration">Expiration</label>
	                                    <input name="expir" type="text" class="form-control" minlength="5" maxlength="5" id="cc-expiration" placeholder="" required>
	                                </div>
	                                <div class="col-md-3 mb-2">
	                                    <label for="cc-cvv">CVV</label>
	                                    <input name="cvv" type="text" class="form-control" minlength="3" maxlength="3" id="cc-cvv" placeholder="" required>
	                                </div>
	                            </div>
	                            
	                            <hr class="mb-2">
	                            
                            	<button name="step" value="3" class="btn btn-primary btn-lg btn-block" type="submit">Pay Now</button>
							
	                        </form>
	                    </div>
	
	                    <div class="tab-pane fade khfgdg" id="nav-profile" role="tabpanel" aria-labelledby="nav-cod-tab">
	                        You can pay in cash to our courier when you receive the goods at your doorstep.
	                    
	                        <hr class="mb-4">
	
	                        <form class="form-signin" action="ordercheckout" method="post">
	                        	<input name="method" value="COD" class="invisibel">
	                        	<button name="step" value="3" class="btn btn-primary btn-block" type="submit">Confirm Order</button>
	                        </form>
	                    
	                    </div>
	
	                </div>
	            </div>
	                        
	            
	        </div>
	
	        
	    </div>
	</div>



<jsp:include page="footer.jsp"></jsp:include>	