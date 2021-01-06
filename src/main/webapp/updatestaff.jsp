<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>
<%if(session.getAttribute("staff") != null && session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){ %>


	
	
	<form class="needs-validation mt-5 addpro" novalidate action="userid" method="post"> 
	    <div class="row mb-5">    
	        <div class=" col-md-2">
	            <label class="proname">Enter Employee ID*</label>
	        </div>
	        <div class="col-md-3">
	            <input id="productname" name="userid" type="text" class="form-control" placeholder="" required>
	        </div>
	        <div class="col-md-2">
	            <button name="Credit-Card" class="btn btn-primary  btn-block employeebtn" type="submit"><b>Search Employee</b></button>
	        </div>
	    </div>
	    <%if(request.getAttribute("staffupdate") != null){ %>
		    <div class="col-md-12">
		    <span class="spansize"><% out.print(request.getAttribute("staffupdate")); %></span>
		    </div>
		<%} %>
	</form>
	
	
	
	
	
<%if(request.getAttribute("userid") != null){ 
	
	String userid = request.getAttribute("userid").toString();
	
  	Connection conn = DbConfiguration.getDatabaseConnection();
	String sql4 = "SELECT * FROM tbl_user WHERE user_id = ?";
	PreparedStatement stmt4 = conn.prepareStatement(sql4);
	stmt4.setString(1, userid);
	ResultSet rs4 = stmt4.executeQuery();
	
	int rows4 = 0;
	
	while(rs4.next()) {
		rows4++;
		
	%>
	
	
	<form class="needs-validation mt-5 addpro" novalidate action="updatestaff" method="post"> 
	 <hr class="mb-5">
	  <table class="table table-striped table-hover ">
	    <thead class="thead-dark">
	    <tr>
	      <th scope="col">Employee ID</th>
	      <th scope="col">Full Name</th>
	      <th scope="col">E-mail Address</th>
	      <th scope="col">Password</th>
	      <th scope="col">Phone Number</th>
	      <th scope="col">Position</th>
	    </tr>
	    </thead>
	    <tbody class="tbdy">
	      <tr>
	      <th scope="row"><center> <input disabled value="<%out.print(rs4.getString("user_id"));%>"></center> </th>
	      <td class="uppercase"><input name="fullname"  value="<%out.print(rs4.getString("name"));%>"></td>
	      <td><input name="email"  value="<%out.print(rs4.getString("email"));%>"></td>
	      <td><input name="password"  placeholder="New Password"></td>
	      <td><input name="phone"  value="<%out.print(rs4.getString("phone"));%>"></td>
	      
	      <td>
	        <select type ="select" name="position" id="cate"  class="custom-select form-control uppercase loginemail customerf" required autofocus >
	            <option value="3" <%if(rs4.getString("position_id").equals("3")){out.print("selected");} %> >Standerd-Customer</option>
	            <option value="4" <%if(rs4.getString("position_id").equals("4")){out.print("selected");} %> >Standerd-Staff Member</option>
	            <option value="5" <%if(rs4.getString("position_id").equals("5")){out.print("selected");} %> >Branch Manager</option>
	            <option value="2" <%if(rs4.getString("position_id").equals("2")){out.print("selected");} %> >Chief Manager</option>
	            <option value="1" <%if(rs4.getString("position_id").equals("1")){out.print("selected");} %> >Admin</option>
		    </select>
	      </td>
	
	    </tr>
	    </tbody>
	  </table>
		
		
		<div class="row mb-5">    
		    <div class="col-md-4 offset-md-8">
		        <button name="userid"  value="<%out.print(rs4.getString("user_id"));%>" class="btn btn-primary btn-block update" type="submit"><b>Update Employee Details</b></button>
		    </div>
		</div>
		
	</form>
	<%
	}
	}%>



<%}else{
	response.sendRedirect("signin.jsp");	
}%> 

