// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require tinymce
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require tinymce-jquery
//= require_tree .

$.extend( true, $.fn.dataTable.defaults, {
  "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
  "sPaginationType": "bootstrap",
  "oLanguage": {
    "sLengthMenu": "_MENU_ records per page"
  }
} );

/* Table initialisation */
$(document).ready(function() {
  $('#data_tables').dataTable( {
    "aaSorting": [],
    "oLanguage": {
      "sLengthMenu": 'Display <select>'+
        '<option value="10">10</option>'+
        '<option value="20">20</option>'+
        '<option value="30">30</option>'+
        '<option value="40">40</option>'+
        '<option value="50">50</option>'+
        '<option value="-1">All</option>'+
        '</select> records'
    }
  } );
} );
//datepicker
$(function() {
    $( "#datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: "yy-mm-dd",
      yearRange: '2005: _ '
    });
  });

$(function() {
    $( "#datepicker1" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: "yy-mm-dd",
      yearRange: '2005: _ '
    });
  });
//sorting
