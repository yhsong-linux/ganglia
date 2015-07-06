<?php

include_once("./eval_conf.php");
include_once("./functions.php");

if ( isset($_GET['action']) && $_GET['action'] == "show_views" ) {
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  // Show available views
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  $available_views = get_available_views();
  ?>

  <table>
  <?php
  if ( isset($_GET['aggregate']) ) {
  ?>
     <tr><th>主机正则表达式</th><td><?php print join (",", $_GET['hreg']); ?></td></tr>
     <tr><th>指标正则表达式</th><td><?php print join (",", $_GET['mreg']); ?></td></tr>
  <?php
    } else {
  ?>
     <tr><th>主机名称</th><td><?php print $_GET['host_name']; ?></td></tr>
     <tr><th>指标/报告</th><td><?php print $_GET['metric_name']; ?></td></tr>
  <?php
  }
  ?>

  </table>
  <p>
  <form id="add_metric_to_view_form">
    添加至视图
    <?php 
    // Get all the aggregate form variables and put them in the hidden fields
    if ( isset($_GET['aggregate']) ) {
	foreach ( $_GET as $key => $value ) {
	  if ( is_array($value) ) {
	    foreach ( $value as $index => $value2 ) {
	      print '<input type=hidden name="' . $key .'[]" value="' . $value2 . '">';
	    }
	  } else {
	    print '<input type=hidden name=' . $key .' value="' . $value . '">';
	  }
	}
    } else {
      // If hostname is not set we assume we are dealing with aggregate graphs
      print "<input type=hidden name=host_name value=\"{$_GET['host_name']}\">";
      $metric_name=$_GET['metric_name'];
      print "<input type=hidden name=metric_name value=\"{$_GET['metric_name']}\">";
      print "<input type=hidden name=type value=\"{$_GET['type']}\">";
      if (isset($_GET['vl']) && ($_GET['vl'] !== ''))
	  print "<input type=hidden name=vertical_label value=\"{$_GET['vl']}\">";
      if (isset($_GET['ti']) && ($_GET['ti'] !== ''))
	  print "<input type=hidden name=title value=\"{$_GET['ti']}\">";
    }
    ?>

    <select onChange="addItemToView()" name="view_name">
    <option value='none'>请选择一个</option>
    <?php
    foreach ( $available_views as $view_id => $view ) {
      print "<option value='" . $view['view_name'] . "'>" . $view['view_name'] . "</option>";
    } 

  ?>
    </select>
  </form>
  <form>
    <p>
    添加警报: <p>
    发出警报,当值 
    <select name=alert_operator>
      <option value=more>大</option>
      <option value=less>小</option>
      <option value=equal>等</option>
      <option value=notequal>不等</option>
    </select> 于
    <input size=7 name=critical_value type=text>
    <button onClick="alert('尚未实现'); return false">添加</button>
  </form>

<?php

} // end of if ( isset($_GET['show_views']) {
?>
