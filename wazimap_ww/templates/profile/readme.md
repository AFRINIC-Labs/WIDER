This is the frontend page that creates the chartes, it is split up into 5 catogories:

<li>access.html</li>
<li>ipv6.html</li>
<li>marketshare.html</li>
<li>v6marketshare.html</li>
<li>asntypes.html</li>

under sub-directory wazimap_ww/templates/profile/sections/

These sections correspond to the .py pages under wazimap_ww/, that act as controller pages for these sections.

In the controller pages you load the content from the model (tables.py), format them and give them an id.

Here you load them by simply inserting a div:


<pre>"<div class="column-third" //how big the chart is.</li>
id="chart-<pie/bar/histogram>-<the id>" //chart + charttype + the data id you specified in the controllers. </li>
data-stat-type="scaled-percentage" //the data stat type, its either percentage or scaled-percentage.</li>
data-chart-title='Ratio of genders and stuff'>//The title you want to have showed.</li>
</div>"</pre>

