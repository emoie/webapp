<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>

    <!---icon--->
    <link rel="icon" type="image/icon type" href="imagers/icon.png"> 

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/admin-header.css">
    <link rel="stylesheet" href="css/products.css">
    <link rel="stylesheet" href="css/staff.css">
    <link rel="stylesheet" href="css/dashboard.css">

	<script> 
		function formatMoney(amount, decimalCount = 2, decimal = ".", thousands = ",") {try { decimalCount = Math.abs(decimalCount); decimalCount = isNaN(decimalCount) ? 2 : decimalCount;  const negativeSign = amount < 0 ? "-" : "";  let i = parseInt(amount = Math.abs(Number(amount) || 0).toFixed(decimalCount)).toString();let j = (i.length > 3) ? i.length % 3 : 0; return negativeSign + (j ? i.substr(0, j) + thousands : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : "");  } catch (e) {  console.log(e) }};
	</script>

</head>
<body scroll="no">


<nav class="adminnavibar">
  <div class="container">
    <div class="row unselectabel">

      <div class="col-6 col-md-6 comlogo center">
        <div class="logocom">
          <a href="index.jsp"> <img width="100%" height="auto" alt="N/A" src="imagers/logo.png"></a>
        </div>
      </div>

      <div class="col-6 col-md-6 navlinks">
        <ul class="linksitems">
          <li class="link"><a href="logout">Log-out</a></li>
        </ul>
      </div>

    </div>
  </div>
</nav>




<div class="container-fluid">
  <div id="menu" class="row">
    <div class="col-md-2 menu">

      <div class="adminname unselectabel"> <label>Oshadha Induwara Ekanayake</label> </div>
              
      <ul class="select">
        <a href="dashboard.jsp"><li class="menuitem unselectabel" >Dashboard</li></a>
        <a href="products.jsp"><li class="menuitem unselectabel" >Products</li></a>
        <a href="orders.jsp"><li class="menuitem unselectabel" >Orders</li></a>
        <a href="staff.jsp"><li class="menuitem unselectabel" >Staff Details</li></a>

      </ul>     

    </div>

    <!-----------------Pagers------------------------>
    <div class="col-md-10 PAGES scrollbar">

    
 <%}else{
	response.sendRedirect("signin.jsp");	
}%>   