package com.supermarket.sevenstar;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StaffidServlet extends HttpServlet{
	
	private static final long serialVersionUID = -2984454665171096055L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String userid = req.getParameter("userid").toString();
		
		System.out.println(userid);
		
		req.setAttribute("userid", userid);
		RequestDispatcher rd = req.getRequestDispatcher("staff.jsp");
		rd.forward(req, res);
		
	}


}
