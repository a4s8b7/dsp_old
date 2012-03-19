<?php
$link = mysql_connect('localhost', 'root', 'r00tr00t');
if(!link)
{
 die("could not connect".mysql_error());
}
echo "Connected successfully";
mysql_close($link);
?>
