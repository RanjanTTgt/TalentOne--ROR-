import Controller from './loader_controller';

export default class extends Controller {

    static classes = ["display"];
    static targets = [ 'dropdown' ];


    connect() {
        $(document).ready(function(){
            $(".submenu.active i.fa-caret-right").removeClass("fa-caret-right").addClass('fa-caret-down');
            //navbar dropdown js
            $('.submenu-toggle').on('click' , function(){
                if($(this).parent().hasClass('active')){
                    $(this).parent().removeClass('active')
                    $(this).find('i.fa-caret-down').removeClass("fa-caret-down").addClass('fa-caret-right');
                } else {
                    $(this).parent().addClass('active')
                    $(this).find('i.fa-caret-down').removeClass("fa-caret-right").addClass('fa-caret-down');
                }
            });
        })
    }

}