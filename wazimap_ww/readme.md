This is where all the so backend code is. 

Settings.py is there for configuration, best to leave that alone.

Profile.py is the main class, it calls classes:
access.py
asntypes.py
demographics.py
ipv6.py
marketshare.py
v6marketshare.py

Each of the above are a section in a WIDER page (excluding the home and about page). They call tables that are innitialised in Tables.py

