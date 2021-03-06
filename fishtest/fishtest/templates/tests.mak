<%inherit file="base.mak"/>

<link href="/css/flags.css" rel="stylesheet">

<h2>Engine Testing Queue</h2>

%if page_idx == 0:

<h3>Pending - ${len(runs['pending'])} tests ${pending_hours} hrs <button id="pending-button" class="btn" data-toggle="collapse" data-target="#pending">Show</button></h3>
<div class="collapse" id="pending">
%if len(runs['pending']) == 0:
  None
%else:
  <%include file="run_table.mak" args="runs=runs['pending'], show_delete=True"/>
%endif
</div>

%if len(runs['failed']) > 0:
<h3>Failed</h3>
<%include file="run_table.mak" args="runs=runs['failed'], show_delete=True"/>
%endif

%if show_machines:
 <h3>Active - ${len(machines)} machines ${cores}
     cores ${'%.2fM' % (nps / (cores * 1000000.0 + 1))} nps
     (${'%.2fM' % (nps / (1000000.0 + 1))} total nps)
     ${games_per_minute} games/minute
 </h3>
 <table class="table table-striped table-condensed" style="max-width:960px">
  <thead>
   <tr>
    <th>Machine</th>
    <th>Cores</th>
    <th>MNps</th>
    <th>System</th>
    <th>Version</th>
    <th>Running on</th>
    <th>Last updated</th>
   </tr>
  </thead>
  <tbody>
 %for machine in machines:
   <tr>
    <td>${machine['username']}</td>
    <td>
    %if 'country_code' in machine:
      <div class="flag flag-${machine['country_code'].lower()}" style="display:inline-block"></div>
    %endif
    ${machine['concurrency']}</td>
    <td>${'%.2f' % (machine['nps'] / 1000000.0)}</td>
    <td>${machine['uname']}</td>
    <td>${machine['version']}</td>
    <td><a href="/tests/view/${machine['run']['_id']}">${machine['run']['args']['new_tag']}</td>
    <td>${machine['last_updated']}</td>
   </tr>
 %endfor
 %if len(machines) == 0:
   <td>No machines running</td>
 %endif
  </tbody>
 </table>
%else:
 <h3>Active - ${len(runs['active'])} tests</h3>
%endif
<%include file="run_table.mak" args="runs=runs['active']"/>

%endif

<h3>Finished - ${finished_runs} tests
%if len(pages) > 3:
 <span class="pagination pagination-small">
  <ul>
  %for page in pages:
   <li class="${page['state']}"><a href="${page['url']}">${page['idx']}</a></li>
  %endfor
  </ul>
 </span>
%endif
</h3>

<%include file="run_table.mak" args="runs=runs['finished']"/>

<script type="text/javascript">
if ($.cookie('pending_state') == 'Hide') {
  $('#pending').addClass('in');
  $('#pending-button').text('Hide');
}

$("#pending-button").click(function() {
  var active = $(this).text() == 'Hide';
  $(this).text(active ? 'Show' : 'Hide');
  $.cookie('pending_state', $(this).text());
});
</script>
