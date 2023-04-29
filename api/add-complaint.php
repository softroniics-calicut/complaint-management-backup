<?php
include 'connection.php';

$log = $_POST['id']; 
$dept = $_POST['dept'];
$subject = $_POST['subject'];
$description = $_POST['description'];

$image = $_FILES['pic']['name'];
    if ($image != "") {
        $filearray = pathinfo($_FILES['pic']['name']);
        // var_dump($filearray);exit();

        $file = rand();
        $file_ext = $filearray["extension"];




        $filenew = $file . "." . $file_ext;
        // var_dump($filenew);exit();
        move_uploaded_file($_FILES['pic']['tmp_name'], "../assets/img/" . $filenew);
        //var_dump($filenew);exit();
    }


$sql = mysqli_query($con,"INSERT INTO complaints(login_id,department,subject,description,file)values('$log','$dept','$subject','$description','$filenew')");
  
if ($sql) {

    $myarray['message'] = 'added';

    // $myarray['login_id'] = $row['login_id'];

    // $myarray['type'] = $row['type'];
  
} else {

  $myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>