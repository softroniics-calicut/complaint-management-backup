<?php
include 'api/connection.php';
$id = $_GET['id'];
mysqli_query($con,"UPDATE minister SET min_status='1' where min_id='$id'");
header("location:ministers.php");
?>