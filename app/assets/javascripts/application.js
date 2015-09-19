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


$(document).ready(function() {

    $('#searchGo').click(function(event){
            var qField = document.getElementById("searchField").value;
            event.preventDefault();
            query = "http://localhost:3000/search?utf8=%E2%9C%93&q=" + qField;
            window.location.href = query;
        }
    );

    $('#add-comment').click(function() {
     var task_id = $('#add-comment').attr('data-task-id');
     var comment = $('#text-area').val();
     $.ajax({
     type: 'POST', url: "http://localhost:3000/comments/create/",
     data:{
         comment:{
             this_comment: comment,
             task_id: task_id
         }
     },
     success: function(data){
     $('#comments').append('<div class="panel panel-default"><div class="panel-heading"><strong>'+
         data.email +
         '</strong> </div><div class="panel-body">' +
         data.text + '<div class= "delete" data-comment-id=" ' + data.id + '"><span class="glyphicon glyphicon-remove"></span></div>' +
         '</div></div>')},

     error: function(data){
     }
     });
     });

    $('#comments').delegate('.delete',"click",function(){
        $($($(this).parent()).parent()).hide("fast")
        var id = $(this).attr('data-comment-id');
        $.ajax({
            type: 'POST',
            url: "http://localhost:3000/comments/"+ id,
            data: {"_method":"delete"},
        })
    });



    $('#submitans').click(function () {
        var id = $('#submitans').attr('data-task-id');
        var answer = $('#answer').val();
        $.ajax({
            type: 'POST',
            url: id + "/decision" + "?answer=" + answer,
            success: function (data) {
                if (data.flag == "correct") {
                    $('#icon').attr('class', 'glyphicon glyphicon-ok-circle');
                    $('#answerfield').remove();
                    alert("Gooood motherfucker");
                }
                else
                    $('#icon').attr('class', 'glyphicon glyphicon-remove-circle');
            },
            error: function (data) {
            }
        });
    });

    $('#submitanss').click(function () {
        var id = $('#submitanss').attr('data-task-id');
        var mark = $('#markk').val();
        $.ajax({
            type: 'POST',
            url: id + "/marks" + "?mark=" + mark,
            success: function (data) {
                if (data.flag == "correct") {
                    alert("good");
                    $('#markfield').remove();
                }
                else
                    alert("Max mark = 10, min mark = 1");
            },
            error: function (data) {

//authFail();
            }
        });
    });

    var inputNum = document.getElementById('count');
    var x = inputNum.getElementsByTagName('input').length;
    $('#plus').click(function (e) {
        e.preventDefault();
        if (x < 5) {
            x++;
            $(".answers").append(
                '<div class="input-group">' +
                '<input type="text" class="text optional form-control" name="task[answers][]" value="" id="task_" />' +
                '<span class="input-group-btn">' +
                '<div class="remove_field">' +
                '<button class="btn btn-default" type="button">' +
                '<span class="glyphicon glyphicon-remove"></span>' +
                '</button>' +
                '</div>' +
                '</span>' +
                '</div>');
        }
        if (x == 5) $('#plus').css('visibility', 'hidden');
    });

    $(".answers").on("click", ".remove_field", function (e) {
        e.preventDefault();
        $(this).parent().parent().remove();
        x--;
        $('#plus').css('visibility', 'visible');

    });

});