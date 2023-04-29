<?php

include 'connection.php';

$username = $_POST['user'];
$password = $_POST['pass'];
$sql = mysqli_query($con, "select * from login where username ='$username' and password ='$password'");



if ($sql) {
    if(mysqli_num_rows($sql)>0){
        $row = mysqli_fetch_assoc($sql);

        $myarray['message'] = 'login';
    
        $myarray['login_id'] = $row['login_id'];
        
        $myarray['type'] = $row['type'];
    }
    else {

        $myarray['message'] = 'failed';
      }
  
} 
echo json_encode($myarray);
