_gaq = window._gaq or (window._gaq = [])
_gaq.push [ "_setAccount", __gaCode__ ]
_gaq.push [ "_trackPageview"]


do ->
  ga = document.createElement "script"
  ga.type = "text/javascript"
  ga.async = true
  ga.src = "https://ssl.google-analytics.com/ga.js"
  s = document.getElementsByTagName("script")[0]
  s.parentNode.insertBefore(ga, s)


module.exports =

    track: ( text )->
        _gaq.push [ "_trackEvent", text, "showed" ]


