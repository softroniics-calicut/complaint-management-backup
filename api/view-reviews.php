<?php
include 'connection.php';





$sql = mysqli_query($con,"select * from rating join users on rating.user_id = users.login_id");
  
$list = array();

if ($sql->num_rows > 0) {

    while ($row = mysqli_fetch_assoc($sql)) {

        $myarray['review'] = $row['review'];
        $myarray['name'] = $row['name'];
        $myarray['date'] = $row['date'];
       

        array_push($list, $myarray);
    }
} else {



    $myarray['message'] = 'failed';
    array_push($list, $myarray);
}
echo json_encode($list);
?>