const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery/src/jquery',
    jquery: 'iquery/src/jquery',
    Popper: 'popper.js'
  })
)

module.exports = environment
