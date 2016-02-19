'use strict';

(function () {
    var headers = document.querySelectorAll( 'h1,h2,h3,h1 *,h2 *,h3 *' );

    for (var i=0; i<headers.length; i++) {
        var header = headers[i],
            testString = header.innerText,
            isHow,
            isAlreadyWhyed,
            html;

        if ( testString ) {
            testString = testString.trim();
            isHow = testString.match( /^как/i );
            isAlreadyWhyed = testString.match( /зачем\?$/i );

            if ( isHow && !isAlreadyWhyed) {
                html = header.innerHTML;
                if ( html && html.match( /(:|,|\.|!|\?|\\|\/)$/ ) ) {
                    html = html.slice( 0, -1 )
                }
                header.innerHTML = html + ', а главное - <span style="color:#c04">зачем?</span>'
            }
        }
    }
}());