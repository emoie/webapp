package com.supermarket.sevenstar;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductidServlet extends HttpServlet{
	
	private static final long serialVersionUID = -4028033438801316639L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String product = req.getParameter("productid").toString();
		
		System.out.println(product);
		
		req.setAttribute("productid", product);
		RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
		rd.forward(req, res);
		
	}

}

