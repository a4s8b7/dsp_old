<p style="width:760px;display:block; margin-left:auto; margin-right:auto;">
<?php
$imagesfolder='software';
include('dbinc.inc');
/*
$link = mysql_connect('localhost', 'root', 'r00tr00t');
if(!link)
{
 die("could not connect".mysql_error());
}
if(!mysql_select_db('dsp'))
{
 die('couldnt select database: '.mysql_error());
}
*/
$result = mysql_query('select * from global where cpitemname like "Software" and ai=1');
if(!$result)
{
 die('could not query'.mysql_error());
}
while($row = mysql_fetch_array($result, MYSQL_NUM))
{
 //printf("id: %d label: %s", $row[0], $row[3]);
 $basedir = $row[2];
 $title = $row[3];
 $headerimg = "/".$imagesfolder."/".$row[5];
}
//echo '<span style="margin-left:auto;margin-right:auto;width:760px;display:block;">'.
echo '<h2 style="text-align:center;padding-top:0; margin-top:0;">'.$title.'</h2>';
//.'</span>';
?>
	<img class="centerme" style="margin-top:4px; margin-bottom:4px;" src="<?php echo $headerimg;?>"/>
<?php
$result = mysql_query('select * from software order by name and ai=1');
if(!$result)
{
 die('could not query'.mysql_error());
}
?>
<table style="width:760px;display:block; margin-left:auto;margin-right:auto;" border="1" cellspacing="0" cellpadding="0">
<?php
$ctr = 0;
while($row = mysql_fetch_array($result, MYSQL_NUM))
{
 $str3='';
 if($row[2]==1)
 {
  $str3 = '<img src="'.$basedir.'/new.gif" alt="new"/>';
 }


 $str1 = '<h3 class="centerme">'.$str3.'<a href="'.$basedir."/".$row[4].'">'.$row[3].'</a></h3><p>'.$row[5].'</p>';
 $str2 = '<a href="'.$basedir."/".$row[4].'">'.'<img class="centerme" src="'.$imagesfolder."/".$row[6].'" alt="'.$row[7].'"/></a>';

 
 if($ctr % 2 == 0)
 {
  echo '<tr><td>'.$str1.'</td><td>'.$str2.'</td></tr>'; 
 }
 else
 {
  echo '<tr><td>'.$str2.'</td><td>'.$str1.'</td></tr>'; 
 }
 $ctr = $ctr + 1;
}
?>
</table>
<h5 style="padding:0;margin:0;text-align:center;"> <a href="index.html">Back to homepage</a> </h5>
</p>





<?php
mysql_close($link);
?>


