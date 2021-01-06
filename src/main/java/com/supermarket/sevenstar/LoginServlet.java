package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class LoginServlet extends HttpServlet{
	
	private static final long serialVersionUID = 2027796937874691369L;

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		String email = req.getParameter("u-email").toString();
		String password = req.getParameter("u-pass").toString();
		
		//Encrypting password with SHA-1 
		String encpass = DigestUtils.sha1Hex(password);
		
		//creating the session
		HttpSession session = req.getSession();
		
		//Setup MySQL Driver
		try {
			
			
			Connection conn = DbConfiguration.getDatabaseConnection();
			//Preparing the query
			String sql = "SELECT * FROM tbl_user WHERE email=? AND password=?";
			PreparedStatement stmt =  conn.prepareStatement(sql);
			
			//bind values
			stmt.setString(1, email);
			stmt.setString(2, encpass);
			
			//checking number of query affected
			ResultSet rs = stmt.executeQuery();
			
			//check the number of rows in result set(virtual table)
			int rows = 0;
			
			while(rs.next()) {
				rows++;
				
				session.setAttribute("u_id", rs.getInt("user_id"));
				session.setAttribute("u_name", rs.getString("name"));
				session.setAttribute("u_email", rs.getString("email"));
				session.setAttribute("u_phone", rs.getString("phone"));
				session.setAttribute("u_position", rs.getInt("position_id"));
				session.setAttribute("u_address", rs.getString("address"));
				session.setAttribute("u_loggedin", true);
				
				if(rs.getInt("position_id") != 3) {
					session.setAttribute("staff", rs.getInt("position_id"));
				}
			}
			
			//checking whether user entered data match with the database row
			if(rows > 0) {
				
				//Successfully logged in				
				if(session.getAttribute("staff") != null) {
					res.sendRedirect("dashboard.jsp");
					System.out.println("Successfully logged in ADMIN panel");
				}else {
					res.sendRedirect("index.jsp");
					System.out.println("Successfully logged in");
				}
				
			}else {
				//login failed
				req.setAttribute("loginfail", "Invalid email or password");
				RequestDispatcher rd = req.getRequestDispatcher("signin.jsp");
				rd.forward(req, res);
			}
		
			//close connection
			conn.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
