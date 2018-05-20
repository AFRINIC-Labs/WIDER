This is where all the so backend code is. 

Settings.py is there for configuration, best to leave that alone.

Profile.py is the main class, it calls classes:
<li>access.py</li>
<li>asntypes.py</li>
<li>demographics.py</li>
<li>ipv6.py</li>
<li>marketshare.py</li>
<li>v6marketshare.py</li>
Which act ass controllers that pull data from the model (tables.py)
It is up to the database engineer to create the database and the database models in tables.py, these controllers should only be pulling the data with getdata querries and giving them id's. Note that I am surrounding all the querries in try catches so that the whole program doesn't crashes.

Each of the above are a section in a WIDER page (excluding the home and about page). They call tables that are innitialised in Tables.py which acts as the model.

