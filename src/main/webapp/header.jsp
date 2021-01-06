<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>7-Star Supermarket</title>

    <!---icon--->
    <link rel="icon" type="image/icon type" href="imagers/1-icon.png"> 

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/navigation_bar.css">
    <link rel="stylesheet" href="css/signin.css">
    <link rel="stylesheet" href="css/signup.css">
    <link rel="stylesheet" href="css/cart.css">    
    <link rel="stylesheet" href="css/itempage.css">
    <link rel="stylesheet" href="css/myaccount.css">
    <link rel="stylesheet" href="css/searchresults.css">
    <link rel="stylesheet" href="css/checkout.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/snow.css">
    
    <link rel="stylesheet" href="css/loader.css">
    
    <!-- -------currency format-------- -->
	<script> 
	    function formatMoney(amount, decimalCount = 2, decimal = ".", thousands = ",") {
	        try {
	            decimalCount = Math.abs(decimalCount);
	            decimalCount = isNaN(decimalCount) ? 2 : decimalCount;
	
	            const negativeSign = amount < 0 ? "-" : "";
	
	            let i = parseInt(amount = Math.abs(Number(amount) || 0).toFixed(decimalCount)).toString();
	            let j = (i.length > 3) ? i.length % 3 : 0;
	
	            return negativeSign + (j ? i.substr(0, j) + thousands : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : "");
	        } catch (e) {
	            console.log(e)
	        }
	    };
	
	</script>
    

</head>
<body>

<!--Snow effect-->
<div class="snowflakes" aria-hidden="true">
  <div class="snowflake">
  *
  </div>
  <div class="snowflake">
  *
  </div>
  <div class="snowflake">
  *
  </div>
  <div class="snowflake">
  *
  </div>
  <div class="snowflake">
  *
  </div>
  <div class="snowflake">
  *
  </div>
  <div class="snowflake">
    *
  </div>
  <div class="snowflake">
    *
  </div>
  <div class="snowflake">
    *
  </div>
  <div class="snowflake">
    *
  </div>
  <div class="snowflake">
    *
  </div>
  <div class="snowflake">
    *
  </div>
</div>



<div class="loader-wrapper">    
  <span class="low" ><img class="loader" width="100%" height="auto" alt="N/A" src="imagers/1-icon.png"></span>
</div>


<div class="navbarbackgroundcolor">

    <div class="container mt-1 mb-1">
        <div class="row">

          <div id="nav-companylogo" class="col-3 col-md-3">
              <div class="comnylog center">
                <div class="logoimg ">
                  <a href="index.jsp"> <img width="100%" height="auto" alt="N/A" src="imagers/logo.png"></a>
                </div>
              </div>
          </div>
          
          <div id="nav-searchbar" class="col-7 col-md-6 center">

            <div class="input-group searchbar center">
                <div class="dropdown">
                    <button id="dropdownMenuButton" class="btn btn-outline-success dropdown-toggle"  type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Categories</button>
                    
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    
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
                    
                        <a class="dropdown-item" href="searchresults.jsp?category=<%out.print(cateid);%>"><%out.print(rss.getString("name"));%></a>
                        
                   <%}%>
                    
                    </div>
                </div>
                
                <form class="custom-file" action="searchresults.jsp">
                    <input id="searchtext" name="search" class="form-control center" type="search" placeholder="Search" aria-label="Search">
                    <button id="searchbtn" class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>    
                </form>  
            </div> 
                 
          </div>
          
          <div id="nav-cart" class="col-2 col-md-3 center ">
            
            <div id="navcartlogo" class="cartlogo center">    
              <div class="cart justifycenter">
                <a href="cart.jsp"> <img width="100%" height="auto" alt="N/A" src="imagers/cart.png"></a>
              </div>
            </div>

          </div>
          
        </div>
    </div>   





<nav id="navbaar" class="navibar">
  <div class="container">
    <div class="row">

      <div class="col-4 col-md-6">
        <div class="catemobile center">        
          <div class="burger center">
            <div class="line1"></div>
            <div class="line2"></div>
            <div class="line3"></div>
          </div>
          <div class="logocategory ">
              Categories
          </div>
        </div>
      </div>

      <div class="col-8 col-md-6 loginlink pr-0">
        <ul class="links-items">
        
        
        	<%
        	boolean user_logged_in = false;
        	
        	if(session.getAttribute("u_loggedin") != null){
        		
        		boolean u_loggedin = (Boolean)session.getAttribute("u_loggedin");
        	
        			if(u_loggedin = true){
        			
        				user_logged_in = true;
        				
        			}       	
        	
        	}
        	
        	
        	if(user_logged_in){
        		
        		String username = "NA";
        		if(session.getAttribute("u_name") != null){
        			username = session.getAttribute("u_name").toString();
        		}
        		
        		%>        		
        				     
				        <a class="nav-link dropdown-toggle droplink pb-0" data-toggle="dropdown" href="user-details.jsp" role="button" aria-haspopup="true" aria-expanded="false"><% out.print(username); %></a>		            
				            <div class="dropdown-menu dropdown-menu-right">	
				            
				            	<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>
				            				              
					                  <a class="dropdown-item"  href="dashboard.jsp">Dashboard</a>
					                  <a class="dropdown-item"  href="products.jsp">Product Details</a>
					                  <a class="dropdown-item"  href="orders.jsp">Order Details</a> 
					                  <a class="dropdown-item"  href="staff.jsp">Staff Details</a> 
					                  <a class="dropdown-item"  href="logout"> Log-out</a> 	
					                  
					           <%}else{ %>
					           
					           		  <a class="dropdown-item"  href="user-details.jsp"> Account Details</a> 
					                  <a class="dropdown-item"  href="user-orders.jsp"> My Orders</a> 
					                  <a class="dropdown-item"  href="user-return-orders.jsp"> My Returns</a> 
					                  <a class="dropdown-item"  href="logout"> Log-out</a> 	
					           
					           <%} %>
					           
				            </div>
				         		
        		<%        		
        	}else{
        		%>        		
	        		<a class="link" href="signup.jsp"><li>Sign-up</li></a>
	          		<a class="link" href="signin.jsp"><li>Sign-in</li></a>        		
        		<% 
        	}
        	
        	%>   			
        		
        </ul>
      </div>
    </div>
  </div>
</nav>


</div>