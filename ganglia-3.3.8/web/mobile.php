<?php

include_once("./eval_conf.php");
include_once("./functions.php");

retrieve_metrics_cache();

/////////////////////////////////////////////////////////////////////////////
// With Mobile view we are gonna utilize the capability of putting in
// multiple pages in the same payload so that we avoid HTTP round trips
/////////////////////////////////////////////////////////////////////////////
?>
<!DOCTYPE html> 
<html> 
<head> 
<title>凝思系统监控软件便携终端视图</title> 
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/jquery.mobile-1.0.min.css" />
<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/jquery.mobile-1.0.min.js"></script>
<script type="text/javascript" src="js/jquery.liveSearch.js"></script>
<link type="text/css" href="css/jquery.liveSearch.css" rel="stylesheet" />
<style>
.ui-mobile .ganglia-mobile {  background: #e5e5e5 top center repeat-x; }
h2 { margin-top:1.5em; }
p code { font-size:1.2em; font-weight:bold; } 
dt { font-weight: bold; margin: 2em 0 .5em; }
dt code, dd code { font-size:1.3em; line-height:150%; }
</style>
</head> 
<body> 
<?php
  //  Build cluster array. So we know if there is more than 1
  foreach ( $index_array['cluster'] as $hostname => $clustername ) {
    $cluster_array[$clustername][] = $hostname;
  }
  
  $cluster_names = array_keys($cluster_array);
  
  $available_views = get_available_views();

?>
<div data-role="page" class="ganglia-mobile" id="mobile-home">
  <div data-role="header">
    <h1>凝思系统监控软件便携终端视图</h1>
  </div>
  <div data-role="content">
    请选择一个类别:<p>
    <ul data-role="listview" data-theme="g">
      <li><a href="#views">视图</a><span class="ui-li-count"><?php print sizeof($available_views); ?></span></li>
      <?php
	if ( sizeof($cluster_names) == 1) {
           print '<li><a href="#cluster-' . str_replace(" ", "_", $clustername) . '">Clusters</a><span class="ui-li-count">1</span></li>';
        } else {
      ?>
      <li><a href="#clusters">集群</a><span class="ui-li-count"><?php print sizeof($cluster_names); ?></span></li>
      <?php
      }
      ?>
      <li><a href="#search">搜索</a></li>
    </ul>
  </div><!-- /content -->
</div><!-- /page -->
<?php
if ( sizeof($cluster_names) > 1 ) {
?>
 <div data-role="page" class="ganglia-mobile" id="clusters">
  <div data-role="header">
	  <h1>凝思系统监控软件集群</h1>
  </div>
  <div data-role="content">	
    <ul data-role="listview" data-theme="g">
      <?php
      // List all clusters
      foreach ( $cluster_names as $index => $clustername ) {
	print '<li><a href="#cluster-' . str_replace(" ", "_", $clustername) . '">' . $clustername . '</a><span class="ui-li-count">' .  sizeof($cluster_array[$clustername]) . '</span></li>';  
      }
      ?>
    </ul>
  </div><!-- /content -->
</div><!-- /page -->
<?php
} // end of if (sizeof(cluster_names))

///////////////////////////////////////////////////////////////////////////////
// Create a sub-page for every cluster
///////////////////////////////////////////////////////////////////////////////
foreach ( $cluster_names as $index => $clustername ) {
?>
  <div data-role="page" class="ganglia-mobile" id="cluster-<?php print str_replace(" ", "_", $clustername); ?>">
    <div data-role="header">
	    <h1>集群 <?php print $clustername; ?></h1>
    </div>
    <div data-role="content">	
      <ul data-role="listview" data-filter="true" data-theme="g">
	<?php
	  print '<li><a href="mobile_helper.php?show_cluster_metrics=1&c=' . $clustername . '&r=' . $conf['default_time_range'] . '&cs=&ce=">集群概述</a></li>';  
	// List all hosts in the cluster
	asort($cluster_array[$clustername]);
	foreach ( $cluster_array[$clustername] as $index => $hostname ) {
	  print '<li><a href="mobile_helper.php?show_host_metrics=1&h=' . $hostname . '&c=' . $clustername . '&r=' . $conf['default_time_range'] . '&cs=&ce=">' . strip_domainname($hostname) . '</a></li>';  
	}
	?>
      </ul>
    </div><!-- /content -->
  </div><!-- /page -->
<?php
}
///////////////////////////////////////////////////////////////////////////////
// Views
///////////////////////////////////////////////////////////////////////////////
?>
<div data-role="page" class="ganglia-mobile" id="views">
  <div data-role="header">
	  <h1>凝思系统监控软件视图</h1>
  </div>
  <div data-role="content">
    <ul data-role="listview" data-filter="true" data-theme="g">
      <?php  
      // List all the available views
      foreach ( $available_views as $view_id => $view ) {
	$v = $view['view_name'];
	print '<li><a href="mobile_helper.php?view_name=' . $v . '&r=' . $conf['default_time_range'] . '&cs=&ce=">' . $v . '</a></li>';  
      }
      ?>
    </ul>
  </div><!-- /content -->
</div><!-- /page -->
<?php
///////////////////////////////////////////////////////////////////////////////
// Search
///////////////////////////////////////////////////////////////////////////////
?>
<script>
$(function(){
  jQuery('#search input[name="q"]').liveSearch({url: 'search.php?mobile=1&q=', typeDelay: 1000});
});

</script>
<div data-role="page" class="ganglia-mobile" id="search">
  <div data-role="header">
	  <h1>搜索</h1>
  </div>
  <div data-role="content">
    <p>
      <label>
	搜索主机或者一个指标: <br />
	<input type="text" name="q" id="search-field-q" on size=40 />
      </label>
    </p>
  </div>
  </div><!-- /content -->
</div><!-- /page -->
</body>
</html>
