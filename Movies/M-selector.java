


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>JavaScript Slideshow Template</TITLE>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT TYPE="text/javascript" SRC="slideshow.js">
<!--

// JavaScript Slideshow by Patrick Fitzgerald
// http://slideshow.barelyfitz.com/

// -->
</SCRIPT>

<SCRIPT TYPE="text/javascript">
<!--

// Create the slideshow object
ss = new slideshow("ss");

// Set the delay between slides, 1000 = 1 sec
// ss.timeout = 3000;

// By default, all of the slideshow images are prefetched.
// If you have a large number of slides you can limit the
// number of images that are prefetched.
// ss.prefetch = 1;

// By default the slideshow will repeat when you get to the end.
// ss.repeat = false;

// Create the slides and add them to the slideshow.
//**************************************************** 001 *************************************************************
s = new slide();
s.src =  "pics/pic01.jpg";
s.link = "pics/pic01.jpg";
s.title = "First slide";
s.text = "This is the text for slide number <em>one<\/em>.";
//s.target = "";
//s.attr = "";
//s.filter = "";
//s.timeout = "";
ss.add_slide(s);
//**************************************************** 002 *************************************************************
s = new slide();
s.src =  "pics/pic02.jpg";
s.link = "pics/pic02.jpg";
s.title = "Second slide";
s.text = "This is the text for slide number <em>two<\/em>.";
ss.add_slide(s);
//**************************************************** 003 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 004 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 005 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 006 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 007 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 008 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 009 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 010 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 011 *************************************************************
s = new slide();
s.src =  "pics/pic03.jpg";
s.link = "pics/pic03.jpg";
s.title = "Third slide";
s.text = "This is the text for slide number <em>three<\/em>.";
ss.add_slide(s);
//**************************************************** 012 *************************************************************



// The following loop sets an attribute for all of the slides.
// This is easier than setting the attributes individually.

for (var i=0; i < ss.slides.length; i++) {

  s = ss.slides[i];
  s.target = "ss_popup";
  s.attr = "width=320,height=420,resizable=yes,scrollbars=yes";

}

//-->
</SCRIPT>
</HEAD>

<!--
The update() method is required to make sure the text matches the image.
The restore_position() and save_position() methods are optional.
The 'SS_POSITION' parameter is the name of the cookie in which the slide
number is stored.
-->
<BODY ONLOAD="ss.restore_position('SS_POSITION');ss.update();"
ONUNLOAD="ss.save_position('SS_POSITION');">

<DIV ID="slideshow">

<FORM ID="ss_form" NAME="ss_form" ACTION="" METHOD="GET">

<DIV ID="ss_controls">

<A ID="ss_start" HREF="javascript:ss.next();ss.play()"><SPAN>start</SPAN></A>

<A ID="ss_stop" HREF="javascript:ss.pause()"><SPAN>stop</SPAN></A>

<A ID="ss_view" HREF="javascript:ss.hotlink()"><SPAN>view</SPAN></A>

<A ID="ss_prev" HREF="javascript:ss.previous()"><SPAN>&lt;prev</SPAN></A>

<A ID="ss_random" HREF="javascript:ss.goto_random_slide()"><SPAN>random</SPAN></A>

<A ID="ss_next" HREF="javascript:ss.next()"><SPAN>next&gt;</SPAN></A>

<!--
The following select list will be modified with the slide titles.
-->
<SELECT ID="ss_select" NAME="ss_select" ONCHANGE="ss.goto_slide(this.selectedIndex)">
  <OPTION>Welcome to the slideshow!
  <OPTION>
  <OPTION>
  <OPTION>
  <OPTION>

</SELECT>

</DIV>

<DIV ID="ss_img_div">

<A ID="ss_img_link" HREF="javascript:ss.hotlink()"><IMG
ID="ss_img" NAME="ss_img" SRC="pics/pic01.jpg"
STYLE="width:300px;filter:progid:DXImageTransform.Microsoft.Fade();"
ALT="Slideshow image"></A>

</DIV>

<DIV ID="ss_text">

<SCRIPT type="text/javascript">
<!--

// The contents of this DIV will be overwritten by browsers
// that support innerHTML.
//
// For browsers that do not support innerHTML, we will display
// a TEXTAREA element to hold the slide text.
// Note however that if the slide text contains HTML, then the
// HTML codes will be visible in the textarea.

document.write('<TEXTAREA ID="ss_textarea" NAME="ss_textarea" ROWS="6" COLS="40" WRAP="virtual"><\/TEXTAREA>\n');

ss.textarea = document.ss_form.ss_textarea;

//-->
</SCRIPT>

</DIV>

</FORM>

</DIV>

<SCRIPT TYPE="text/javascript">
<!--

// Finish defining and activating the slideshow

// Set up the select list with the slide titles
function config_ss_select() {
  var selectlist = document.ss_form.ss_select;
  selectlist.options.length = 0;
  for (var i = 0; i < ss.slides.length; i++) {
    selectlist.options[i] = new Option();
    selectlist.options[i].text = (i + 1) + '. ' + ss.slides[i].title;
  }
  selectlist.selectedIndex = ss.current;
}

// If you want some code to be called before or
// after the slide is updated, define the functions here

ss.pre_update_hook = function() {
  return;
}

ss.post_update_hook = function() {
  // For the select list with the slide titles,
  // set the selected item to the current slide
  document.ss_form.ss_select.selectedIndex = this.current;
  return;
}

if (document.images) {

  // Tell the slideshow which image object to use
  ss.image = document.images.ss_img;

  // Tell the slideshow the ID of the element
  // that will contain the text for the slide
  ss.textid = "ss_text";

  // Randomize the slideshow?
  // ss.shuffle();

  // Set up the select list with the slide titles
  config_ss_select();

  // Update the image and the text for the slideshow
  ss.update();

  // Auto-play the slideshow
  //ss.play();
}

//-->
</SCRIPT>


<SCRIPT TYPE="text/javascript">
<!--

// Make the slideshow accessible to search engines
// and non-javascript browsers.
//
// The following function is normally left commented out.
// It is used only to produce some HTML that you can copy
// into the NOSCRIPT section below.
// The HTML produced will contain all of the slideshow images,
// plus the text for each image.

// document.write("<PRE>" + ss.noscript() + "<\/PRE>");

//-->
</SCRIPT>

<NOSCRIPT>

<!--
This is a version of the slideshow for search engines
and non-javascript browsers
-->

</NOSCRIPT>

</BODY>
</HTML>
