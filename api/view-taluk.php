<?php
include 'connection.php';


$district = $_POST['district'];


$sql = mysqli_query($con,"select * from taluk where district='$district'");
  
$list = array();

if ($sql->num_rows > 0) {

    while ($row = mysqli_fetch_assoc($sql)) {

        $myarray['id'] = $row['taluk_id'];
        $myarray['taluk'] = $row['taluk_name'];
       

        array_push($list, $myarray);
    }
} else {



    $myarray['message'] = 'failed';
    array_push($list, $myarray);
}
echo json_encode($list);
?>