package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class SignupServlet extends HttpServlet{
	
	private static final long serialVersionUID = 186257748450935979L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		
		String fname = req.getParameter("fname").toString(); 
		String phone = req.getParameter("phone").toString(); 
		String email = req.getParameter("email").toString(); 
		String password = req.getParameter("password").toString(); 
		String address = req.getParameter("address").toString(); 
		String city = req.getParameter("city").toString(); 
		String state = req.getParameter("state").toString(); 
		String zip = req.getParameter("zip").toString(); 
		
		//Encrypting password with SHA-1 
		String encpass = DigestUtils.sha1Hex(password);
		
		try	{
			Connection conn = DbConfiguration.getDatabaseConnection();
			String sql = "INSERT INTO `tbl_user` (`name`, `email`, `password`, `phone`, `position_id`, `address`) VALUES (?,?,?,?,?,?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, fname);
			stmt.setString(2, email);
			stmt.setString(3, encpass);
			stmt.setString(4, phone);
			stmt.setString(5, "3");
			stmt.setString(6, address + " " + city + " " + state + " " + zip);
			
			int affectedRows = stmt.executeUpdate();
			
			if(affectedRows > 0) {
				res.sendRedirect("signin.jsp");
			} else {
				//session.setAttribute("error", "Invalid records");
				//response.sendRedirect("error.jsp");
			}
		} catch (Exception e) {
			System.out.println("ERROR : "+e.getMessage());
			//session.setAttribute("error", "ERROR : "+e.getMessage());
		}
		
		
	}

}
