$(document).ready(function(){
    var options = {
        axis: 'y',
        dropOnEmpty: false,
        handle: '.handle',
        cursor: 'crosshair',
        items: 'li',
        opacity: 0.4,
        scroll: true,
        update: function(){
            var $this = $(this);
            $.ajax({
                type: 'post',
                data: $this.sortable('serialize'),
                dataType: 'script',
                complete: function(request){
                    $this.effect('highlight');
                },
                url: '/links/sort?collection='+$this.attr('data-collection')
            })
        }
    }
    $('.main_links').sortable(options);
    $('.working_links').sortable(options);
});