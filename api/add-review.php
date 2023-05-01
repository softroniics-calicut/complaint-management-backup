<?php
include 'connection.php';

$id = $_POST['id']; 
$cid = $_POST['cid'];
$star = $_POST['star'];
$feedback = $_POST['review'];

$sql = mysqli_query($con,"INSERT INTO rating(user_id,complaint_id,star,review)values('$id','$cid','$star','$feedback')");
  
if ($sql) {

    $myarray['message'] = 'added';

    // $myarray['login_id'] = $row['login_id'];

    // $myarray['type'] = $row['type'];
  
} else {

  $myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>