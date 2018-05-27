<h2>Directory summary</h2>
This is where all the so backend code is. 

Settings.py is there for configuration, best to leave that alone.

Profile.py is the main class, it calls classes:
<li>access.py</li>
<li>asntypes.py</li>
<li>demographics.py</li>
<li>ipv6.py</li>
<li>marketshare.py</li>
<li>v6marketshare.py</li>

Which act as controllers that pull data from the model (tables.py).
It is up to the database engineer to create the database and the database models in tables.py, these controllers should only be pulling the data with getdata querries and giving them id's. Note that I am surrounding all the querries in try catches so that the whole program doesn't crashes.


Each of the above are a section in a WIDER page (excluding the home and about page). They call tables that are innitialised in Tables.py which acts as the model.

<h2>Adding a table</h2>

<p>To add a table, you must first add a model. A model is the structure in which the data is called from the database, it is typically matched with a table in the database. All the models are added in tables.py. </p>


<p>In wazimap, there are 2 kind of models/tables, there's a FieldTable and a SimpleTable. A simple table is a table that we are use to, it has multiple columbs with values. A field table has 3 kinds of columns; the region (geo_code, geo_level, geo_id), the field values, and the actual values. I field table can be directly translated into a chart.</p>

<p>Secondly you need to call the chart data from the tables.py in one of the files above (depending on which catogory you want to put it in). You should use the get_stat_data function to call field table data.</p>

<p><b>view_ft_users, _ = get_stat_data(['type'], geo, session, table_name='ft_users_world_continent')</p></b>

<p>And then add it into the return json object with an id</p>
<pre><b>return	{
	'view_ft_users_population_users':{//This is to pass in the value you see at the left of each section (e.g. total users).
		"name": "World bank data.",
		"values": {"this": view_ft_users_population['Non-users']['numerators']['this']}
	},
	'view_ft_users': view_ft_users,
	'view_ft_users_population': view_ft_users_population,
}</b></pre>

Go to the front-end section under <b>templates</b> to see the last step.


