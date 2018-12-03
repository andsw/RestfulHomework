<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="Registration_page.css">
    <script src="https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js">
    </script>
    <script>
    	function index(){
	$('.welcome').css('color','#03a9f4');  
	setTimeout(" $('.welcome').css('color','white')",1000); 
	setTimeout( "$('.welcome').css('color','blue')",2000); 
};
window.setInterval(index, 3000); 
        $(document).ready(function(){
        $("#hide").click(function(){
            if($("#man").is(":hidden")){
                $("#man").fadeIn(); 
                 $("#woman").hide(); 
            }else{
                $("#man").hide();
            }
        });    
        $("#hide2").click(function() {
            if($("#woman").is(":hidden")){
              $("#woman").fadeIn(); 
                $("#man").hide(); 
            }else{
                $("#woman").hide(); 
            }
        });
        });
        
    </script>
</head>
<body>
            <div class="container"> 
            <div class="box"></div>
            <div class="InputName" id="">用户名称：</div>
            <div class="InputBox1"> <input  type="text" name="lastname" value=""></div>
            <div class="InputTrueName">用户实名：</div>
            <div class="InputBox2"> <input  type="text" name="lastname" value=""></div>
            <div class="PassWord">密          码：</div>
            <div class="InputBox3"> <input  type="text" name="lastname" value=""></div> 
            <div class="Password_confirmation">密码确认：</div>
            <div class="InputBox4"> <input  type="text" name="lastname" value=""></div> 
            <div class="Sex">性         别：</div> 
      <label class="Sex1"><input name="Sex2" type="radio" value=""  id="hide"/>男</label> 
            <label class="Sex2"><input name="Sex2" type="radio" value=""  id="hide2"/>女</label> 
                   <p hidden="hidden" id="woman">
            <input name="woman1" class="woman1" type="button"  onclick="javascrtpt:window.location.href='#'"/>
            <input name="woman2" class="woman2" type="button" onclick="javascrtpt:window.location.href='#'"/>
                  </p> 
                   <p hidden="hidden" id="man">
            <input name="man1" class="man1" type="button" onclick="javascrtpt:window.location.href='#'"/>
            <input name="man2" class="man2" type="button" onclick="javascrtpt:window.location.href='#'"/>
                  </p> 
            <div><button type="button" class="sign_in"></button>
            </div>
            <div>
              </div>
              <div>
                <button type="button" class="ReturnLogin"></button>
              </div>
              <div>  
                    <button type="button" class="Click_registration"></button>
              </div>

    </div> 
</body>
