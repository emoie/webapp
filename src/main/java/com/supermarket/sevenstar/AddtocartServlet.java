package com.supermarket.sevenstar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class AddtocartServlet extends HttpServlet{
	
	private static final long serialVersionUID = 4799742008665921034L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		HttpSession session =  req.getSession();
		
		
		if(session.getAttribute("u_loggedin") != null &&	(Boolean)session.getAttribute("u_loggedin") == true){
			
			
			
			int userid = (Integer)session.getAttribute("u_id");
			String itemcode = req.getParameter("product-id").toString();
			String qnts = req.getParameter("qnt").toString();
			
			int qnt=Integer.parseInt(qnts);  
			
			
			
			
			try {
				Connection conn = DbConfiguration.getDatabaseConnection();
				String sqlm = "SELECT * FROM tbl_cart WHERE item_id=? AND user_id=?";
				PreparedStatement stt = conn.prepareStatement(sqlm);
				
				stt.setString(1, itemcode);
				stt.setInt(2, userid);
				
				ResultSet rrs = stt.executeQuery();
				
				//check the number of rows in result set(virtual table)
				int rows = 0;
				
				while(rrs.next()) {
					rows++;
					
					int avaibaleqnt = rrs.getInt("quantities");
					
					int totalqnt = qnt + avaibaleqnt; 
				
				 				
				

					System.out.println("Available");
						//Update cart if product already available in cart
						try {			
							String sql = "UPDATE `tbl_cart` SET `quantities` = ? WHERE `user_id`=? AND `item_id`=? ";
							PreparedStatement stmt = conn.prepareStatement(sql);
							
							stmt.setInt(1, totalqnt);
							stmt.setInt(2, userid);
							stmt.setString(3, itemcode);
							
							int affectedRows = stmt.executeUpdate();
							
							if(affectedRows > 0) {
								
								req.setAttribute("added", qnt+" new item(s) have been added to your cart");
								RequestDispatcher rd = req.getRequestDispatcher("itempage.jsp?id="+itemcode);
								rd.forward(req, res);
								
							} else {
								req.setAttribute("error", "Something went wrong. Please try again later!");
								RequestDispatcher rd = req.getRequestDispatcher("itempage.jsp?id="+itemcode);
								rd.forward(req, res);
							}	
							
							
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					
				}
				
				if(rows > 0) {					

					System.out.println("Available");
					
				}else {
					//if added product is not already available in cart
					System.out.println("Not Available");
					
						try	{
							String sql2 = "INSERT INTO `tbl_cart` (`user_id`, `item_id`, `quantities`) VALUES (?,?,?)";
							PreparedStatement stmt2 = conn.prepareStatement(sql2);
							
							stmt2.setInt(1, userid);
							stmt2.setString(2, itemcode);
							stmt2.setInt(3, qnt);
							
							int affectedRows2 = stmt2.executeUpdate();
							
							if(affectedRows2 > 0) {
								
								req.setAttribute("added", qnt+" new item(s) have been added to your cart");
								RequestDispatcher rd = req.getRequestDispatcher("itempage.jsp?id="+itemcode);
								rd.forward(req, res);
								
							} else {
								req.setAttribute("error", "Something went wrong. Please try again later!");
								RequestDispatcher rd = req.getRequestDispatcher("itempage.jsp?id="+itemcode);
								rd.forward(req, res);
							}
						} catch (Exception e) {
							System.out.println("ERROR : "+e.getMessage());
						}
					
					
				}
				
				
				//close connection
				conn.close();
				
				
				
				
				
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			/*
			*/
			
			
			
			
		}else {			
			res.sendRedirect("signin.jsp");			
		}
		
		
		
		
		
	}

}
