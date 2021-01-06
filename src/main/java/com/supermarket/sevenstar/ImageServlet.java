package com.supermarket.sevenstar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class  ImageServlet extends HttpServlet{

	private static final long serialVersionUID = 6282800513344005922L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {			
		
		
		
		HttpSession session = req.getSession();
		
		if(session.getAttribute("catego") != null && session.getAttribute("subcate") != null && session.getAttribute("productnameq") != null&& session.getAttribute("pdec") != null&& session.getAttribute("brand") != null&& session.getAttribute("warrenty") != null&& session.getAttribute("productprice") != null&& session.getAttribute("discount") != null&& session.getAttribute("qnt") != null) {
						
				
				String subcate = session.getAttribute("subcate").toString();
				String productnameq = session.getAttribute("productnameq").toString();
				String pdec = session.getAttribute("pdec").toString();
				String brand = session.getAttribute("brand").toString();
				String warrenty = session.getAttribute("warrenty").toString();
				String productprice =  session.getAttribute("productprice").toString();
				String discount =  session.getAttribute("discount").toString();
				String qnt =  session.getAttribute("qnt").toString();
					    

			    
			    try	{
					Connection conn = DbConfiguration.getDatabaseConnection();
					String sql = "INSERT INTO `tbl_item` (`subcate_id`, `name`, `brand`, `description`, `warrenty`, `quantity`, `price`, `discount`) VALUES (?,?,?,?,?,?,?,?)";
					PreparedStatement stmt = conn.prepareStatement(sql);
					
					stmt.setString(1, subcate);
					stmt.setString(2, productnameq);
					stmt.setString(3, brand);
					stmt.setString(4, pdec);
					stmt.setString(5, warrenty);
					stmt.setString(6, qnt);
					stmt.setString(7, productprice);
					stmt.setString(8, discount);

	
					int affectedRows = stmt.executeUpdate();
					
					if(affectedRows > 0) {
						
						req.setAttribute("addedproduct", "A new product was added to the system.");
							
						
						session.removeAttribute("catego");
						session.removeAttribute("subcate");
						session.removeAttribute("productnameq");
						session.removeAttribute("pdec");
						session.removeAttribute("brand");
						session.removeAttribute("warrenty");
						session.removeAttribute("productprice");
						session.removeAttribute("discount");
						session.removeAttribute("qnt");
						
						
						RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
						rd.forward(req, res);
						
					} else {
						
						session.removeAttribute("catego");
						session.removeAttribute("subcate");
						session.removeAttribute("productnameq");
						session.removeAttribute("pdec");
						session.removeAttribute("brand");
						session.removeAttribute("warrenty");
						session.removeAttribute("productprice");
						session.removeAttribute("discount");
						session.removeAttribute("qnt");
						
						req.setAttribute("addedproduct", "Something went wrong");
						RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
						rd.forward(req, res);

					}
				} catch (Exception e) {
					System.out.println("ERROR : "+e.getMessage());
					
					session.removeAttribute("catego");
					session.removeAttribute("subcate");
					session.removeAttribute("productnameq");
					session.removeAttribute("pdec");
					session.removeAttribute("brand");
					session.removeAttribute("warrenty");
					session.removeAttribute("productprice");
					session.removeAttribute("discount");
					session.removeAttribute("qnt");
					
					req.setAttribute("addedproduct", "ERROR : "+e.getMessage());
					RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
					rd.forward(req, res);
					
				}
			    
			
		}else {
			res.sendRedirect("products.jsp");
		}
	
		
	}
	
}
