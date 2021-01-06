
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.Session"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.supermarket.sevenstar.dbconfig.DbConfiguration"%>
<%@page import="java.sql.Connection"%>

			
		<%
		
		int userid = (Integer) session.getAttribute("u_id");
		
		Connection conn = DbConfiguration.getDatabaseConnection();
		String sql = "SELECT * FROM tbl_cart WHERE user_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, userid);
		
		ResultSet rs = stmt.executeQuery();
		
		int rows = 0;
		while(rs.next()) {
			rows++;
		
		%>
		
		
			<%
			
			String itemcode =  rs.getString("item_id").toString();
			
			String sqla = "SELECT * FROM tbl_item WHERE id=?";
			PreparedStatement stmts = conn.prepareStatement(sqla);
			
			stmts.setString(1, itemcode);
			
			ResultSet rrs = stmts.executeQuery();
			
			int rowss = 0;
			while(rrs.next()) {
				rowss++;
				
			%>

			<div class="citempanel">
                
                <div class="citemdel center col-1 col-md-1">
                    <div class="delt justifycenter">
                        <a href="deletecartitem?productid=<%out.print(itemcode);%>"> <svg width="1.3em" height="1.3em" viewBox="0 0 16 16" class="bi bi-x-circle " fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                        <path fill-rule="evenodd" d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                        </svg></a>
                    </div>
                </div>
                
                <div class="citempic col-md-2 col-3">
                    <div class="itemimg unselectabel">
                        <img  class="" width="100%" height="100%" alt="N/A" src="imagers/<% out.print(rrs.getString("name")); %>.png">
                    </div>  
                </div>

                <div class="citemdec col-md-4 col-4">
                    <div class="ailnecenter3 center">
                        <div class="dec">
                            <a href="itempage.jsp?id=<%out.print(itemcode);%>"><p class="prodec"><% out.print(rrs.getString("name") + " " + rrs.getString("description")); %></p></a>
                        </div> 
                        <div class="brandcart">
                            <label class="probrand unselectabel"><% out.print(rrs.getString("brand")); %></label> 
                        </div> 
                    </div>                                 
                </div>
                
                <div class="down col-md-5 center">
                    <div class="citemprice col-md-6 center">
                        <label id="<% out.print(rrs.getString("discount")+itemcode+userid); %>" class="itempricecart center justifycenter unselectabel"></label>
                    </div>

                    <div class="citemqnt center col-md-6">
                    	<form action="updetecartitem" method="post">
	                        <div class="iquentity ">
	                            <button id="-<%out.print(itemcode);%>" name="itemcode" value="<%out.print(itemcode);%>" class="btn btnsd btn-warning iquen" type="submit"> - </button>
	                            <input name ="qnt" id="<%out.print(userid+itemcode);%>" class="form-control mr-1 ml-1 qnttext" type="number" value="<% out.print(rs.getString("quantities")); %>" min="1" max="<% out.print(rrs.getString("quantity")); %>" >
	                            <button id ="+<%out.print(itemcode);%>" name="itemcode" value="<%out.print(itemcode);%>" class="btn btnsd btn-warning iquen btnq2" type="submit"> + </button>      
	                        </div>
                        </form>
                    </div>
                </div>                

            </div>
            
            
					<!-------Quantity------------------------>
					<script>					
					    document.getElementById("-<%out.print(itemcode);%>").onclick = function(){					
					        var x = document.getElementById("<%out.print(userid+itemcode);%>").value;
					        let y = eval(x)
					        var z = 1;
					        txt = (y - z);					
					            if( txt <= 0){					            
					            }else{
					                document.getElementById("<%out.print(userid+itemcode);%>").value = txt;
					            }
					    }					
					    document.getElementById("+<%out.print(itemcode);%>").onclick = function(){					
					        qnt = document.getElementById("<%out.print(userid+itemcode);%>").max;
					        var x = document.getElementById("<%out.print(userid+itemcode);%>").value;
					        let y = eval(x)
					        var z = 1;					
					        txt = (y + z);
					            if( txt > qnt){					            
					            }else{
					                document.getElementById("<%out.print(userid+itemcode);%>").value = txt;
					            }
					    }
					
					</script>    
					
					<!-- -------currency format-------- -->
					<script> 	               	
		               document.getElementById("<% out.print(rrs.getString("discount")+itemcode+userid); %>").innerText =  "Rs. " + formatMoney(<% out.print(rrs.getString("discount")); %>);
	                </script>
            
            
			<%
			}
			}
			
			%>

