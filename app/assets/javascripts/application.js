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
      $targetLocation.html(response)
    }).fail(function(deffered){
      alert(deffered.status + "ERROR: I duno what you were doing but Stop It")
    })
  })

  $(document).ready(function() {
    var stickyNavTop = $('.nav').offset().top;

    var stickyNav = function(){
    var scrollTop = $(window).scrollTop();

    if (scrollTop > stickyNavTop) {
        $('.nav').addClass('sticky');
    } else {
        $('.nav').removeClass('sticky');
    }
    };

    stickyNav();

    $(window).scroll(function() {
        stickyNav();
    });
  });

  var isMobile = {
      Android: function() {
          return navigator.userAgent.match(/Android/i);
      },
      BlackBerry: function() {
          return navigator.userAgent.match(/BlackBerry/i);
      },
      iOS: function() {
          return navigator.userAgent.match(/iPhone|iPad|iPod/i);
      },
      Opera: function() {
          return navigator.userAgent.match(/Opera Mini/i);
      },
      Windows: function() {
          return navigator.userAgent.match(/IEMobile/i);
      },
      any: function() {
          return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
      }
  };

  if(isMobile.any()) {
    } else {
            var sources = document.querySelectorAll('video#vid-div source');
            var video = document.querySelector('video#vid-div');
            for(var i = 0; i<sources.length;i++) { sources[i].setAttribute('src', sources[i].getAttribute('data-src'));
        }
    video.load();
  }

  // $('.make-answer-key').on('click', function(e){
  //   e.preventDefault();
  //     // debugger;
  //   var $answerFormContainer = $(this).prev().find('#answer-form-container')
  //   var myUrl = this.href;

  $('#link-container').on('click', function(event){
    event.preventDefault();
    var myUrl = $(this).find('a').attr('href');
    $(this).hide()
    $.ajax({
      method: 'get',
      url: myUrl
    }).done(function(response){
      $('#answer-form-container').html(response);
    }).fail(function(deffered){
      alert("fail");
    })

  })


});



