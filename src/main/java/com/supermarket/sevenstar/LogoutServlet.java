package com.supermarket.sevenstar;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet  extends HttpServlet{

	private static final long serialVersionUID = 6970399548421669393L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		 
		HttpSession session =  req.getSession();
		
			session.removeAttribute("u_id");
			session.removeAttribute("u_name");
			session.removeAttribute("u_email");
			session.removeAttribute("u_phone");
			session.removeAttribute("u_position");
			session.removeAttribute("u_address");
			session.setAttribute("u_loggedin", false);
			
			if(session.getAttribute("staff") != null) {
				session.removeAttribute("staff");
			}
			
			session.invalidate();
			
					
				res.sendRedirect("index.jsp");
			
		
	}
	

}
