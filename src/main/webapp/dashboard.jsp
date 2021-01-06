


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>

<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>

<jsp:include page="adminpage-header.jsp"></jsp:include>

			<%
			
			
			int totproducts = 0;
			int availableinventry = 0;
			int totorders = 0;
			int networth = 0;
			int totcustomers = 0; 
			int totstaff = 0;
			int pendingorders = 0;
			int readytoship = 0;
			        	
        	Connection conn = DbConfiguration.getDatabaseConnection();
        	
        		//========================TOTAL products AND AVAILABLE PRODUCTS=======================================
	        	String sql = "SELECT COUNT(name) as totproducts, (COUNT(name)*SUM(quantity)) as availableproducts  FROM tbl_item";
	        	PreparedStatement stmt = conn.prepareStatement(sql);
	        	
	        	ResultSet rs = stmt.executeQuery();
	        	
				int rows = 0;
				
				while(rs.next()) {
					rows++;
					
					totproducts = rs.getInt("totproducts");
					availableinventry = rs.getInt("availableproducts");				
				}
				
				//========================TOTAL ORDERS AND AVAILABLE networth=======================================
	        	String sql1 = "SELECT COUNT(order_id) as totorders, SUM(total_price) as networth  FROM tbl_order";
	        	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	        	
	        	ResultSet rs1 = stmt1.executeQuery();
	        	
				int rows1 = 0;
				
				while(rs1.next()) {
					rows1++;
					
					totorders = rs1.getInt("totorders");
					networth = rs1.getInt("networth");
				}
				
				//========================PENDING ORDERS=======================================
	        	String sql2 = "SELECT COUNT(order_id) as pendingorders FROM tbl_order WHERE `status`=?";
	        	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	        	stmt2.setString(1, "Order Confirmed");
	        	ResultSet rs2 = stmt2.executeQuery();
	        	
				int rows2 = 0;
				
				while(rs2.next()) {
					rows2++;
					
					pendingorders = rs2.getInt("pendingorders");
				}
				
				//========================READY TO SHIP ORDERS=======================================
	        	String sql3 = "SELECT COUNT(order_id) as readytoship FROM tbl_order WHERE `status`=?";
	        	PreparedStatement stmt3 = conn.prepareStatement(sql3);
	        	stmt3.setString(1, "Ready to Ship");
	        	ResultSet rs3 = stmt3.executeQuery();
	        	
				int rows3 = 0;
				
				while(rs3.next()) {
					rows3++;
					
					readytoship = rs3.getInt("readytoship");
				}
			
				//========================TOTAL CUSTOMERS=======================================
	        	String sql4 = "SELECT COUNT(user_id) as totcustomers FROM tbl_user WHERE `position_id` = ?";
	        	PreparedStatement stmt4 = conn.prepareStatement(sql4);
	        	stmt4.setInt(1, 3);
	        	ResultSet rs4 = stmt4.executeQuery();
	        	
				int rows4 = 0;
				
				while(rs4.next()) {
					rows4++;
					
					totcustomers = rs4.getInt("totcustomers");
				}
				
				//========================TOTAL CUSTOMERS=======================================
	        	String sql5 = "SELECT COUNT(user_id) as totstaff FROM tbl_user WHERE `position_id` != ?";
	        	PreparedStatement stmt5 = conn.prepareStatement(sql5);
	        	stmt5.setInt(1, 3);
	        	ResultSet rs5 = stmt5.executeQuery();
	        	
				int rows5 = 0;
				
				while(rs5.next()) {
					rows5++;
					
					totstaff = rs5.getInt("totstaff");
				}
			
			
			
        	%>









	<div class="alert alert-info mb-4 unselectabel" role="alert">Dashboard...</div>

    <div class="container">
        <div class="row dashitems unselectabel">

            <div class="col-md-3 allproducts">

                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-shop mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z"/>
                </svg><br/>

                <label class="dashitemsname"> Total Products </label><br/>
                <label class="nofitems"><%out.print(totproducts);%></label>

            </div>

            <div class="col-md-3 allproducts">
                
                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-diagram-3 mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5v-1zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5v-1zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5v-1zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5v-1zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1z"/>
                </svg><br/>

                <label class="dashitemsname"> Available Inventory </label><br/>
                <label class="nofitems"> <%out.print(availableinventry);%></label>

            </div>

            <div class="col-md-3 allproducts">
                
                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-cart-check mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm7 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                <path fill-rule="evenodd" d="M11.354 5.646a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                </svg><br/>
                

                <label class="dashitemsname"> Total Orders </label><br/>
                <label class="nofitems"> <%out.print(totorders);%></label>

            </div>

            <div class="col-md-3 allproducts">
                
                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-cash-stack mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path d="M14 3H1a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1h-1z"/>
                <path fill-rule="evenodd" d="M15 5H1v8h14V5zM1 4a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V5a1 1 0 0 0-1-1H1z"/>
                <path d="M13 5a2 2 0 0 0 2 2V5h-2zM3 5a2 2 0 0 1-2 2V5h2zm10 8a2 2 0 0 1 2-2v2h-2zM3 13a2 2 0 0 0-2-2v2h2zm7-4a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                </svg><br/>

                <label class="dashitemsname "> Net Worth </label><br/>
                <label  id="number" class="nofitems" value="1058470.20" ></label>

                    <script> 
                        document.getElementById("number").innerText =  "Rs. " + formatMoney(<%out.print(networth);%>);
                    </script>

            </div>


            <div class="col-md-3 allproducts">
                
                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-person-bounding-box mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M1.5 1a.5.5 0 0 0-.5.5v3a.5.5 0 0 1-1 0v-3A1.5 1.5 0 0 1 1.5 0h3a.5.5 0 0 1 0 1h-3zM11 .5a.5.5 0 0 1 .5-.5h3A1.5 1.5 0 0 1 16 1.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 1-.5-.5zM.5 11a.5.5 0 0 1 .5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 1 0 1h-3A1.5 1.5 0 0 1 0 14.5v-3a.5.5 0 0 1 .5-.5zm15 0a.5.5 0 0 1 .5.5v3a1.5 1.5 0 0 1-1.5 1.5h-3a.5.5 0 0 1 0-1h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 1 .5-.5z"/>
                <path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                </svg><br/>
                

                <label class="dashitemsname"> Total Customers Count</label><br/>
                <label class="nofitems"> <%out.print(totcustomers);%></label>

            </div>

            <div class="col-md-3 allproducts">
                
                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-tools mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M0 1l1-1 3.081 2.2a1 1 0 0 1 .419.815v.07a1 1 0 0 0 .293.708L10.5 9.5l.914-.305a1 1 0 0 1 1.023.242l3.356 3.356a1 1 0 0 1 0 1.414l-1.586 1.586a1 1 0 0 1-1.414 0l-3.356-3.356a1 1 0 0 1-.242-1.023L9.5 10.5 3.793 4.793a1 1 0 0 0-.707-.293h-.071a1 1 0 0 1-.814-.419L0 1zm11.354 9.646a.5.5 0 0 0-.708.708l3 3a.5.5 0 0 0 .708-.708l-3-3z"/>
                <path fill-rule="evenodd" d="M15.898 2.223a3.003 3.003 0 0 1-3.679 3.674L5.878 12.15a3 3 0 1 1-2.027-2.027l6.252-6.341A3 3 0 0 1 13.778.1l-2.142 2.142L12 4l1.757.364 2.141-2.141zm-13.37 9.019L3.001 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026z"/>
                </svg><br/>
                

                <label class="dashitemsname"> Total Staff Count </label><br/>
                <label class="nofitems"> <%out.print(totstaff);%></label>

            </div>


            <div class="col-md-3 allproducts">
                
                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-upc-scan mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M1.5 1a.5.5 0 0 0-.5.5v3a.5.5 0 0 1-1 0v-3A1.5 1.5 0 0 1 1.5 0h3a.5.5 0 0 1 0 1h-3zM11 .5a.5.5 0 0 1 .5-.5h3A1.5 1.5 0 0 1 16 1.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 1-.5-.5zM.5 11a.5.5 0 0 1 .5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 1 0 1h-3A1.5 1.5 0 0 1 0 14.5v-3a.5.5 0 0 1 .5-.5zm15 0a.5.5 0 0 1 .5.5v3a1.5 1.5 0 0 1-1.5 1.5h-3a.5.5 0 0 1 0-1h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 1 .5-.5z"/>
                <path d="M3 4.5a.5.5 0 0 1 1 0v7a.5.5 0 0 1-1 0v-7zm2 0a.5.5 0 0 1 1 0v7a.5.5 0 0 1-1 0v-7zm2 0a.5.5 0 0 1 1 0v7a.5.5 0 0 1-1 0v-7zm2 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-7zm3 0a.5.5 0 0 1 1 0v7a.5.5 0 0 1-1 0v-7z"/>
                </svg><br/>
                

                <label class="dashitemsname"> Pending Orders </label><br/>
                <label class="nofitems"><%out.print(pendingorders);%></label>

            </div>

            <div class="col-md-3 allproducts">
                
                <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-truck mb-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                </svg><br/>
                

                <label class="dashitemsname">Ready to Ship Orders</label><br/>
                <label class="nofitems"><%out.print(readytoship);%></label>

            </div>

           
        </div>
    </div>



<jsp:include page="adminpage-footer.jsp"></jsp:include>


<%}else{
	response.sendRedirect("signin.jsp");	
}%>
