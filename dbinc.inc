<?php
$link = mysql_connect('localhost', 'root', 'r00tr00t');
if(!link)
{
 die("could not connect".mysql_error());
}
if(!mysql_select_db('dsp'))
{
 die('couldnt select database: '.mysql_error());
}
?>
