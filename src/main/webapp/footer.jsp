<!---<footer  class="footer">
    <div class="colorline"></div>

    <div class="bandandpayments">

    <img class="payment band"  width="25%" height="auto"alt="N/A" src="imagers/payment_logos.png"> 
    <img class="payment bank"  width="60%" height="auto" alt="N/A" src="imagers/banklogo.png">

    </div>


    <div class="copyright">

    <lable> Copyright © 2020 7-Star Supermarket (Pvt). All Rights Reserved.</lable>

    </div>
</footer >---->


<!-----------------Validation-------------------->
<script>
// Example starter JavaScript for disabling form submissions if there are invalid fields
(function() {
  'use strict';
  window.addEventListener('load', function() {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();
</script>


<!-----------------Currency Format--------------------
<script> 
        let x = document.querySelectorAll(".myDIV"); 
        for (let i = 0, len = x.length; i < len; i++) { 
            let num = Number(x[i].innerHTML) 
                      .toLocaleString('en'); 
            x[i].innerHTML = num; 
            x[i].classList.add("currSign"); 
        } 
    </script>  ------------>

<!-------Quantity------------------------>
<script>

    document.getElementById("btn-").onclick = function(){

        var x = document.getElementById("qnt").value;
        let y = eval(x)
        var z = 1;                                  
        
        txt = (y - z);

            if( txt <= 0){
            
            }else{
                document.getElementById("qnt").value = txt;
            }
    }

    document.getElementById("btn+").onclick = function(){

        qnt = document.getElementById("qnt").max;
        var x = document.getElementById("qnt").value;
        let y = eval(x)
        var z = 1;

        txt = (y + z);                                    

            if( txt > qnt){
            
            }else{
                document.getElementById("qnt").value = txt;
            }
    }

</script>    

<!-----------------Dropdown menu-------------------->
<script>
$(document).ready(function(){
  $('.dropdown-submenu a.test').on("click", function(e){
    $(this).next('ul').toggle();
    e.stopPropagation();
    e.preventDefault();
  });
});
</script>





<script src="js/jquery-3.5.1.slim.min.js"></script>  
<script src="js/popper.min.js"></script>      
<script src="js/bootstrap.js"></script>  
<script src="js/index.js"></script>  

<script>
    $(window).on("load",function(){
        $(".loader-wrapper").fadeOut("slow");
    });
</script>

<script src="js/jquery-2.1.4.js"></script>
 

</body>
</html>