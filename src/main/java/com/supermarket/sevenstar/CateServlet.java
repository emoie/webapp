package com.supermarket.sevenstar;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CateServlet extends HttpServlet{

	private static final long serialVersionUID = 7200215267988385269L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		HttpSession session = req.getSession();

		if(req.getParameter("catego") != null) {
		
			String catego = req.getParameter("catego").toString();
			
			
			
			if(catego!=null) {
			
				System.out.println("Category id is : "+catego);
				
				session.setAttribute("catego", catego);
				
				
				if(session.getAttribute("catego")!=null) {
										
					req.setAttribute("catego",catego);
					RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
					rd.forward(req, res);	
					
					System.out.println("Step 01 is Done !");
					
				}
			
			}
			
			
			
		}else if(req.getParameter("subcate") != null && session.getAttribute("catego") != null) {
			
			
			String subcate = req.getParameter("subcate").toString();	
			
			
			if(subcate!=null) {
				
				System.out.println("Sub-Category id is : "+subcate);
				
				session.setAttribute("subcate", subcate);
				
				
				if(session.getAttribute("subcate")!=null) {
					
					req.setAttribute("subcate",subcate);
					RequestDispatcher rd = req.getRequestDispatcher("products.jsp");
					rd.forward(req, res);	
					
					System.out.println("Step 02 is Done !");
					
				}
				
				
			}
			
			
			
		}
	}

}
