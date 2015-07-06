<!-- Begin host_view.tpl -->
<style type="text/css">
/* don't display legends for these small graphs */
.flotlegend, .flotlegendtoplabel {
  display: none !important;
}
.flotheader {
  margin-top: 2em;
}
.flottitle {
  padding-right: 4em;
  font-weight: bold;
}
button.button {
  font-size: 10pt;
  padding: 5px 10px 5px 10px;
}
button.button:hover {
  border-color: #000000;
  color: #000000;
  cursor: hand;
}
.img_view {
  float: left;
  margin: 0 0 10px 10px;
}
</style>
<script type="text/javascript">
var SEPARATOR = "_|_";
var ALL_GROUPS = "ALLGROUPS";
var NO_GROUPS = "NOGROUPS";
// Map metric group id to name
var g_mgMap = new Object();

function clearStoredMetricGroups() {
  var stored_groups = $('input[name="metric_group"]');
  stored_groups.val(NO_GROUPS);
}

function selectAllMetricGroups() {
  var stored_groups = $('input[name="metric_group"]');
  stored_groups.val(ALL_GROUPS);
}

function addMetricGroup(mgName) {
  var stored_groups = $('input[name="metric_group"]');

  var open_groups = stored_groups.val();
  if (open_groups == ALL_GROUPS)
    return; // no exceptions

  var groups = open_groups.split(SEPARATOR);
  switch (groups[0]) {
    case ALL_GROUPS:
      // Remove from except list
      for (var i = 1; i < groups.length; i++) {
        if (groups[i] == mgName) {
          groups.splice(i, 1);
          break;
        }
      }
      open_groups = groups.join(SEPARATOR);
    break;
    case NO_GROUPS:
      // Add to list if not already there
      var inList = false;
      for (var i = 1; i < groups.length; i++) {
         if (groups[i] == mgName) {
           inList = true;
           break;
         }
      }
      if (!inList) {
        open_groups += SEPARATOR;
        open_groups += mgName;
      }
    break;
    default:
      alert("Unrecognized group option - " + groups[0]);
  }
  stored_groups.val(open_groups);
}

function removeMetricGroup(mgName) {
  var stored_groups = $('input[name="metric_group"]');

  var open_groups = stored_groups.val();
  if (open_groups == NO_GROUPS)
    return; // no exceptions

  var groups = open_groups.split(SEPARATOR);
  switch (groups[0]) {
    case ALL_GROUPS:
      var inList = false;
      for (var i = 1; i < groups.length; i++) {
        if (groups[i] == mgName) {
          inList = true;
          break;
        }
      }
      if (!inList) {
        open_groups += SEPARATOR;
        open_groups += mgName;
      }
    break;
    case NO_GROUPS:
      for (var i = 1; i < groups.length; i++) {
        if (groups[i] == mgName) {
          groups.splice(i, 1);
          break;
        }
      }
      open_groups = groups.join(SEPARATOR);
    break;
    default:
      alert("Unrecognized group option - " + groups[0]);
  }
  stored_groups.val(open_groups);
}

function toggleMetricGroup(mgId, mgDiv) {
  var mgName = g_mgMap[mgId];
  if (mgDiv.is(":visible"))
    // metric group is being closed
    removeMetricGroup(mgName);
  else
    addMetricGroup(mgName);
  document.ganglia_form.submit();
}

function refreshHostView() {
  $.get('host_overview.php?h={$hostname}&c={$cluster}', function(data) {
    $('#host_overview_div').html(data);
  });

  $("#optional_graphs img").each(function (index) {
    var src = $(this).attr("src");
    if ((src.indexOf("graph.php") == 0) ||
        (src.indexOf("./graph.php") == 0)) {
      var d = new Date();
      $(this).attr("src", jQuery.param.querystring(src, "&_=" + d.getTime()));
    }    
  });

  $("#metrics img").each(function (index) {
    var src = $(this).attr("src");
    if ((src.indexOf("graph.php") == 0)  ||
        (src.indexOf("./graph.php") == 0)) {
      var d = new Date();
      $(this).attr("src", jQuery.param.querystring(src, "&_=" + d.getTime()));
    }    
  });
}

$(function() {
  var stored_groups = $('input[name="metric_group"]');
  stored_groups.val("{$g_open_metric_groups}");

  // Modified from http://jqueryui.com/demos/toggle/
  //run the currently selected effect
  function runEffect(id){
    //most effect types need no options passed by default
    var options = { };

    options = { to: { width: 200,height: 60 } }; 
    
    //run the effect
    if ($("#"+id).hasClass("metric-group")) {
      $("#"+id+"_div").toggle("blind",options,500,toggleMetricGroup(id, $("#"+id+"_div")));
    } else {
      $("#"+id+"_div").toggle("blind",options,500);
    }
  };
 
  //set effect from select menu value
  $('.button').click(function(event) {
    runEffect(event.target.id);
    return false;
  });

    $(function() {
	    $( "#edit_optional_graphs" ).dialog({ autoOpen: false, minWidth: 550,
	      beforeClose: function(event, ui) {  location.reload(true); } });
	    $( "#edit_optional_graphs_button" ).button();
	    $( "#save_optional_graphs_button" ).button();
	    $( "#close_edit_optional_graphs_link" ).button();
	    $( "#popup-dialog" ).dialog({ autoOpen: false, minWidth: 850 });
    });

    $("#edit_optional_graphs_button").click(function(event) {
      $("#edit_optional_graphs").dialog('open');
      $('#edit_optional_graphs_content').html('<img src="img/spinner.gif" />');
      $.get('edit_optional_graphs.php', "hostname={$hostname}", function(data) {
	      $('#edit_optional_graphs_content').html(data);
      })
      return false;
    });

    $("#save_optional_graphs_button").click(function(event) {
       $.get('edit_optional_graphs.php', $("#edit_optional_reports_form").serialize(), function(data) {
	      $('#edit_optional_graphs_content').html(data);
	      $("#save_optional_graphs_button").hide();
	    });
      return false;
    });

    $("#expand_all_metric_groups").click(function(event) {
      selectAllMetricGroups();
      document.ganglia_form.submit();
      return false;
    });

    $("#collapse_all_metric_groups").click(function(event) {
      clearStoredMetricGroups();
      document.ganglia_form.submit();
      return false;
    });
});
</script>

{if $graph_engine == "flot"}
<script language="javascript" type="text/javascript" src="js/jquery.flot.min.js"></script>
<script type="text/javascript" src="js/create-flot-graphs.js"></script>
<style type="text/css">
.flotgraph2 {
  height: {$graph_height}px;
  width:  {$graph_width}px;
}
</style>
{/if}

<style type="text/css">
  .toggler { width: 500px; height: 200px; }
  a.button { padding: .15em 1em; text-decoration: none; }
  #effect { width: 240px; height: 135px; padding: 0.4em; position: relative; }
  #effect h3 { margin: 0; padding: 0.4em; text-align: center; }
</style>

<div id="metric-actions-dialog" title="指标操作">
  <div id="metric-actions-dialog-content">
	合适的指标操作.
  </div>
</div>
<div id="popup-dialog" title="查看图表">
  <div id="popup-dialog-navigation"></div>
  <div id="popup-dialog-content">
  </div>
</div>

<div>
<button id="host_overview" class="button ui-state-default ui-corner-all">主机概述</button>
</div>

<div style="display: none;" id="host_overview_div">
{include('host_overview.tpl')}
</div>

<style type="text/css">
#edit_optional_graphs_button {
    font-size:12px;
}
#edit_optional_graphs_content {
    padding: .4em 1em .4em 10px;
}
</style>
<div id="edit_optional_graphs">
  <div style="text-align: center;">
    <button id="save_optional_graphs_button">Save</button>
  </div>
  <div id="edit_optional_graphs_content">Empty</div>
</div>

<div id="optional_graphs" style="padding-top:5px;">
{$optional_reports}
<div style='clear: left'></div>
{if $may_edit_cluster}
<div style="text-align:center"><button id="edit_optional_graphs_button">Edit Optional Graphs</button></div>
{/if}
</div>

<div id="sort_column_dropdowns" style="padding-top:5px;">
<table border="0" width="100%">
<tr>
  <td class="title">
  {$host} <strong>图表</strong> ({$host_metrics_count})
{if $range == "hour" }
   最近 <strong>1小时</strong>
{/if}
{if $range == "2hr" }
   最近 <strong>2小时</strong>
{/if}
{if $range == "4hr" }
   最近 <strong>4小时</strong>
{/if}
{if $range == "day" }
   最近 <strong>1天</strong>
 {/if}
 {if $range == "week" }
   最近 <strong>1周</strong>
 {/if}
{if $range == "month" }
   最近 <strong>1月</strong>
{/if}
{if $range == "year" }
   最近 <strong>1年</strong>
{/if}
{if $sort == "ascending" }
   排序 <strong>升序</strong>
{/if}
{if $sort == "descending" }
   排序 <strong>降序</strong>
{/if}
{if $sort == "by name" }
   排序 <strong>名称</strong>
{/if}

{if isset($columns_dropdown)}
  <font size="-1">
    列&nbsp;&nbsp;{$metric_cols_menu}
    尺寸&nbsp;&nbsp;{$size_menu}
  </font>
{/if}
  </td>
</tr>
</table>

</div>

<div id=metrics style="padding-top:5px">
<center>
<div style="padding-bottom:5px;">
<button id="expand_all_metric_groups" class="button ui-state-default ui-corner-all">展开所有指标组</button>
<button id="collapse_all_metric_groups" class="button ui-state-default ui-corner-all">折叠所有指标组</button>
</div>
<table>
<tr>
 <td>

{foreach $g_metrics_group_data group g_metrics}
{$mgId = "mg_"; $mgId .= regex_replace($group, '/[^a-zA-Z0-9_]/', '_')}
<table border="0" width="100%">
<tr>
  <td class="metric">
  <button id="{$mgId}" class="button ui-state-default ui-corner-all metric-group" title="Toggle {$group} metrics group on/off">{$group} metrics ({$g_metrics.group_metric_count})</button>
<script type="text/javascript">$(function() {
g_mgMap["{$mgId}"] = "{$group}";
})</script>
  </td>
</tr>
</table>

{if $g_metrics.visible}
<div id="{$mgId}_div">
{else}
<div id="{$mgId}_div" class="ui-helper-hidden">
{/if}
{if $g_metrics.visible}
<table><tr>
{$i = 0}
{foreach $g_metrics["metrics"] g_metric}
<td>
<font style="font-size: 9px">{$g_metric.metric_name} {if $g_metric.title != '' && $g_metric.title != $g_metric.metric_name}- {$g_metric.title}{/if}</font>
{if $may_edit_views}
{$graph_args = "&amp;";$graph_args .= $g_metric.graphargs;}
<button class="cupid-green" title="指标操作 - 添加至视图等" onclick="metricActions('{$g_metric.host_name}','{$g_metric.metric_name}', 'metric', '{$graph_args}'); return false;">+</button>
{/if}
<button title="导出CSV" class="cupid-green" onClick="javascript:location.href='./graph.php?{$g_metric.graphargs}&amp;csv=1';return false;">CSV</button>
<button title="导出JSON" class="cupid-green" onClick="javascript:location.href='./graph.php?{$g_metric.graphargs}&amp;json=1';return false;">JSON</button>
<button title="查看图表" onClick="inspectGraph('{$g_metric.graphargs}'); return false;" class="shiny-blue">查看</button>
<button title="未来6个月趋势" onClick="drawTrendGraph('./graph.php?{$g_metric.graphargs}&amp;trend=1&amp;z=xlarge'); return false;" class="shiny-blue">趋势</button>

{if $graph_engine == "flot"}
<br>
<div id="placeholder_{$g_metric.graphargs}" class="flotgraph2 img_view"></div>
<div id="placeholder_{$g_metric.graphargs}_legend" class="flotlegend"></div>
{else}
{$graphId = cat($GRAPH_BASE_ID $mgId $i)}
{$showEventsId = cat($SHOW_EVENTS_BASE_ID $mgId $i)}
<input title="隐藏/显示事件" type="checkbox" id="{$showEventsId}" onclick="showEvents('{$graphId}', this.checked)"/><label class="show_event_text" for="{$showEventsId}">隐藏/显示事件</label>
<br>
<a href="./graph_all_periods.php?{$g_metric.graphargs}&amp;z=large">
<img id="{$graphId}" class="noborder {$additional_host_img_css_classes}" style="margin:5px;" alt="{$g_metric.alt}" src="./graph.php?{$g_metric.graphargs}" title="{$g_metric.desc}" />
</A>
{/if}
</td>
{$g_metric.new_row}
{math "$i + 1" assign=i}
{/foreach}
</tr>
</table>
{/if}
</div>
{/foreach}
 </td>
</tr>
</table>
</center>
</div>
<input type="hidden" name="metric_group" value="">
<!-- End host_view.tpl -->
