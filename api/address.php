<?php
include 'connection.php';

$log = $_POST['id']; 
$address = $_POST['address'];

$sql = mysqli_query($con,"UPDATE users SET address_user='$address' where login_id= '$log'");
  
if ($sql) {

    $myarray['message'] = 'updated';

    // $myarray['login_id'] = $row['login_id'];

    // $myarray['type'] = $row['type'];
  
} else {

  $myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>