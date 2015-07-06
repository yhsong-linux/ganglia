<style>
#aggregate_graph_table_form {
   font-size: 12px;
}
#show_direct_link {
  background-color: #eeeeee;
  text-align: center;
  padding: 5px;
}
</style>
<script>
  function refreshAggregateGraph() {
    $("#aggregate_graph_display img").each(function (index) {
	var src = $(this).attr("src");
	if (src.indexOf("graph.php") == 0) {
	  var d = new Date();
	  $(this).attr("src", jQuery.param.querystring(src, "&_=" + d.getTime()));
	}    
    });
  }

  function createAggregateGraph() {
    if ($('#hreg').val() == "" || $('#metric_chooser').val() == "") {
      alert("主机正则表达式和指标名称不能为空");
      return false;
    }

    var params = $("#aggregate_graph_form").serialize() + "&aggregate=1";
    $("#show_direct_link").html("<a href='graph_all_periods.php?" + params + "'>直接链接到本汇总图表</a>");
    $("#aggregate_graph_display").html('<img src="img/spinner.gif">');
    $.ajax({url: 'graph_all_periods.php', 
	    cache: false,
	    data: params + "&embed=1" , 
	    success: function(data) {
      $("#aggregate_graph_display").html(data);
	}});
    return false;
  }

$(function() {
  $( ".ag_buttons" ).button();
  $( "#graph_type_menu" ).buttonset();
  $( "#graph_legend_menu" ).buttonset();

  $("#hreg").change(function() {
    $.cookie("ganglia-aggregate-graph-hreg" + window.name,
      $("#hreg").val());
  });

  $("#vl").change(function() {
    $.cookie("ganglia-aggregate-graph-vl" + window.name,
      $("#vl").val());
  });

  $("#x").change(function() {
    $.cookie("ganglia-aggregate-graph-upper" + window.name,
      $("#x").val());
  });

  $("#n").change(function() {
    $.cookie("ganglia-aggregate-graph-lower" + window.name,
      $("#n").val());
  });

  $("#title").change(function() {
    $.cookie("ganglia-aggregate-graph-title" + window.name,
      $("#title").val());
  });

  $("#aggregate_graph_table_form input[name=gtype]").change(function() {
    $.cookie("ganglia-aggregate-graph-gtype" + window.name,
	   $("#aggregate_graph_table_form input[name=gtype]:checked").val());
  });

  function restoreAggregateGraph() {
    var hreg = $.cookie("ganglia-aggregate-graph-hreg" + window.name);
    if (hreg != null)
      $("#hreg").val(hreg);
  
    var gtype = $.cookie("ganglia-aggregate-graph-gtype" + window.name);
    if (gtype != null)
      $("#aggregate_graph_table_form input[name=gtype]").val([gtype]);
  
    var metric = $.cookie("ganglia-aggregate-graph-metric" + window.name);
    if (metric != null)
      $("#metric_chooser").val(metric);

    var title = $.cookie("ganglia-aggregate-graph-title" + window.name);
    if (title != null)
      $("#title").val(title);

    var vl = $.cookie("ganglia-aggregate-graph-vl" + window.name);
    if (vl != null)
      $("#vl").val(vl);

    var upper = $.cookie("ganglia-aggregate-graph-upper" + window.name);
    if (upper != null)
      $("#x").val(upper);

    var lower = $.cookie("ganglia-aggregate-graph-lower" + window.name);
    if (lower != null)
      $("#n").val(lower);
  
    if (hreg != null && metric != null)
      return true;
    else
      return false;
  }

  $( "#metric_chooser" ).autocomplete({
      source: availablemetrics,
      change: function(event, ui) {
	$.cookie("ganglia-aggregate-graph-metric" + window.name,
	         $("#metric_chooser").val());
      }
  });

  if (restoreAggregateGraph())
    createAggregateGraph();
});
</script>
<div id="aggregate_graph_header">
<h2>创建汇总图表</h2>
<form id="aggregate_graph_form">
<table id="aggregate_graph_table_form">
<tr>
<td>标题:</td>
<td colspan=2><input name="title" id="title" value="" size=60></td>
</tr>
<tr>
<td>纵坐标(Y轴)标签:</td>
<td colspan=2><input name="vl" id="vl" value="" size=60></td>
</tr>
<tr>
<td>范围设定</td><td>最大:<input name="x" id="x" value="" size=10></td><td>最小:<input name="n" id="n" value="" size=10></td>
</tr>
<tr>
<td>主机正则表达式 比如web-[0,4], web 或 (web|db):</td>
<td colspan=2><input name="hreg[]" id="hreg" size=60></td>
</tr>
<tr><td>指标正则表达式(比如load_one, bytes_(in|out)):</td>
<td colspan=2><input name="mreg[]" id="metric_chooser" size=60></td>
</tr>
<tr>
<td>图表类型:</td><td>
<div id="graph_type_menu"><input type="radio" name="gtype" id="gtline" value="line" checked /><label for="gtline">曲线图</label>
<input type="radio" name="gtype" id="gtstack" value="stack" /><label for="gtstack">堆积图</label></div>
</td>
</tr>
<tr>
<td>指标选择项:</td><td>
<div id="graph_legend_menu"><input type="radio" name="glegend" id="glshow" value="show" checked /><label for="glshow">显示指标值</label>
<input type="radio" name="glegend" id="glhide" value="hide" /><label for="glhide">隐藏指标值</label></div>
</td>
</tr>
<tr>
<td>
</td>
<td>
<button class="ag_buttons" onclick="createAggregateGraph(); return false">点击创建图表</button></td>
</tr>
</table>
</form>
</div>
<div style="margin-bottom:5px;" id="show_direct_link"></div>
<div id="aggregate_graph_display">
</div>

