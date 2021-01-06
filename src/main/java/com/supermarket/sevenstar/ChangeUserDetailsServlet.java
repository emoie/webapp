package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class ChangeUserDetailsServlet  extends HttpServlet{
	
	private static final long serialVersionUID = 858573627253529101L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session =  req.getSession();
		
		
		if(session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){
			
			
			
			int userid = (Integer)session.getAttribute("u_id");
			String fname = req.getParameter("fname").toString();
			String email = req.getParameter("email").toString();
			String phone = req.getParameter("phone").toString();
			
			
			
			try {
				Connection conn = DbConfiguration.getDatabaseConnection();			
				String sql = "UPDATE `tbl_user` SET `name` = ?, `email`=?, `phone`=? WHERE `user_id`=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, fname);
				stmt.setString(2, email);
				stmt.setString(3, phone);
				stmt.setInt(4, userid);
				
				int affectedRows = stmt.executeUpdate();
				
				if(affectedRows > 0) {
					req.setAttribute("succuss", "Your account details have been updated.");
					RequestDispatcher rd = req.getRequestDispatcher("user-details.jsp");
					rd.forward(req, res);
					
					System.out.println(req.getAttribute("succuss"));
					
				} else {
					req.setAttribute("error", "Something went wrong. Please try again later.");
					RequestDispatcher rd = req.getRequestDispatcher("user-details.jsp");
					rd.forward(req, res);
				}	
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
		
		
	}
	

}
