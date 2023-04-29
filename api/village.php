<?php
include 'connection.php';

$log = $_POST['id']; 
$village = $_POST['village'];

$sql = mysqli_query($con,"UPDATE users SET village='$village' where login_id= '$log'");
  
if ($sql) {

    $myarray['message'] = 'updated';

    // $myarray['login_id'] = $row['login_id'];

    // $myarray['type'] = $row['type'];
  
} else {

  $myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>