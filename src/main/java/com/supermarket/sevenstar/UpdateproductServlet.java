package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class UpdateproductServlet extends HttpServlet{


	private static final long serialVersionUID = 4723442561413053877L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		
		String id = req.getParameter("id").toString();
		String name = req.getParameter("proname").toString();
		String brand = req.getParameter("brand").toString();
		String description = req.getParameter("description").toString();
		String warrenty = req.getParameter("warrenty").toString();
		String quantity = req.getParameter("quantity").toString();
		String price = req.getParameter("price").toString();
		String discount = req.getParameter("discount").toString();

			
			try {
				Connection conn = DbConfiguration.getDatabaseConnection();			
				String sql = "UPDATE `tbl_item` SET `name` = ?, `brand` = ?, `description` = ?, `warrenty` = ?, `quantity` = ?, `price` = ?, `discount` = ? WHERE `id`=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, name);
				stmt.setString(2, brand);
				stmt.setString(3, description);
				stmt.setString(4, warrenty);
				stmt.setString(5, quantity);
				stmt.setString(6, price);
				stmt.setString(7, discount);
				stmt.setString(8, id);
				
				int affectedRows = stmt.executeUpdate();
				
				if(affectedRows > 0) {
					req.setAttribute("productupdatek", "Product details have been updated.");
					RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
					rd.forward(req, res);
					
					System.out.println(req.getAttribute("succuss"));
					
				} else {
					req.setAttribute("productupdatek", "Something went wrong. Please try again later.");
					RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
					rd.forward(req, res);
				}	
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			}
		
		
		
		
	}
	
}
