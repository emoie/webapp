

<jsp:include page="myaccount-header.jsp"></jsp:include>





    <form class="needs-validation" action="updatepass" method="post" novalidate>

        <div class="container">
            <div class="row userdetails">
                
                <div class="alert mb-4 accountdetailstile unselectabel col-md-12" role="alert"><span>Change Password...</span> </div>

                <div class="colom01 col-md-10 pl-4">
                    
                    <div class="row">
                        <div class="col-md-5">
                            <div class="form-group">
                                <label for="currentpass">Current Password</label>
                                <input name="currentpass" type="password" class="form-control" id="currentpass" placeholder="Type Your Current Pasword" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-5">
                            <div class="form-group">
                                <label for="newpass">New Password</label>
                                <input  type="password" class="form-control" id="newpass" minlength="8" placeholder="New password with a minimum of 8 characters" required>
                            </div>
                        </div>

                        <div class="col-md-5">
                            <div class="form-group">
                                <label for="retypepass">Retype New Password</label>
                                <input name="newwpass"  type="password" name="pass" class="form-control" id="retypepass" minlength="8" placeholder="Retype Your New Password" required>
                            </div> 
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <button type="submit" class="btn mt-1 mb-1 btn-primary form-control updatebntuserdetails">Save Changers</button>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-1">
                        <div class="col-md-6">
				                <label class="spansize2">  
					               <%				    
								    if(request.getAttribute("succuss") != null || request.getAttribute("error") != null){
								    
									  	if(request.getAttribute("succuss") != null){
									  		
									  		 out.print(request.getAttribute("succuss"));
								    		
										 }else if (request.getAttribute("error") != null){
										    
											 out.print(request.getAttribute("error"));
										 }
								    }									  	
								  	%>	
								</label>
                        </div>
                    </div> 

                </div>                

            </div>
        </div>

    </form>

    
    <script>

        var password = document.getElementById("newpass"), confirm_password = document.getElementById("retypepass");

        function validatePassword(){
        if(password.value != confirm_password.value) {
            confirm_password.setCustomValidity("Passwords Don't Match");
        } else {
            confirm_password.setCustomValidity('');
        }
        }

        password.onchange = validatePassword;
        confirm_password.onkeyup = validatePassword;

    </script>






<jsp:include page="myaccount-footer.jsp"></jsp:include>