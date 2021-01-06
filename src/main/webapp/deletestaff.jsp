<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>

	
	
	
	<form class="needs-validation mt-5 addpro" novalidate action="userid" method="post"> 
	    <div class="row mb-5">    
	        <div class=" col-md-2 offset-md-4">
	            <label class="proname">Enter Employee ID*</label>
	        </div>
	        <div class="col-md-3">
	            <input id="productname" name="userid" type="text" class="form-control" placeholder="" required>
	        </div>
	        <div class="col-md-3">
	            <button name="Credit-Card" class="btn btn-primary btn-block" type="submit"><b>Search Employee</b></button>
	        </div>
	    </div>
	    <%if(request.getAttribute("staffdelete") != null){ %>
		    <div class="col-md-4 offset-md-8">
		    <span class="spansize"><% out.print(request.getAttribute("staffdelete")); %></span>
		    </div>
		<%} %>
	</form>
	
	
	<%if(request.getAttribute("userid") != null){ 
	
	String userid = request.getAttribute("userid").toString();
	
  	Connection conn = DbConfiguration.getDatabaseConnection();
	String sql4 = "SELECT u.user_id, u.name, u.email, u.phone, p.name as poci FROM tbl_user u INNER JOIN tbl_position p WHERE u.position_id=p.position_id AND u.user_id = ?";
	PreparedStatement stmt4 = conn.prepareStatement(sql4);
	stmt4.setString(1, userid);
	ResultSet rs4 = stmt4.executeQuery();
	
	int rows4 = 0;
	
	while(rs4.next()) {
		rows4++;
		
	%>
	
	<form class="needs-validation mt-5 addpro" novalidate action="deletestaff" method="post"> 
		<hr class="mb-5">
	    <table class="table table-striped table-hover">
	    <thead class="thead-dark">
	        <tr>
	        <th scope="col">Employee ID</th>
	        <th scope="col">Full Name</th>
	        <th scope="col">E-mail Address</th>
	        <th scope="col">Phone Number</th>
	        <th scope="col">Position</th>
	        </tr>
	    </thead>
	    <tbody>
	        <tr>
	        <th scope="row"> <center><%out.print(rs4.getString("user_id"));%></center> </th>
	        <td class="uppercase"><%out.print(rs4.getString("name"));%></td>
	        <td><%out.print(rs4.getString("email"));%></td>
	        <td><%out.print(rs4.getString("phone"));%></td>
	        <td class="uppercase"><%out.print(rs4.getString("poci"));%></td>
	        </tr>
	    </tbody>
	    </table>
	
	    <div class="row mb-5">    
	        <div class="col-md-4 offset-md-8">
	            <button name="userid"  value="<%out.print(rs4.getString("user_id"));%>" class="btn btn-primary btn-block update" type="submit"><b>Delete Selected Employee Details</b></button>
	        </div>
	    </div>
	</form>

	<%
	}
	}%>
	
	

<%}else{
	response.sendRedirect("signin.jsp");	
}%> 
	
	