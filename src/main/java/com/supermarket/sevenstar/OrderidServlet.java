package com.supermarket.sevenstar;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class OrderidServlet extends HttpServlet{

	private static final long serialVersionUID = 3717534659597116279L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String orderid = req.getParameter("orderid").toString();
		
		System.out.println(orderid);
		
		req.setAttribute("orderid", orderid);
		RequestDispatcher rd = req.getRequestDispatcher("orders.jsp");
		rd.forward(req, res);
		
	}

}
