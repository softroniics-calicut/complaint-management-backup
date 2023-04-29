<?php
include 'connection.php';

$sql = mysqli_query($con,"select * from department");
  
$list = array();

if ($sql->num_rows > 0) {

    while ($row = mysqli_fetch_assoc($sql)) {

        $myarray['id'] = $row['dept_id'];
        $myarray['dept_name'] = $row['dept_name'];
       

        array_push($list, $myarray);
    }
} else {



    $myarray['message'] = 'failed';
    array_push($list, $myarray);
}
echo json_encode($list);
?>