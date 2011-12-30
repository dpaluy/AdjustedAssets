#= require highcharts/highcharts

chart = undefined
$(document).ready ->
  chart = new Highcharts.Chart(
    chart:
      renderTo: "chart"
      type: "spline"

    title:
      text: "P&L Graph"

    xAxis:
      title:
        text: "Stock Price"

    yAxis:
      title:
        text: "Profit & Loss"

    tooltip:
      formatter: ->
        "<b>" + @series.name + "</b><br/>" + "Strike: " + @x + ", P&L: " + @y + "$"

    series: [ 
      name: "Portfolio Value"   
      data: portfolio_value
    ]
  )
