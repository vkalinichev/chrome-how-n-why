'use strict';

(function () {
    var whyCounter = 0,
        style,
        url;

    function processHeader( selectors, element ) {
        var headers;

        element = element || document;
        headers = element.querySelectorAll( selectors );

        for (var i=0; i<headers.length; i++) {
            var header = headers[i],
                html = header.innerHTML,
                isHow,
                isAlreadyWhyed;

            if ( !html ) continue;

            html = html.trim();
            isHow = html.match( /^как/i );

            if ( !isHow ) continue;
            isAlreadyWhyed = html.match( /зачем\?$/i );

            if ( isAlreadyWhyed ) continue;

            if ( html && html.match( /(:|,|\.|!|\?|\\|\/)$/ ) ) {
                html = html.slice( 0, -1 )
            }

            header.innerHTML = html + '<span class="howandwhy">, а главное - <span class="howandwhy__term"><span class="howandwhy__baloon"></span><span class="howandwhy__why">зачем?</span></span></span>';
            whyCounter++;
        }
    }

    function process ( element ) {
        processHeader( 'h1 *,h2 *,h3 *', element );
        processHeader( 'h1,h2,h3', element );
    }

    function onDOMChanged ( event ) {
        if (!event.target.nodeName.match(/^#/)) {
            process( event.target );
        }
    }

    process();

    if ( whyCounter ) {
        style = document.createElement( 'link' );
        url = chrome.extension.getURL("css/howandwhy.css");
        style.rel = url;
        document.body.appendChild( style );
    }

    document.documentElement.addEventListener( 'DOMNodeInserted', onDOMChanged )
}());