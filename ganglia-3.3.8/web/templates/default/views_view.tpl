<style type="text/css">
.img_view {
  float: left;
  margin: 0 0 10px 10px;
}
</style>

<script type="text/javascript">
  function refreshView() {
    $("#view_graphs img").each(function (index) {
	var src = $(this).attr("src");
	if (src.indexOf("graph.php") == 0) {
	  var d = new Date();
	  $(this).attr("src", jQuery.param.querystring(src, "&_=" + d.getTime()));
	}    
    });
  }

  $(function() {
    $( "#popup-dialog" ).dialog({ autoOpen: false, minWidth: 850 });
    $("#create_view_button")
      .button()
      .click(function() {
	$( "#create-new-view-dialog" ).dialog( "open" );
    });
    highlightSelectedView('{$view_name}');
  });
</script>

<div id="popup-dialog" title="查看图表">
  <div id="popup-dialog-content">
  </div>
</div>

<table id="views_table">
<tr><td valign="top">
<div id="views_menu">
  <p>已存在视图:</p>
  <ul id="navlist">
    {$existing_views}
  </ul>
</div>
</td>
<td valign="top">
<div>
<div id="views-content">
  <div id=view_graphs>
    {if isset($number_of_view_items)}
    {if $number_of_view_items == 0 }
    <div class="ui-widget">
      <div class="ui-state-default ui-corner-all" style="padding: 0 .7em;"> 
        <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
          没有为此视图定义图表.请添加 
      </div>
    </div>
    {else}
      {$i = 0}
      {foreach $view_items view_item}
      {$graphId = cat($GRAPH_BASE_ID "view_" $i)}
      {$showEventsId = cat($SHOW_EVENTS_BASE_ID "view_" $i)}
      <div class="img_view">
        <button title="导出CSV" class="cupid-green" onClick="javascript:location.href='graph.php?{$view_item.url_args}&amp;csv=1';return false;">CSV</button>
        <button title="导出JSON" class="cupid-green" onClick="javascript:location.href='graph.php?{$view_item.url_args}&amp;json=1';return false;">JSON</button>
        {if $view_item.aggregate_graph == 1}
        <button title="Decompose aggregate graph" class="shiny-blue" onClick="javascript:location.href='?{$view_item.url_args}&amp;dg=1&amp;tab=v';return false;">Decompose</button>
        {/if}
        <button title="查看图表" onClick="inspectGraph('{$view_item.url_args}'); return false;" class="shiny-blue">查看</button>
        <input title="隐藏/显示事件" type="checkbox" id="{$showEventsId}" onclick="showEvents('{$graphId}', this.checked)"/><label class="show_event_text" for="{$showEventsId}">隐藏/显示事件</label>
        <br />
{if $graph_engine == "flot"}
<div id="placeholder_{$view_item.url_args}" class="flotgraph2 img_view"></div>
<div id="placeholder_{$view_item.url_args}_legend" class="flotlegend"></div>
{else}
<a href="graph_all_periods.php?{$view_item.url_args}"><img id="{$graphId}" class="noborder {$additional_host_img_css_classes}" style="margin-top:5px;" src="graph.php?{$view_item.url_args}" /></a>
{/if}
      </div>
      {math "$i + 1" assign=i}
      {/foreach}
    {/if}
    {/if}
  </div>
</div>
<div style="clear: left"></div>
</div>
</td>
</tr>
</table>

