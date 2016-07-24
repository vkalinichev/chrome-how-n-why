do ( win=window, doc=document )->

    win['GoogleAnalyticsObject'] = "ga"
    win.ga ?= -> (win.ga.q ?= []).push arguments
    win.ga.l = +new Date

    el = doc.createElement( "script" )
    el.async = 1
    el.src = "https://www.google-analytics.com/analytics.js"

    sibling = doc.getElementsByTagName( "script" )[0]
    sibling.parentNode.insertBefore el, sibling

    console.log win.ga.q


ga = window.ga
ga "create", __gaCode__, "auto"
ga "send", "pageview"


module.exports =

    track: ( args... )->
        args.unshift "send"
        args.push nonInteraction: true
        ga.apply @, args

    trackInteraction: ( args... )->
        args.unshift "send"
        ga.apply @, args

