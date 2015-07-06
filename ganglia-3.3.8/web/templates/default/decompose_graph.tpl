<style>
.img_view {
  float: left;
  margin: 0 0 10px 10px;
}
</style>
<script>
  function refreshDecomposeGraph() {
    $("#decompose-graphs img").each(function (index) {
	var src = $(this).attr("src");
	if (src.indexOf("graph.php") == 0) {
          var l = src.indexOf("&_=");
          if (l != -1)
            src = src.substring(0, l);
	  var d = new Date();
	  $(this).attr("src", src + "&_=" + d.getTime());
	}    
    });
  }

  $(function() {
    $( "#popup-dialog" ).dialog({ autoOpen: false, minWidth: 850 });
    $("#create_view_button")
      .button()
      .click(function() {
	$( "#create-new-view-dialog" ).dialog( "open" );
    });;
  });
</script>
<div id="metric-actions-dialog" title="指标操作">
<div id="metric-actions-dialog-content">
	合适的指标操作.
</div>
</div>
<div id="popup-dialog" title="查看图表">
  <div id="popup-dialog-content">
  </div>
</div>
<div id="decompose-graph-content">
  <div id=decompose-graphs>
    {if $number_of_items == 0 }
    <div class="ui-widget">
      <div class="ui-state-default ui-corner-all" style="padding: 0 .7em;"> 
        <p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
          No graphs decomposed
      </div>
    </div>
    {else}
      {foreach $items item}
      <div class="img_view">
        <button title="导出CSV" class="cupid-green" onClick="javascript:location.href='graph.php?{$item.url_args}&amp;csv=1';return false;">CSV</button>
        <button title="导出JSON" class="cupid-green" onClick="javascript:location.href='graph.php?{$item.url_args}&amp;json=1';return false;">JSON</button>
        <button title="查看图表" onClick="inspectGraph('{$item.url_args}'); return false;" class="shiny-blue">查看</button>
        <br /><a href="graph_all_periods.php?{$item.url_args}"><img class="noborder {$additional_host_img_css_classes}" style="margin-top:5px;" src="graph.php?{$item.url_args}" /></a>
      </div>
      {/foreach}
    {/if}
  </div>
</div>
<div style="clear: left"></div>
