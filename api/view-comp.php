<?php
include 'connection.php';


$id = $_POST['id'];


$sql = mysqli_query($con,"select * from complaints where comp_id='$id'");
  
$list = array();

if ($sql->num_rows > 0) {

    while ($row = mysqli_fetch_assoc($sql)) {

        $myarray['comp_id'] = $row['comp_id'];
        $myarray['subject'] = $row['subject'];
        $myarray['description'] = $row['description'];
        $myarray['date'] = $row['date'];
        $myarray['status'] = $row['status'];
       

        array_push($list, $myarray);
    }
} else {



    $myarray['message'] = 'failed';
    array_push($list, $myarray);
}
echo json_encode($list);
?>