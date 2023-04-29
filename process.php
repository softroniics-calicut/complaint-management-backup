<?php
include 'api/connection.php';
$id = $_GET['id'];
mysqli_query($con,"update complaints set status='2' where comp_id = '$id'");
echo "<script>alert('Complaint Successfully move to Processing');</script>";
echo "<script>window.location.href='viewed-complaints.php';</script>";
?>