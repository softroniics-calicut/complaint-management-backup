<?php
include 'api/connection.php';
$id = $_GET['id'];
mysqli_query($con,"UPDATE officers SET status_off='1' where off_id='$id'");
header("location:officers.php");
?>