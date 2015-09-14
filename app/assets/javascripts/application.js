// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-markdown-bundle
//= require turbolinks
//= require_tree

var ready;
ready = function() {

    /*$('#add-comment').click(function() {
        var task_id = $('#submitans').attr('data-task-id');
        var comment = $('#text-area').val();
        $.ajax({
            type: 'POST',
            url: "http://localhost:3000/comments/create/",
            data:{
                comment:{
                    description: comment,
                    task_id: task_id
                }
            },
            success: function(data){
                $('#comments').append('<div class="panel panel-default"><div class="panel-heading"><strong>'+data.username+ '</strong> <span class="text-muted">'+ data.time_ago+ '</span> </div><div class="panel-body">'+data.description+'</div></div>')},

            error: function(data){
                //authFail();
            }
        });
    });*/

    $('#plus').click(function() {
        $('#answers').append('<input class="text optional" type="text" value="" name="task[answers][]" id="task_" >');
    });

$('#submitans').click(function() {
    var id = $('#submitans').attr('data-task-id');
    var answer = $('#answer').val();
    //var complexibility = $('#submitans').attr('data-task-complexibility');
    $.ajax({
        type: 'POST',
        url: id + "/decision" + "?answer=" + answer /*+ "&complexibility=" + complexibility*/ ,
        success: function(data){
            if (data.flag == "correct"){
                $('#icon').attr('class','glyphicon glyphicon-ok-circle');
                $('#answerfield').remove();
                alert("Gooood motherfucker");
            }
            else
                $('#icon').attr('class','glyphicon glyphicon-remove-circle');
        },
        error: function(data){
        }
    });
});

    $('#submitanss').click(function() {
        var id = $('#submitanss').attr('data-task-id');
        var mark = $('#markk').val();
        $.ajax({
            type: 'POST',
            url: id + "/marks" + "?mark=" + mark,
            success: function(data){
                if (data.flag == "correct"){
                    alert("good");
                    $('#markfield').remove();}
                else
                    alert("Max mark = 10, min mark = 1");
            },
            error: function(data){
            }
        });
    });


};

$(document).ready(ready);
$(document).on('page:load', ready);
