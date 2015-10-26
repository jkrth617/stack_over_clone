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
      // alert(deffered.status + "ERROR: I duno what you were doing but Stop It")
    })
  })

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
      alert("something went wrong");
    })
  })

  $('#answer-form-container').on('submit', '#new_answer', function(event){
    event.preventDefault();
    var myData = $(this).serialize();
    var myType = $(this).attr('method');
    var myUrl = $(this).attr('action');
    $.ajax({
      url: myUrl,
      data: myData,
      method: myType
    }).done(function(response){
      $('.answer-list').append(response);
      $('#answer-form-container').html("");
      $('#link-container').show()
    }).fail(function(deffered){
      var message = " please fill in some information to you answer"
      if (deffered.status == 403){
        message = " you must log in"
      }
      alert(deffered.status + message)
    })

  })

  $('.answer-list').on('click', '#link-comment-container', function(e){
    e.preventDefault();
    $(this).hide();
    var $formLocation = $(this).parent().find('#comment-form-container');
    var myUrl = $(this).find('a').attr('href');
    $.ajax({
      method: 'get',
      url: myUrl
    }).done(function(response){
      $formLocation.html(response);
    }).fail(function(deffered){
      alert("something went wrong");
    })
  })

  $('.answer-list').on('submit','#new_comment', function(e){
    e.preventDefault()
    var $form = $(this);
    var $container = $form.parent().parent();
    var $appendTarget = $container.find('.comment-list');
    var myData = $form.serialize();
    var myType = $form.attr('method');
    var myUrl = $form.attr('action');
    $.ajax({
      url: myUrl,
      data: myData,
      method: myType}).done(function(response){
        $appendTarget.append(response);
        $form.html("");
        $container.find('#link-comment-container').show()
      }).fail(function(deffered){
        var message = " please fill in some information to you answer"
        if (deffered.status == 403){
          message = " you must log in"
        }
        alert(deffered.status + message)
      })
  })


  // $(document).ready(function() {
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
  // });

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

});



