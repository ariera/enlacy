$(document).ready(function(){
    $('.links').sortable({
        axis: 'y',
        dropOnEmpty: false,
        handle: '.handle',
        cursor: 'crosshair',
        items: 'li',
        opacity: 0.4,
        scroll: true,
        update: function(){
            $.ajax({
                type: 'post',
                data: $('.links').sortable('serialize'),
                dataType: 'script',
                complete: function(request){
                    $('.links').effect('highlight');
                },
                url: '/links/sort'
            })
        }
    });
});