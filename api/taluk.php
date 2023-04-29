<?php
include 'connection.php';

$log = $_POST['id']; 
$taluk = $_POST['taluk'];

$sql = mysqli_query($con,"UPDATE users SET taluk='$taluk' where login_id= '$log'");
  
if ($sql) {

    $myarray['message'] = 'updated';

    // $myarray['login_id'] = $row['login_id'];

    // $myarray['type'] = $row['type'];
  
} else {

  $myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>