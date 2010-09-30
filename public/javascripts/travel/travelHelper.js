
function displayCity()
{
	var cityList = document.getElementById("cities_list");
	var elems = Element.getElementsBySelector(cityList,"option")
	for (var i = 0 ; i < elems.length ; i++)
	{
		Element.remove(elems[i]);
	}
	var option = document.createElement('option');
	option.value = "-1";
	option.text  = "Choose a city";
	cityList.options.add(option);
		
	var countryList = document.getElementById("countries_list");
	var index = countryList.selectedIndex;
	var value = countryList[index].value;
	if (value != "-1")
	{
		var params = {
			country_id: value
		};
		
		new Ajax.Request("/travel/getCities", {
			method: 'get',
			asynchronous: false,
			parameters: params,
			onSuccess: function(res){
				var data = res.responseText.evalJSON();
				var cityList = document.getElementById("cities_list");
	
				for (var i = 0 ; i < data.length ; i++)
				{
					var option = document.createElement('option');
					option.value = data[i][0];
					option.text  = data[i][1];
					cityList.options.add(option);
				}
				
			}
			
		});
	}
}

function goCity()
{
	var cityList = document.getElementById("cities_list");
	var index = cityList.selectedIndex;
	var value = cityList[index].value;
	if (value != "-1")
	{
		window.location = "/travel/city/" + value;
	}
}