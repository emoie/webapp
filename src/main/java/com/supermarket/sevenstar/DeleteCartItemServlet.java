package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class DeleteCartItemServlet extends HttpServlet{
	
	private static final long serialVersionUID = -2141656791055934588L;

	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		
		int userid = (Integer)session.getAttribute("u_id");
		
		String productid1 = req.getParameter("productid").toString();
		
		
		//Setup MySQL Driver
		try {
			
			Connection conn = DbConfiguration.getDatabaseConnection();
			String sql = "DELETE FROM tbl_cart WHERE user_id=? AND item_id=?";
			PreparedStatement stmt =  conn.prepareStatement(sql);
			
			//bind values
			stmt.setInt(1, userid);
			stmt.setString(2, productid1);
			
			//checking number of query affected
			int  affectedrows = stmt.executeUpdate();									
			
			//checking whether user entered data match with the database row
			if(affectedrows > 0) {
				
				//Successfully logged in
				res.sendRedirect("cart.jsp");
				
			}else {
				//login failed
			}
			
			//close connection
			conn.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("EROOR :"+e);
		}
		
	}

}
