package com.supermarket.sevenstar;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SortServlet extends HttpServlet{

	private static final long serialVersionUID = 3711184260831075459L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		
		HttpSession session = req.getSession();
		
		String sort = req.getParameter("sort").toString();
		String sorti="";
		String searchname = session.getAttribute("searchname").toString();
		String search = session.getAttribute("search").toString();
		
		
		if(sort.equals("Price Low to High")) {
			sorti = "PLH";
		}else if (sort.equals("Price High to Low")){
			sorti = "PHL";
		}else if (sort.equals("Best Match")){
			sorti = "BM";
		}
		
		req.setAttribute("sort",sorti);
		RequestDispatcher rd = req.getRequestDispatcher("searchresults.jsp?"+searchname+search);
		rd.forward(req, res);
		
		System.out.println("searchresults.jsp?"+searchname+search);
		
	}
}
