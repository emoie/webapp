package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class UserUpdateAddressServlet extends HttpServlet{
	

	private static final long serialVersionUID = 8916929765379614799L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session =  req.getSession();
		
		
		if(session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){
			
			
			
			int userid = (Integer)session.getAttribute("u_id");
			String address = req.getParameter("address").toString();

			
			
			
			try {
				Connection conn = DbConfiguration.getDatabaseConnection();			
				String sql = "UPDATE `tbl_user` SET `address` = ? WHERE `user_id`=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, address);
				stmt.setInt(2, userid);
				
				int affectedRows = stmt.executeUpdate();
				
				if(affectedRows > 0) {
					req.setAttribute("succuss", "Your account details have been updated.");
					RequestDispatcher rd = req.getRequestDispatcher("user-address.jsp");
					rd.forward(req, res);
					
					System.out.println(req.getAttribute("succuss"));
					
				} else {
					req.setAttribute("error", "Something went wrong. Please try again later.");
					RequestDispatcher rd = req.getRequestDispatcher("user-address.jsp");
					rd.forward(req, res);
				}	
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	}

}
