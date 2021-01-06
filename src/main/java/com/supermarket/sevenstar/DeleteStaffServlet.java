package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class DeleteStaffServlet extends HttpServlet{
	
	private static final long serialVersionUID = -4527968055082129110L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		
		String userid = req.getParameter("userid").toString();

		
			try {
				Connection conn = DbConfiguration.getDatabaseConnection();			
				String sql = "DELETE FROM tbl_user WHERE `user_id`=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, userid);
				
				int affectedRows = stmt.executeUpdate();
				
				if(affectedRows > 0) {
					req.setAttribute("staffdelete", "The selected employee has been successfully deleted.");
					RequestDispatcher rd = req.getRequestDispatcher("staff.jsp");
					rd.forward(req, res);
					
					System.out.println(req.getAttribute("succuss"));
					
				} else {
					req.setAttribute("staffdelete", "Something went wrong. Please try again later.");
					RequestDispatcher rd = req.getRequestDispatcher("staff.jsp");
					rd.forward(req, res);
				}	
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			
	}
}
