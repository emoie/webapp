package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class ReadytoShipServlet extends HttpServlet{
	
	private static final long serialVersionUID = -3121750775680423373L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		
		String orderid = req.getParameter("orderid").toString();
		
		
		try {
			Connection conn = DbConfiguration.getDatabaseConnection();			
			String sql = "UPDATE `tbl_order` SET `status` = ? WHERE `order_id`=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, "Ready to Ship");
			stmt.setString(2, orderid);
			
			int affectedRows = stmt.executeUpdate();
			
			if(affectedRows > 0) {
				req.setAttribute("succuss", "Order status has been updated.");
				RequestDispatcher rd = req.getRequestDispatcher("orders.jsp");
				rd.forward(req, res);
								
				System.out.println(req.getAttribute("succuss"));
				
			} else {
				req.setAttribute("error", "Something went wrong. Please try again later.");
				RequestDispatcher rd = req.getRequestDispatcher("orders.jsp");
				rd.forward(req, res);
			}	
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
