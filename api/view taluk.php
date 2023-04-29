<?php
include 'connection.php';

$dist = $_POST['dist'];
$sql = mysqli_query($con,"select * from taluk where district='$dist'");
$list = array();

if ($sql->num_rows>0) {
    while ($row = mysqli_fetch_assoc($sql)){

  

    $myarray['message'] = 'viewed';
    $myarray['taluk_id'] = $row['taluk_id'];
    $myarray['taluk_name'] = $row['taluk_name'];


    array_push($list, $myarray);
  
}
}
 else {

  $myarray['message'] = 'failed';
  array_push($list, $myarray);
}
echo json_encode($list);



?>