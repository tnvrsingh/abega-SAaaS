type = ['','info','success','warning','danger'];

var chartData;
getChartData();

demo = {
    initPickColor: function(){
        $('.pick-class-label').click(function(){
            var new_class = $(this).attr('new-class');
            var old_class = $('#display-buttons').attr('data-class');
            var display_div = $('#display-buttons');
            if(display_div.length) {
            var display_buttons = display_div.find('.btn');
            display_buttons.removeClass(old_class);
            display_buttons.addClass(new_class);
            display_div.attr('data-class', new_class);
            }
        });
    },

     showNotification: function(from, align){
      color = Math.floor((Math.random() * 4) + 1);

      $.notify({
          icon: "ti-gift",
          message: "Welcome to <b>Paper Dashboard</b> - a beautiful freebie for every web developer."

        },{
            type: type[color],
            timer: 4000,
            placement: {
                from: from,
                align: align
            }
        });
  }
}

function getChartData(){
        $.ajax({ 
              type: 'GET', 
              url: 'http://localhost:3000/sentimentdata', 
              dataType:'json',
              success: function (data) { 
                  console.log("JSON successfully received");
                  console.log("DATA : ");
                  //console.log(data);
                  chartData = data;
                  console.log(chartData);
                  initChartist();
              }
          });
}

function initChartist(){

      // Total Sentiment Score
        
        var TotalSentimentScore = {
          labels: ["anger", "anticipation", "disgust", "fear", "joy", "sadness", "surprise", "trust"],
          series: chartData.sentimentTotals.slice(0,8)
        };

        var optionsSales = {
          distributeSeries: true
        };

        Chartist.Bar('#chartTotalSentiment',TotalSentimentScore, optionsSales);

// Most Recent Sentiment


        var data = {
          labels:  ["anger", "anticipation", "disgust", "fear", "joy", "sadness", "surprise", "trust"],
          series: chartData.meanvalueweek
        };

        var options = {
            donut: true,
            donutWidth: 60,
            donutSolid: true,
            startAngle: 270,
            showLabel: true
        };


        Chartist.Pie('#chartActivity', data, options);

// Mean Sentiment Over Time

        var dataPreferences = {
          
        };

        var optionsPreferences = {
            seriesBarDistance: 10,
            reverseData: true,
            horizontalBars: true,
            axisY: {
              offset: 70
          }
        };

        Chartist.Pie('#chartPreferences', dataPreferences, optionsPreferences);

        Chartist.Pie('#chartPreferences', {
          labels: ['',''],
          series: chartData.meanvalueposneg
        });

        
//Month Statistics
        var MonthScore = {
          labels: ["anger", "anticipation", "disgust", "fear", "joy", "sadness", "surprise", "trust"],
          series: chartData.meanvaluemonth.slice(0,8)
        };

        var optionsSales = {
          distributeSeries: true
        };

        Chartist.Bar('#chartMonth',MonthScore, optionsSales);

    }