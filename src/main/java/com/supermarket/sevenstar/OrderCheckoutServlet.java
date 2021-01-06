package com.supermarket.sevenstar;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class OrderCheckoutServlet extends HttpServlet{
	
	private static final long serialVersionUID = -5326536928202202677L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		HttpSession session = req.getSession();
		
		if(session.getAttribute("u_loggedin") != null && (Boolean)session.getAttribute("u_loggedin") == true){
			
		
			String ste =  req.getParameter("step").toString();
			
			int step =Integer.parseInt(ste);  
			
			if(step == 1) {
				
				DateFormat df = new SimpleDateFormat("ddMMhhmmyyyss");
				Calendar calobj = Calendar.getInstance();
				String orderid = df.format(calobj.getTime());				
				
				session.setAttribute("orderid", orderid);
				System.out.println(orderid);
				
				if(session.getAttribute("orderid") != null) {
					
					res.sendRedirect("checkout.jsp");
				}
				
			}else if (step == 2) {
				
				
				String fullname =  req.getParameter("fullname").toString();
				String email =  req.getParameter("email").toString();
				String phone =  req.getParameter("phone").toString();
				String address =  req.getParameter("address").toString();
				String country =  req.getParameter("country").toString();
				String state =  req.getParameter("state").toString();
				String zip =  req.getParameter("zip").toString();
				
				session.setAttribute("fullname", fullname);
				session.setAttribute("email", email);
				session.setAttribute("phone", phone);
				session.setAttribute("address", address+" "+country+" "+state+" "+zip);
				
				if(session.getAttribute("address") != null) {
					res.sendRedirect("payment.jsp");						
				}
				
			}else if (step == 3) {
				
				
				String paymethod = "";
				
					if(req.getParameter("method").toString() != null) {
						if(req.getParameter("method").toString().equals("COD")) {
							paymethod = "2";
						}else {
							paymethod = "1";
						}
					}
				
				int userid = (Integer) session.getAttribute("u_id");
				String orderid = (String) session.getAttribute("orderid");
				String fullname = (String) session.getAttribute("fullname");
				String email = (String) session.getAttribute("email");
				String phone = (String) session.getAttribute("phone");
				String address = (String) session.getAttribute("address");
		        
				System.out.println(address);
								
				
				if(session.getAttribute("u_loggedin") != null && (Boolean)session.getAttribute("u_loggedin") == true){
					
					if(session.getAttribute("orderid") != null && session.getAttribute("address") != null){
						
						int totprice=0;
						
						
						
					
					try {
						Connection conn = DbConfiguration.getDatabaseConnection();
						String sqllli = "SELECT SUM(i.discount*quantities) as total FROM tbl_cart c INNER JOIN tbl_item i WHERE c.item_id=i.id AND c.user_id=?";
						PreparedStatement stmtttm = conn.prepareStatement(sqllli);
						
						stmtttm.setInt(1, userid);	
						
						ResultSet rs1w = stmtttm.executeQuery();
						
						int rowqs = 0;
						
						System.out.println(rowqs);
						
						while(rs1w.next()) {
							rowqs++;	
							
							totprice = rs1w.getInt("total");
							
						}
							System.out.println(totprice);
							
							
							String sql = "INSERT INTO `tbl_order` (`user_id`, `order_id`, `total_price`, `receiver_name`, `email`, `phone`, `address`, `payment_id`, `delivery_id`, `status`) VALUES (?,?,?,?,?,?,?,?,?,?)";
							PreparedStatement stmt = conn.prepareStatement(sql);
							
							stmt.setInt(1, userid);
							stmt.setString(2, orderid);
							stmt.setInt(3, totprice);
							stmt.setString(4, fullname);
							stmt.setString(5, email);
							stmt.setString(6, phone);
							stmt.setString(7, address);
							stmt.setString(8, paymethod);
							stmt.setString(9, "1");
							stmt.setString(10, "Order Confirmed");
							
							int affectedRows = stmt.executeUpdate();
							
							if(affectedRows > 0) {

								System.out.println("Step 01 Done!");
															
								//------------------------------------------------------------------------------------------------
									//Selecting all cart items and inserting into order details table
									String sql1 = "SELECT  c.user_id, c.item_id, c.quantities, i.discount FROM tbl_cart c INNER JOIN tbl_item i WHERE c.item_id=i.id AND c.user_id=?";
									PreparedStatement stmt1 = conn.prepareStatement(sql1);
	
									stmt1.setInt(1,userid);
									
									ResultSet rs1 = stmt1.executeQuery();
									
									int rows = 0;
									
									while(rs1.next()) {
										rows++;	
										
										int qnt = rs1.getInt("quantities");
										int price = rs1.getInt("discount");		
										int subtotal = qnt * price;
										int shippingfee = 150;
										int totalwithoutshipping = subtotal;
										int total = subtotal+shippingfee;
										
										System.out.println(total);
										
										//------------------------------------------------------------------------------------------------
										
											System.out.println("Step 02 Done!");
											//insert into all cart items into order details table
											
											String sql2 = "INSERT INTO `tbl_orderinfor` (`order_id`, `item_id`, `quantity`, `price`) VALUES (?,?,?,?)";
											PreparedStatement stmt2 = conn.prepareStatement(sql2);
											
											stmt2.setString(1, orderid);
											stmt2.setString(2, rs1.getString("item_id"));
											stmt2.setString(3, rs1.getString("quantities"));
											stmt2.setInt(4, totalwithoutshipping);
											
											stmt2.executeUpdate();
													
									}
									if(rows > 0) {
										
										//------------------------------------------------------------------------------------------------
										//Deleting all items in tbl_cart which belongs to relevant user
											String sql4 = "DELETE FROM tbl_cart WHERE user_id=?";
											PreparedStatement stmt4 =  conn.prepareStatement(sql4);
											
											stmt4.setInt(1, userid);
											
											int  affectedrows4 = stmt4.executeUpdate();									
											
											if(affectedrows4 > 0) {
												
												System.out.println("Deleting all items in tbl_cart which belongs to relevant user");
												
												session.removeAttribute("orderid");
												session.removeAttribute("fullname");
												session.removeAttribute("email");
												session.removeAttribute("phone");
												session.removeAttribute("address");
												res.sendRedirect("orderplaced.jsp");
												
											}else {
												session.removeAttribute("orderid");
												session.removeAttribute("fullname");
												session.removeAttribute("email");
												session.removeAttribute("phone");
												session.removeAttribute("address");
												res.sendRedirect("cart.jsp");
											}											
											/////////////////////////////
										
										
									}else {
										session.removeAttribute("orderid");
										session.removeAttribute("fullname");
										session.removeAttribute("email");
										session.removeAttribute("phone");
										session.removeAttribute("address");
										res.sendRedirect("cart.jsp");
									}
								
								
								
							} else {
								session.removeAttribute("orderid");
								session.removeAttribute("fullname");
								session.removeAttribute("email");
								session.removeAttribute("phone");
								session.removeAttribute("address");
								res.sendRedirect("cart.jsp");
							}
							
							
						} catch (Exception e) {
							e.printStackTrace();
						}
						
						
						
						
					}
					
					
				}else {
					res.sendRedirect("signin.jsp");
				}
				
			}
			
			
			
		}
		
	}

}







