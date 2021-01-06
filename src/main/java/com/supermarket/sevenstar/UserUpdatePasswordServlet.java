package com.supermarket.sevenstar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import com.supermarket.sevenstar.dbconfig.DbConfiguration;

public class UserUpdatePasswordServlet extends HttpServlet{

	private static final long serialVersionUID = -6537206531323592384L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session =  req.getSession();
		
		
		if(session.getAttribute("u_loggedin") != null &&  (Boolean)session.getAttribute("u_loggedin") == true){
			
			
			
			int userid = (Integer)session.getAttribute("u_id");
			String currentpass = req.getParameter("currentpass").toString();
			String newpass = req.getParameter("newpass").toString();

			//Encrypting password with SHA-1 
			String currentencpass = DigestUtils.sha1Hex(currentpass);
			String newencpass = DigestUtils.sha1Hex(newpass);
			
			System.out.println(currentpass);
			System.out.println(newpass);
			
			System.out.println("Logged in");
			
			//Setup MySQL Driver
			try {
				
				
				Connection conn = DbConfiguration.getDatabaseConnection();
				//Preparing the query
				String sql = "SELECT * FROM tbl_user WHERE user_id=? AND password=?";
				PreparedStatement stmt =  conn.prepareStatement(sql);
				
				//bind values
				stmt.setInt(1, userid);
				stmt.setString(2, currentencpass);
				
				ResultSet rs = stmt.executeQuery();
				
				int rows = 0;
				
				while(rs.next()) {
					rows++;
					
					System.out.println("Correct password");
				}

				if(rows > 0) {

					//Update password----------------------------------
					String sqli = "UPDATE `tbl_user` SET `password` = ? WHERE `user_id`=?";
					PreparedStatement stmti = conn.prepareStatement(sqli);
					
					stmti.setString(1, newencpass);
					stmti.setInt(2, userid);
					
					int affectedRows = stmti.executeUpdate();
					
					if(affectedRows > 0) {
						req.setAttribute("succuss", "Your account password has been updated.");
						RequestDispatcher rd = req.getRequestDispatcher("user-address.jsp");
						rd.forward(req, res);
						
						System.out.println(req.getAttribute("succuss"));						
					}
					
					
				}else {
					//login failed
					req.setAttribute("error", "Entered current password is invalid");
					RequestDispatcher rd = req.getRequestDispatcher("user-change-password.jsp");
					rd.forward(req, res);
				}
				
				//close connection
				conn.close();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
					
		}	
		
		
	}
	

}
