<?php
include "api/connection.php";
$taluk = $_POST['taluk'];

$result = mysqli_query($con, "SELECT * FROM village where taluk = '$taluk'");
?>
<?php
while ($row = mysqli_fetch_array($result)) {
?>
    <option value="<?php echo $row['village']; ?>"><?php echo $row['village']; ?></option>
<?php
}
?>