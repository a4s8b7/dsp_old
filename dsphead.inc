<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>

<?php
include('dbinc.inc');
//mysql_query('select * from global where cpitemname like "');
?>
<?php 
$sfname=$_SERVER['SCRIPT_FILENAME']; 
$exploded=explode("/",$sfname);
$fname=end($exploded);
switch($fname)
{
 case "software.php":$cpitemname="Software";break;
 case "projects.php":$cpitemname="Projects";break;
 default:$cpitemname="";break;
}
$result = mysql_query('select * from global where cpitemname like "'.$cpitemname.'" and ai=1');
if(!$result)
{
 die('could not query'.mysql_error());
}
while($row=mysql_fetch_array($result, MYSQL_NUM))
{
 $bkgdimghref=$row[7];
 $bkgdimgalt=$row[8];
 $basedir= $row[2];
}


echo '<body style="background:url(\''.$basedir."/".$bkgdimghref.'\')" class="tileme">';
?>
<img class="centerme" src="images/header1.jpg"/>

<div class="centerme edges heightcenter" style="width:904px;">

