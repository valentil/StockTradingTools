 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

 <script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['ColumnChart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);
		
      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
	  /*
      function drawChart() {

        // Create the data table.
		  var data = new google.visualization.DataTable();
		  data.addColumn('date', 'Minutes After Open');
		
		  data.addColumn('number', 'Option Volume on AAPL 0-3DTE'); //perl c:/stocks/options/optionsPrinter.pl 0 AAPL 0-3DTE<br>
		  data.addColumn({type: 'string', role: 'style'});
data.addRows([
	  [new  Date(2021,11,12, 16,08,42), 128531085, 'color: green']]);
/*
[new  Date(2021,11,12), '#b87333',128531085],
[new  Date(2021,11,12), 'color : red',-48562180],
[new  Date(2021,11,12,16,08,42), 'color : green',128531085],
[new  Date(2021,11,12,16,08,42), 'color : red',-48562180],
[new  Date(2021,11,12,16,34,57), 'color : green',180144353],
[new  Date(2021,11,12,16,35,54), 'color : green',180144353],
[new  Date(2021,11,12,16,37,40), 'color : green',180144353],
[new  Date(2021,11,12,16,37,56), 'color : green',180144353],
[new  Date(2021,11,14,13,18,33), 'color : green',97114335],
[new  Date(2021,11,14,13,18,33), 'color : red',-77676770],
[new  Date(2021,11,14,14,56,27), 'color : green',118821596],
[new  Date(2021,11,14,14,56,27), 'color : red',-73021019],
[new  Date(2021,11,14,15,05,46), 'color : green',130025659],
[new  Date(2021,11,14,15,05,46), 'color : red',-65954541],
[new  Date(2021,11,14,15,39,34), 'color : green',143140860],
[new  Date(2021,11,14,15,39,34), 'color : red',-67247988],
[new  Date(2021,11,14,15,46,18), 'color : green',137719567],
[new  Date(2021,11,14,15,46,18), 'color : red',-71292823],
[new  Date(2021,11,14,10,09,09), 'color : green',23127584],
[new  Date(2021,11,14,10,09,09), 'color : red',-29137820],
[new  Date(2021,11,14,10,14,56), 'color : green',26147473],
[new  Date(2021,11,14,10,14,56), 'color : red',-31520024],
[new  Date(2021,11,14,10,16,39), 'color : green',25093102],
[new  Date(2021,11,14,10,16,39), 'color : red',-34339562],
[new  Date(2021,11,14,10,21,18), 'color : green',28873914],
[new  Date(2021,11,14,10,21,18), 'color : red',-33967671],
[new  Date(2021,11,14,10,24,49), 'color : green',32752213],
[new  Date(2021,11,14,10,24,49), 'color : red',-31467030],
[new  Date(2021,11,14,10,30,21), 'color : green',28659446],
[new  Date(2021,11,14,10,30,21), 'color : red',-37275634],
[new  Date(2021,11,14,10,35,55), 'color : green',31110771],
[new  Date(2021,11,14,10,35,55), 'color : red',-36709659],
[new  Date(2021,11,14,10,42,53), 'color : green',31160948],
[new  Date(2021,11,14,10,42,53), 'color : red',-42758223],
[new  Date(2021,11,14,10,47,55), 'color : green',27790255],
[new  Date(2021,11,14,10,47,55), 'color : red',-52928987],
[new  Date(2021,11,14,11,01,34), 'color : green',32898199],
[new  Date(2021,11,14,11,01,34), 'color : red',-63055354],
[new  Date(2021,11,14,11,20,24), 'color : green',66507621],
[new  Date(2021,11,14,11,20,24), 'color : red',-65308932],
[new  Date(2021,11,14,11,32,22), 'color : green',69176643],
[new  Date(2021,11,14,11,32,22), 'color : red',-66154569],
[new  Date(2021,11,14,11,52,46), 'color : green',75821520],
[new  Date(2021,11,14,11,52,46), 'color : red',-68040769],
[new  Date(2021,11,14,12,17,20), 'color : green',68307026],
[new  Date(2021,11,14,12,17,20), 'color : red',-84487463],
[new  Date(2021,11,15,13,04,32), 'color : green',52826304],
[new  Date(2021,11,15,13,04,32), 'color : red',-34001396],
[new  Date(2021,11,15,13,32,56), 'color : green',73959944],
[new  Date(2021,11,15,13,32,56), 'color : red',-35715927],
[new  Date(2021,11,15,14,22,09), 'color : green',159329519],
[new  Date(2021,11,15,14,22,09), 'color : red',-22317926],
[new  Date(2021,11,15,14,32,35), 'color : green',168152570],
[new  Date(2021,11,15,14,32,35), 'color : red',-27550245],
[new  Date(2021,11,15,14,37,33), 'color : green',182249512],
[new  Date(2021,11,15,14,37,33), 'color : red',-24582936],
[new  Date(2021,11,15,14,39,57), 'color : green',219939990],
[new  Date(2021,11,15,14,39,57), 'color : red',-19494889],
[new  Date(2021,11,15,14,50,57), 'color : green',229758976],
[new  Date(2021,11,15,14,50,57), 'color : red',-24019994],
[new  Date(2021,11,15,15,03,53), 'color : green',257950939],
[new  Date(2021,11,15,15,03,53), 'color : red',-21432281],
[new  Date(2021,11,15,15,12,09), 'color : green',270190254],
[new  Date(2021,11,15,15,12,09), 'color : red',-22279631],
[new  Date(2021,11,15,15,14,50), 'color : green',286888710],
[new  Date(2021,11,15,15,14,50), 'color : red',-22357648],
[new  Date(2021,11,15,15,18,12), 'color : green',324167638],
[new  Date(2021,11,15,15,18,12), 'color : red',-20308469],
[new  Date(2021,11,15,15,21,18), 'color : green',338504988],
[new  Date(2021,11,15,15,21,18), 'color : red',-21106995],
[new  Date(2021,11,15,15,23,02), 'color : green',355522244],
[new  Date(2021,11,15,15,23,02), 'color : red',-20780789],
[new  Date(2021,11,15,15,27,33), 'color : green',326570638],
[new  Date(2021,11,15,15,27,33), 'color : red',-22192740],
[new  Date(2021,11,15,15,30,16), 'color : green',330666148],
[new  Date(2021,11,15,15,30,16), 'color : red',-22168878],
[new  Date(2021,11,15,15,32,19), 'color : green',325012516],
[new  Date(2021,11,15,15,32,19), 'color : red',-23154508],
[new  Date(2021,11,15,15,39,25), 'color : green',334976315],
[new  Date(2021,11,15,15,39,25), 'color : red',-22812288],
[new  Date(2021,11,15,15,42,03), 'color : green',319305140],
[new  Date(2021,11,15,15,42,03), 'color : red',-24430794],
[new  Date(2021,11,15,15,45,39), 'color : green',314531106],
[new  Date(2021,11,15,15,45,39), 'color : red',-25778211],
[new  Date(2021,11,15,15,49,32), 'color : green',317736924],
[new  Date(2021,11,15,15,49,32), 'color : red',-26149113],
[new  Date(2021,11,15,15,54,53), 'color : green',346866302],
[new  Date(2021,11,15,15,54,53), 'color : red',-22841743],
[new  Date(2021,11,15,16,01,01), 'color : green',360941791],
[new  Date(2021,11,15,16,01,01), 'color : red',-19470431],
[new  Date(2021,11,15,10,07,44), 'color : green',19006971],
[new  Date(2021,11,15,10,07,44), 'color : red',-15554288],
[new  Date(2021,11,15,10,12,29), 'color : green',19868553],
[new  Date(2021,11,15,10,12,29), 'color : red',-17142016],
[new  Date(2021,11,15,10,16,11), 'color : green',25622368],
[new  Date(2021,11,15,10,16,11), 'color : red',-17248324],
[new  Date(2021,11,15,10,23,33), 'color : green',31971464],
[new  Date(2021,11,15,10,23,33), 'color : red',-16453745],
[new  Date(2021,11,15,10,35,53), 'color : green',32552890],
[new  Date(2021,11,15,10,35,53), 'color : red',-17347855],
[new  Date(2021,11,15,10,47,11), 'color : green',35606917],
[new  Date(2021,11,15,10,47,11), 'color : red',-17585631],
[new  Date(2021,11,15,11,05,24), 'color : green',33445677],
[new  Date(2021,11,15,11,05,24), 'color : red',-21951580],
[new  Date(2021,11,15,11,10,46), 'color : green',33014376],
[new  Date(2021,11,15,11,10,46), 'color : red',-22941630],
[new  Date(2021,11,15,11,20,37), 'color : green',33125450],
[new  Date(2021,11,15,11,20,37), 'color : red',-24866382],
[new  Date(2021,11,15,11,30,51), 'color : green',35704868],
[new  Date(2021,11,15,11,30,51), 'color : red',-26410693],
[new  Date(2021,11,15,11,35,14), 'color : green',35871653],
[new  Date(2021,11,15,11,35,14), 'color : red',-28082460],
[new  Date(2021,11,15,11,41,33), 'color : green',36903406],
[new  Date(2021,11,15,11,41,33), 'color : red',-29154166],
[new  Date(2021,11,15,12,04,23), 'color : green',38514707],
[new  Date(2021,11,15,12,04,23), 'color : red',-34169464],
[new  Date(2021,11,15,12,22,30), 'color : green',38470149],
[new  Date(2021,11,15,12,22,30), 'color : red',-37598683],
   ]);
   
	 var formatter_hours = new google.visualization.DateFormat({pattern: "M/d/yy - H:m"});
  var formatter_medium = new google.visualization.DateFormat({formatType: 'medium'});
  var formatter_short = new google.visualization.DateFormat({formatType: 'short'});
	formatter_short.format(data, 2);
	formatter_hours.format(data, 0);
	//data.sort([{column: 0, desc: true}]);
	data.sort([{column: 0}]);
        // Set chart options
        var options = {'title':'AAPL|0-3DTE		Option Volume',
						'hAxis' : { 'textStyle' : { fontSize: 2 }},
					   'legend':'top',
                       'width':1600,
					   'column' : { groupWidth: '25%' },
                       'height':900,
					   allowHtml: true,
					   isStacked: true,
					   };
					   

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div_AAPL0-3DTE'));
        chart.draw(data, options);
      }
	*/
	     function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Year', 'Visitations', { role: 'style' } ],
        ['2010', 10, 'color: gray'],
        ['2020', 14, 'color: #76A7FA'],
        ['2030', 16, 'opacity: 0.2'],
        ['2040', 22, 'stroke-color: #703593; stroke-width: 4; fill-color: #C5A5CF'],
        ['2050', 28, 'stroke-color: #871B47; stroke-opacity: 0.6; stroke-width: 8; fill-color: #BC5679; fill-opacity: 0.2']
      ]);
	   var options = {
        title: "Density of Precious Metals, in g/cm^3",
        width: 600,
        height: 400,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
	  var chart = new google.visualization.ColumnChart(document.getElementById("chart_div_AAPL0-3DTE"));
      chart.draw(data, options);
		 }
	   
	  
		 
    </script><div id="chart_div_AAPL0-3DTE">AAPL 0-3DTE</div> <script type="text/javascript">
