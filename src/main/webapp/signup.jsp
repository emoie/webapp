	
<jsp:include page="header.jsp"></jsp:include>	
	
	
	<div class="col-10 offset-1 col-md-6 offset-md-3 signupbox">
	
	    <h3 class="modal-title" id="exampleModalLongTitle"><b><center>Welcome to 7-Star!</center></b></h3>
	    <h5 class="modal-title" id="exampleModalLongTitle"><i><center>Please fill your information.*</center></i></h5>
	    <div class="mt-3 dropdown-divider"></div>
	
		<form class="mt-4 mx-3 needs-validation" action="register" method="POST" novalidate>
		  <div class="form-group">
		    <label for="inputname">Full Name*</label>
		    <input name="fname" type="text" class="form-control" id="inputname" placeholder="John Wick" required>
		  </div>
		  <div class="form-row">
		    <div class="form-group col-md-6">
		      <label for="inputCity">Phone Number*</label>
		      <input name="phone" type="tel" class="form-control" id="inputCity" maxlength="10" minlength="10" pattern="[0]{1}[7]{1}[0-8]{1}[0-9]{7}" placeholder="07X XXX XXXX" required>
		    </div>
		  </div>
		  <div class="form-row">
		    <div class="form-group col-md-6">
		      <label for="inputEmail4">Email*</label>
		      <input name="email" type="email" class="form-control" id="inputEmail4" placeholder="Email" required>
		    </div>
		  </div>
		  <div class="form-row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="newpass">New Password</label>
                    <input type="password" class="form-control" id="newpassword" minlength="8" placeholder="New password with a minimum of 8 characters" required>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label for="retypepass">Confirm Password</label>
                    <input type="password" name="password" class="form-control" id="retypepassword" minlength="8" placeholder="Retype Your New Password" required>
                </div> 
            </div>
          </div>
		  <div class="form-group">
		    <label for="inputAddress">Address*</label>
		    <input name="address" type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" required>
		  </div>
		  <div class="form-row">
		    <div class="form-group col-md-6">
		      <label for="inputCity">City*</label>
		      <input name="city" type="text" class="form-control" id="inputCity" placeholder="Wellawatte" required>
		    </div>
		    <div class="form-group col-md-4">
		      <label for="inputState">State*</label>
		      <input name="state" id="inputState" type="text" class="form-control" placeholder="Colombo" required>
		    </div>
		    <div class="form-group col-md-2">
		      <label for="inputZip">Zip*</label>
		      <input name="zip" type="number" class="form-control" id="inputZip"  placeholder="XXXX" required>
		    </div>
		  </div>
		  
		  <div class="mt-4 modal-footer" novalidate >
		    <button type="submit" name="signupbtn" class="btn btn-primary form-control signinbtn"  >Sign-up</button>
		    <p><center><i>By creating an account, you agree to the 7-Star.com Free Membership Agreement and Privacy Policy</i></center></p>
		  </div>
		</form>
	
	</div>
	
	<script>

        var password = document.getElementById("newpassword"), confirm_password = document.getElementById("retypepassword");

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
	
<jsp:include page="footer.jsp"></jsp:include>
