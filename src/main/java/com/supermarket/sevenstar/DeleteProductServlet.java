package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class DeleteProductServlet extends HttpServlet {

	private static final long serialVersionUID = 7099985342078424439L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		
		String id = req.getParameter("productiid").toString();

		
			try {
				Connection conn = DbConfiguration.getDatabaseConnection();			
				String sql = "DELETE FROM tbl_item WHERE `id`=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, id);
				
				int affectedRows = stmt.executeUpdate();
				
				if(affectedRows > 0) {
					req.setAttribute("productdelete", "The selected product has been successfully deleted.");
					RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
					rd.forward(req, res);
					
					System.out.println(req.getAttribute("succuss"));
					
				} else {
					req.setAttribute("productdelete", "Something went wrong. Please try again later.");
					RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
					rd.forward(req, res);
				}	
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			
	}
}
