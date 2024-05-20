
(function() {

    var bodyEl = document.body,
        content = document.querySelector( '.play-content' ),
        openbtn = document.getElementById( 'open-setting' ),
        closebtn = document.getElementById( 'close-setting' ),
        isOpen = false;

    function init() {
        initEvents();
    }

    function initEvents() {
        openbtn.addEventListener( 'click', toggleMenu );
        if( closebtn ) {
            closebtn.addEventListener( 'click', toggleMenu );
        }

        // close the menu element if the target it´s not the menu element or one of its descendants..
        content.addEventListener( 'click', function(ev) {
            var target = ev.target;
            if( isOpen && target !== openbtn ) {
                toggleMenu();
            }
        } );
    }

    function toggleMenu() {
        if( isOpen ) {
            console.log("关闭")
            classie.remove( bodyEl, 'show-setting' );
        }
        else {
            console.log("显示")
            classie.add( bodyEl, 'show-setting' );
        }
        isOpen = !isOpen;
    }

    init();

})();









