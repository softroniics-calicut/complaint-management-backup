<?php
include 'connection.php';
$name = $_POST['name'];
$email = $_POST['email'];
$mobile = $_POST['mobile'];

$password = $_POST['password'];

mysqli_query($con, "INSERT INTO login(username,password,type)values('$email','$password','user')");
$log = mysqli_insert_id($con);
$sql = mysqli_query($con,"insert into users(login_id,name,email,mobile) values('$log','$name','$email','$mobile')");
$lid = mysqli_query($con,"select * from users where login_id = '$log'");

if ($sql) {

    $row =mysqli_fetch_assoc($lid);

    $myarray['message'] = 'Added';

    $myarray['login_id'] = $row['login_id'];

    // $myarray['type'] = $row['type'];
  
} else {

  $myarray['message'] = 'Failed';
}
echo json_encode($myarray);

?>