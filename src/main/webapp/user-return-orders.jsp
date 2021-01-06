
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%

if(session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){
	
%>

<jsp:include page="myaccount-header.jsp"></jsp:include>



	
	    <div class="container">
	        <div class="row userdetailes">
	            
	            <div class="alert accountdetailstile unselectabel col-md-12" role="alert"><span>Order Returns...</span></div>
	            
	            
	
		            <!-------My Orders---------------->
		            <div class="col-md-12 colom01">
		            	<%
			            int userid = (Integer)session.getAttribute("u_id");
			        	
			        	Connection conn  = DbConfiguration.getDatabaseConnection();
			        	String sql = "SELECT order_id, total_price, `date&time`, `status` FROM tbl_order WHERE user_id =? AND status=?";
			        	PreparedStatement stmt = conn.prepareStatement(sql);
			        	
			        	stmt.setInt(1, userid);
			        	stmt.setString(2, "Returned");
			        	
			        	ResultSet rs = stmt.executeQuery();
			        	
			        	int rows = 0;
			        	
			        	while(rs.next()) {
			        		
			        		String orderid = rs.getString("order_id");
			        	%>
		            
		                <div class="dropdown-divider mt-3 dividercolor"></div>
		
		                <div class="orderitems  col-md-12">
		                
		                
				
			                    <div class="ordertimeandtotal col-md-12 col-12">
			                        <div class="orderiditems col-md-6 col-8">
			                            <label class="ordercode" >Order Code : <% out.print(rs.getString("order_id"));%></label>
			                            <p class="orderplacedtime">Placed on <% out.print(rs.getString("date&time"));%></p>
			                        </div>
			
			                        <div class="totaloforder col-md-6 col-4">
			                            <label  id="<% out.print(rs.getString("order_id"));%>" class="ordertotal center"></label>
			                        </div>
			                        
			                        <!-- -------currency format-------- -->
									<script> 	               	
						               document.getElementById("<% out.print(rs.getString("order_id"));%>").innerText =  "Refunded:   Rs. " + formatMoney(<% out.print(rs.getString("total_price")); %>);
						            </script>
						            
			                    </div>
			
			                    <div class="dropdown-divider dividercolor"></div>
			                    
			                    
			                    <%
					        	String sqli = "SELECT oi.`quantity`, i.`name`, i.`description` FROM tbl_orderinfor oi INNER JOIN tbl_item i WHERE oi.item_id=id AND oi.order_id=?";
					        	PreparedStatement stmti = conn.prepareStatement(sqli);
					        	
					        	stmti.setString(1, orderid);
					        	
					        	ResultSet rsi = stmti.executeQuery();
					        	
					        	int rowsi = 0;
					        	
					        	while(rsi.next()) {
					        		rowsi++;
					        	%>                 
				                    <!-------Order Items---------------->
				                    <div class="orderitem col-md-12 justify-content-md-center">
				                        <div class="itemorder col-md-2 center">
				                            <div class="itemorderimg justifycenter"><img width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rsi.getString("name"));%>.png"></div>
				                        </div>
				                        <div class="decitemorder col-md-3 center">
				                            <div class="dec m-0">
				                                <p class="prodec"> <% out.print(rsi.getString("description"));%> </p>
				                            </div> 
				                        </div>
				                        <div class="qntorderitm col-md-3 center">
				                            <div class="statusimg justifycenter center"><span class="itemqnt justifycenter">Qnt - <% out.print(rsi.getString("quantity"));%></span></div>
				                        </div>
				                        <div class="orderitemstatus col-md-3 pl-0 pr-0 center">
				                            <div class="statusimg justifycenter center"><span class="itemstatus justifycenter"><center><b><% out.print(rs.getString("status"));%></b><center></span></div>
				                        </div>                        
				                    </div>
			                <%}%>
		                    
		                </div>
						<%}%>
		            </div>
		       
	            
	
	        </div>
	    </div>
	
	

<%} %>



<jsp:include page="myaccount-footer.jsp"></jsp:include>

