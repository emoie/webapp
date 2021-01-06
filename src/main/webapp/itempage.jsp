
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<jsp:include page="header.jsp"></jsp:include>


<div class="container">

    <div class="row">
        <div class="rootnavi col-md-12 col-12">
        
        	<%
        	String itemcode = request.getParameter("id");
        	        	
        	Connection conn = DbConfiguration.getDatabaseConnection();
 	       	String sqli = "SELECT sub.cate_id, i.subcate_id, i.id, i.`name`, i.brand, i.`description`, i.warrenty, i.quantity, i.price, i.discount FROM tbl_item i INNER JOIN tbl_subcategory sub WHERE i.subcate_id=sub.id AND i.id=?";
 	       	PreparedStatement stmt = conn.prepareStatement(sqli);
 	       	
 	       	stmt.setString(1, itemcode);
 	       
 	       	ResultSet rss = stmt.executeQuery();
 	       	
 	       	int rows = 0;
			
			while(rss.next()) {
				rows++;
			
        		String cate = "";
        		String subcate = "";
				
	        	String sqliq = "SELECT cate.`name` as cate , sub.`name` as subcate  FROM tbl_subcategory sub INNER JOIN tbl_category cate WHERE sub.cate_id = cate.id AND sub.cate_id = ?";
	 	       	PreparedStatement stmtq = conn.prepareStatement(sqliq);
	 	       	
	 	       	stmtq.setString(1, rss.getString("cate_id"));
	 	       
	 	       	ResultSet rssq = stmtq.executeQuery();
	 	       	
	 	       	int rowsq = 0;
				
				while(rssq.next()) {
					rowsq++;
					
					cate = rssq.getString("cate");
					subcate = rssq.getString("subcate");
					
				}
				
				if(rows > 0) {
			%>
		            <!----------------------------------------------->
		            <a href="searchresults.jsp?category=<%out.print(rss.getString("cate_id"));%>" class="over maxwidthforother"><%out.print(cate);%></a>
		
		            <div class="rightarrow"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right rightarrowsvg" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		            <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		            </svg></div>
		
		            <!----------------------------------------------->
		            <a href="searchresults.jsp?subcategory=<%out.print(rss.getString("subcate_id"));%>" class="over maxwidthforother" ><%out.print(subcate);%></a>
		
		            <div class="rightarrow"><svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-chevron-right rightarrowsvg" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		            <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
		            </svg></div>
		
		            <!----------------------------------------------->
		            <a href="searchresults.jsp?search=<%out.print(rss.getString("name"));%>"class="over maxwidth"><%out.print(rss.getString("name"));%></a>
		            
		       <%} %>

        </div>
    </div>
    
    <%
    
    if(request.getAttribute("added") != null || request.getAttribute("added") != null){
    	%>
	    <div class="row">
	        <div class="p-0 col-md-12 col-12">
			    <div class="alert alert-primary" role="alert">
				  	<%
				  	if(request.getAttribute("added") != null){
				  		
				  		 out.print(request.getAttribute("added"));
			    		
					 }else if (request.getAttribute("error") != null){
					    
						 out.print(request.getAttribute("error"));
					 }
				  	
				  	%>				  	
				</div>
			</div>
	    </div>
    	<%
    }
    %>
    
    
    <div class="row">

        <div class="panel03 p-2 col-md-4 col-12">

            <div class="itemimgitm center">
                <img width="100%" height="100%" alt="N/A" src="imagers/<%out.print(rss.getString("name"));%>.png">
            </div>

        </div>

        <div class="panel01 col-md-4 col-12">

            <div class="itemname5">
                <span class="title"> <% out.print(rss.getString("name") + " "  + rss.getString("description")); %> </span>
            </div>

            <div class="brand5">
                <span class="brandname5">Brand :  <span class="brandname5"><% out.print(rss.getString("brand")); %></span></span>
            </div>

            <div class="dropdown-divider m-1 mt-2 mb-3"></div>

            <div class="price5">
                <span id="itemprice" class="itemprice5"></span>
            </div>

            <div class="realprice5">
                <del><span id="realitemprice" class="itemprice5"></span></del>
            </div>

                <script> 
                        document.getElementById("itemprice").innerText =  "Rs. " + formatMoney(<% out.print(rss.getString("discount")); %>);
	                    document.getElementById("realitemprice").innerText = "Rs. " + formatMoney(<% out.print(rss.getString("price")); %>);    
                </script>

		<form action="addtocart" method="post">
            <div class="itemitemqnt center col-md-7 offset-md-0 col-8 offset-2">
                    <a id="btn-" class="btn qntbtn btn-warning iquen" type="button"> - </a>
                    <input name="qnt" id="qnt" class="form-control mr-1 ml-1 qnttext5" type="number" value="1" min="1" max="<% out.print(rss.getString("quantity")); %>">
                    <a id ="btn+" class="btn qntbtn btn-warning iquen btnq2" type="button"> + </a>      
            </div>

            <div class="dropdown-divider m-1 mt-2 mb-4"></div>

                <div class="addtocartbtn">
                    <div class=" p-0 pr-3 col-md-6">
                        <a role="button" type="submit" name="Credit-Card" class="btn btn-primary buynow itempagebtn btn-block" ><b>Buy Now</b></a>
                    </div>
                    <div class="p-0 pl-3 col-md-6">
                        <button role="button" name="product-id" type="submit" name="Credit-Card" value="<% out.print(rss.getString("id")); %>" class="btn btn-warning itempagebtn btn-block"><b>Add to Cart</b></button>
                    </div>
                </div>
                
        </form>
        </div>

        <div class="panel02 col-md-4 col-12 unselectabel pr-4 pt-2">

            <div class="boxvertical center"><div class="verticalline"></div></div>
            
            <div class="diliveryoption ">

                <div class="deliverytitle mt-2 pl-2">
                    <span >Delivery Options</span>
                </div>

                <div class="dropdown-divider m-1 mt-2 mb-3"></div>

                <div class="deliverydetails pl-2">
                    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-truck mr-2 truckcolor" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
                    </svg>
                    
                    <label >Home Delivery</label>
                    <label class="unselectabel right">Rs. 150.00</label>               
                </div>

                <div class="deliverydetails pl-2">
                    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-clock-history  mr-2 truckcolor" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c.033-.17.06-.339.081-.51l.993.123a7.957 7.957 0 0 1-.23 1.155l-.964-.267c.046-.165.086-.332.12-.501zm-.952 2.379c.184-.29.346-.594.486-.908l.914.405c-.16.36-.345.706-.555 1.038l-.845-.535zm-.964 1.205c.122-.122.239-.248.35-.378l.758.653a8.073 8.073 0 0 1-.401.432l-.707-.707z"/>
                    <path fill-rule="evenodd" d="M8 1a7 7 0 1 0 4.95 11.95l.707.707A8.001 8.001 0 1 1 8 0v1z"/>
                    <path fill-rule="evenodd" d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z"/>
                    </svg>
                    
                    <label >Delivery Time</label>
                    <label class="unselectabel right">7 - 14 days</label>               
                </div>

                <div class="dropdown-divider m-1 mt-2 mb-3"></div>

                <div class="deliverytitle pl-2">

                    <svg width="2em" height="2em" viewBox="0 0 16 16" class="mr-2 bi bi-cash cod" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M15 4H1v8h14V4zM1 3a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h14a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H1z"/>
                    <path d="M13 4a2 2 0 0 0 2 2V4h-2zM3 4a2 2 0 0 1-2 2V4h2zm10 8a2 2 0 0 1 2-2v2h-2zM3 12a2 2 0 0 0-2-2v2h2zm7-4a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/>
                    </svg>

                    <span >Cash on Delivery Available</span>
                </div>


            </div>           

        </div>
        
    </div>

    <div class="row">
        <div class="itemdeciotm col-md-12 col-12">

            <div class=" center mt-3 productdescrition"><% out.print(rss.getString("name") + " "  + rss.getString("description")); %></div>
        
            <div class="dropdown-divider m-1 mt-0 mb-3"></div>

            <div class="itemdecproduct">
            
            	<ul>
            		<li><% out.print(rss.getString("description")); %></li>
            		<li><% out.print(rss.getString("warrenty")); %></li>
            	</ul>

			</div>
        </div>
    </div>


</div>

<%} %>

<jsp:include page="footer.jsp"></jsp:include>