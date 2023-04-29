<?php
include 'api/connection.php';
$id = $_GET['id'];
mysqli_query($con,"update complaints set status='3' where comp_id = '$id'");
echo "<script>alert('Complaint Successfully Solved');</script>";
echo "<script>window.location.href='solved-complaints.php';</script>";
?>