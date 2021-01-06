
package com.supermarket.sevenstar;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


@MultipartConfig
public class AddProductsServlet extends HttpServlet {


	private static final long serialVersionUID = 716825946889322252L;
	
	

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {			
			
		HttpSession session = req.getSession();
		
		if(session.getAttribute("catego") != null && session.getAttribute("subcate") != null) {
						
				
				String productnameq = req.getParameter("productnameq").toString();
				String pdec = req.getParameter("pdec").toString();
				String brand = req.getParameter("brand").toString();
				String warrenty = req.getParameter("warrenty").toString();
				String productprice =  req.getParameter("productprice").toString();
				String discount =  req.getParameter("discount").toString();
				String qnt =  req.getParameter("qnt").toString();
				
				
				session.setAttribute("productnameq", productnameq);
				session.setAttribute("pdec", pdec);
				session.setAttribute("brand", brand);
				session.setAttribute("warrenty", warrenty);
				session.setAttribute("productprice", productprice);
				session.setAttribute("discount", discount);
				session.setAttribute("qnt", qnt);
					    

					
					try {	
						res.setContentType("text/plain;charset=UTF-8");

				        ServletOutputStream os = res.getOutputStream();

				        //Access the context param from web.xml
						ServletContext context = req.getServletContext();
						String path = context.getInitParameter("uploadpath");
				        System.out.println(path);

				        Part filePart = req.getPart("imgpng");

				        String fileName = filePart.getSubmittedFileName();
				        System.out.println(fileName);
				        
				        
				        InputStream is = filePart.getInputStream();

				        Files.copy(is, Paths.get(path + productnameq + ".png"),
				                StandardCopyOption.REPLACE_EXISTING);

				        os.print("File successfully uploaded");	  
			
				        res.sendRedirect("img");
					    			
					}	catch (Exception e) {
						e.printStackTrace();
					}
				    
					
					
		}
		
	}
	
}