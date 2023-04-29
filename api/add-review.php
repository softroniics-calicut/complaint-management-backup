<?php
include 'connection.php';

$id = $_POST['id']; 
$feedback = $_POST['feedback'];

$sql = mysqli_query($con,"INSERT INTO rating(user_id,review)values('$id','$feedback')");
  
if ($sql) {

    $myarray['message'] = 'added';

    // $myarray['login_id'] = $row['login_id'];

    // $myarray['type'] = $row['type'];
  
} else {

  $myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>