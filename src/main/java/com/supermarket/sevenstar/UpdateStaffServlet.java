package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class UpdateStaffServlet extends HttpServlet{
	
	private static final long serialVersionUID = 3609598331530270417L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
			
			String userid = req.getParameter("userid").toString();
			String fullname = req.getParameter("fullname").toString();
			String email = req.getParameter("email").toString();
			String password = "";
			String phone = req.getParameter("phone").toString();
			String position = req.getParameter("position").toString();

			if(req.getParameter("password") != null) {
				password = DigestUtils.sha1Hex(req.getParameter("password").toString());
				
				try {
					Connection conn = DbConfiguration.getDatabaseConnection();			
					String sql = "UPDATE `tbl_user` SET `name` = ?, `email` = ?, `phone` = ?, `position_id` = ?, password=? WHERE `user_id`=?";
					PreparedStatement stmt = conn.prepareStatement(sql);
					
					stmt.setString(1, fullname);
					stmt.setString(2, email);
					stmt.setString(3, phone);
					stmt.setString(4, position);
					stmt.setString(5, password);
					stmt.setString(6, userid);
					
					int affectedRows = stmt.executeUpdate();
					
					if(affectedRows > 0) {
						req.setAttribute("staffupdate", "Employee account details have been updated.");
						RequestDispatcher rd = req.getRequestDispatcher("staff.jsp");
						rd.forward(req, res);
						
						System.out.println(req.getAttribute("succuss"));
						
					} else {
						req.setAttribute("staffupdate", "Something went wrong. Please try again later.");
						RequestDispatcher rd = req.getRequestDispatcher("staff.jsp");
						rd.forward(req, res);
					}	
					
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else {
			
			
				try {
					Connection conn = DbConfiguration.getDatabaseConnection();			
					String sql = "UPDATE `tbl_user` SET `name` = ?, `email` = ?, `phone` = ?, `position_id` = ? WHERE `user_id`=?";
					PreparedStatement stmt = conn.prepareStatement(sql);
					
					stmt.setString(1, fullname);
					stmt.setString(2, email);
					stmt.setString(3, phone);
					stmt.setString(4, position);
					stmt.setString(5, userid);
					
					int affectedRows = stmt.executeUpdate();
					
					if(affectedRows > 0) {
						req.setAttribute("staffupdate", "Your account details have been updated.");
						RequestDispatcher rd = req.getRequestDispatcher("staff.jsp");
						rd.forward(req, res);
						
						System.out.println(req.getAttribute("succuss"));
						
					} else {
						req.setAttribute("staffupdate", "Something went wrong. Please try again later.");
						RequestDispatcher rd = req.getRequestDispatcher("staff.jsp");
						rd.forward(req, res);
					}	
					
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
		
		
	}

}
