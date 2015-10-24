// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).on('ready', function(){

  $('.master-container').on('click','.vote-button', function(e){
    e.preventDefault();
    var $targetLocation = $(this).parent().find('.point-value');
    var $targetForm = $(this).find('form');
    var myData = $targetForm.serialize();
    var myType = $targetForm.attr('method');
    var myUrl = $targetForm.attr('action');
    $.ajax({
      url:myUrl,
      method:myType,
      data:myData
    }).done(function(response){
      // debugger;
      $targetLocation.html(response)
    }).fail(function(deffered){
    })
  })

});
