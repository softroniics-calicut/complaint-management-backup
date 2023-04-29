<?php
include 'connection.php';


$taluk = $_POST['taluk'];


$sql = mysqli_query($con,"select * from village where taluk='$taluk'");
  
$list = array();

if ($sql->num_rows > 0) {

    while ($row = mysqli_fetch_assoc($sql)) {

        $myarray['id'] = $row['village_id'];
        $myarray['village'] = $row['village'];
       

        array_push($list, $myarray);
    }
} else {



    $myarray['message'] = 'failed';
    array_push($list, $myarray);
}
echo json_encode($list);
?>