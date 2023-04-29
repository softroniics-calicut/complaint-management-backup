<?php
include "api/connection.php";
$district = $_POST['district'];

$result = mysqli_query($con, "SELECT * FROM taluk where district = '$district'");
?>
<?php
while ($row = mysqli_fetch_array($result)) {
?>
    <option value="<?php echo $row['taluk_name']; ?>"><?php echo $row['taluk_name']; ?></option>
<?php
}
?>