<?php
include 'api/connection.php';
$id = $_GET['id'];
mysqli_query($con,"UPDATE collector SET coll_status='1' where coll_id='$id'");
header("location:collectors.php");
?>