<?php
include 'api/connection.php';
$id = $_GET['id'];
mysqli_query($con,"update complaints set status='1' where comp_id = '$id'");
echo "<script>alert('Complaint Successfully Viewed');</script>";
echo "<script>window.location.href='new-complaints.php';</script>";
?>