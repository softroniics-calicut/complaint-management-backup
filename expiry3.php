<?php
session_start();
include 'api/connection.php';
$dept = $_SESSION['dept'];
$data = mysqli_query($con,"select DATE_ADD(date, INTERVAL 7 DAY) AS exp_date,comp_id,status,name,subject,file,date,time,description from complaints join users on users.login_id = complaints.login_id where complaints.department='$dept' and col_update='1'");
// var_dump($data1);exit();

?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Dashboard - NiceAdmin Bootstrap Template</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Mar 09 2023 with Bootstrap v5.2.3
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
 <?php include 'header3.php'; ?>
  <!-- End Header -->

  <!-- ======= Sidebar ======= -->
 <?php include 'sidebar3.php'; ?>
  <!-- End Sidebar-->

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Dashboard</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item active">Dashboard</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
     

      <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Users</h5>

              <!-- Table with stripped rows -->
              <table class="table datatable">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">User</th>
                    
                    <th scope="col">Subject</th>
                    <th scope="col">Description</th>
                    
                    <th scope="col">File</th>
                    <th>Date</th>
                    <th>Expiry_date </th>
                    <th>Action</th>
                    
                  </tr>
                </thead>
                <tbody>
                  <?php
                  $count=0;
                  while($row = mysqli_fetch_assoc($data)){
                    $count++;
                    $d = mysqli_query($con,"SELECT CURDATE() as C_DATE");
                    $dt = mysqli_fetch_assoc($d);

                    if($dt['C_DATE']>$row['exp_date']){
                      
                  ?>
                 
                  <tr>
                    <th scope="row"><?php echo $count; ?></th>
                    <td><?php echo $row['name'] ?></td>
                  
                    <td><?php echo $row['subject'] ?></td>
                    <td><?php echo $row['description'] ?></td>
                    <td><?php echo $row['file'] ?></td>
                    <td><?php echo $row['date'] ?></td>
                    <td><?php echo $row['exp_date'] ?>
                    <td><a href="update2.php?id=<?php echo $row['comp_id'] ?>">Update date</a></td>
                  
                 
                   
                  </tr>
                  <?php
                    }
                  }
                  ?>
                
                  
                </tbody>
              </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>

        </div>
     
    </section>

      </div>
    </section>

  </main><!-- End #main -->

  

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>