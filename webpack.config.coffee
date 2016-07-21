config = require "config"
path = require 'path'
webpackStream = require 'webpack-stream'
webpack = webpackStream.webpack

module.exports =
    context: path.join __dirname, "/src/scripts"

    output:
        filename: "hnw.js"

    module:
        loaders: [
            test: /\.coffee$/
            loader: "coffee-loader"
        ,
            test: /\.jade$/
            loader: "jade-loader"
        ,
#            test: /\.js/
#            loader: "uglify-loader"
        ]

    resolve:
        extensions: [
            ""
            ".coffee"
            ".jade"
            ".js"
        ]

    plugins: [
        new webpack.optimize.UglifyJsPlugin()
        new webpack.DefinePlugin
            __gaCode__: JSON.stringify config.googleAnalyticsCode
    ]

    devtool: 'source-map'