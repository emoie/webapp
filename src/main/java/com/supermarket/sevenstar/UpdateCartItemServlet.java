package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class UpdateCartItemServlet extends HttpServlet{
	
	private static final long serialVersionUID = 5530922356337565830L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		
		int userid = (Integer) session.getAttribute("u_id");
		
		String itemcode = req.getParameter("itemcode").toString();
		String qnt =  req.getParameter("qnt");
		int i=Integer.parseInt(qnt);  
		
		try {
			Connection conn = DbConfiguration.getDatabaseConnection();			
			String sql = "UPDATE `tbl_cart` SET `quantities` = ? WHERE `user_id`=? AND `item_id`=? ";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, i);
			stmt.setInt(2, userid);
			stmt.setString(3, itemcode);
			
			int affectedRows = stmt.executeUpdate();
			
			if(affectedRows > 0) {
				res.sendRedirect("cart.jsp");
			} else {
				//session.setAttribute("error", "Invalid records");
				//res.sendRedirect("error.jsp");
			}	
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	} 

}
