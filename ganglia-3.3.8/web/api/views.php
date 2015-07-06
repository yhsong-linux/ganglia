<?php

header("Content-Type: text/json");

$conf['gweb_root'] = dirname(dirname(__FILE__));

include_once $conf['gweb_root'] . "/eval_conf.php";
include_once $conf['gweb_root'] . "/functions.php";
include_once $conf['gweb_root'] . "/lib/common_api.php";

if ( !isset($_GET['action']) ) {
  api_return_error( "错误: 您需要至少指定一个操作" );
}

$events_array = ganglia_events_get();

if( ! checkAccess(GangliaAcl::ALL_VIEWS, GangliaAcl::VIEW, $conf) ) {
  api_return_error("您没有权限查看视图.");
}

switch ( $_GET['action'] ) {
  case 'get':
    $available_views = get_available_views();

    $found_view = false;
    foreach ( $available_views as $view_id => $view ) {
      if ( $view['view_name'] == $_GET['view_name'] ) {
        $found_view = true;
      }
    }
    if (!$found_view) {
      api_return_error("这个视图不存在.");
    }
    $view_suffix = str_replace(" ", "_", $_GET['view_name']);
    $view_filename = $conf['views_dir'] . "/view_" . $view_suffix . ".json";
    $this_view = json_decode(file_get_contents($view_filename), TRUE);
    api_return_ok($this_view);
    break; // end get

  case 'list':
    $views = get_available_views();
    $view_list = array();
    foreach ($views AS $k => $view) {
      if ($view['view_name'] != '') $view_list[] = $view['view_name'];
    }
    api_return_ok($view_list);
    break; // end list

  case 'create_view': 
  if( ! checkAccess( GangliaAcl::ALL_VIEWS, GangliaAcl::EDIT, $conf ) ) {
    api_return_error("您没有权限编辑视图.");
  } else {
    // Check whether the view name already exists
    $view_exists = 0;

    $available_views = get_available_views();

    foreach ( $available_views as $view_id => $view ) {
      if ( $view['view_name'] == $_GET['view_name'] ) {
        $view_exists = 1;
      }
    }

    if ( $view_exists == 1 ) {
      api_return_error("视图 ".$_GET['view_name']." 已存在.");
    } else {
      $empty_view = array ( "view_name" => $_GET['view_name'],
        "items" => array() );
      $view_suffix = str_replace(" ", "_", $_GET['view_name']);
      $view_filename = $conf['views_dir'] . "/view_" . $view_suffix . ".json";
      $json = json_encode($empty_view);
      if ( file_put_contents($view_filename, json_prettyprint($json)) === FALSE ) {
        api_return_error("不能写入文件 $view_filename. 也许权限是错误的.");
      } else {
        api_return_ok("视图已成功创建.");
      } // end of if ( file_put_contents($view_filename, $json) === FALSE ) 
    }  // end of if ( $view_exists == 1 )
  }
  break; // end create_view

//////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete view
//////////////////////////////////////////////////////////////////////////////////////////////////////
  case 'delete_view':
  if( ! checkAccess( GangliaAcl::ALL_VIEWS, GangliaAcl::EDIT, $conf ) ) {
    api_return_error("您没有权限编辑视图.");
  } else {
    // Check whether the view name already exists
    $view_exists = 0;

    $available_views = get_available_views();

    foreach ( $available_views as $view_id => $view ) {
      if ( $view['view_name'] == $_GET['view_name'] ) {
        $view_exists = 1;
      }
    }

    if ( $view_exists != 1 ) {
      api_return_error("视图 ".$_GET['view_name']." 不存在.");
    } else {
      $view_suffix = str_replace(" ", "_", $_GET['view_name']);
      $view_filename = $conf['views_dir'] . "/view_" . $view_suffix . ".json";
      if ( unlink($view_filename) === FALSE ) {
        api_return_error("不能删除文件 $view_filename. 也许权限是错误的.");
      } else {
        api_return_ok("视图已成功删除.");
      }
    }
  }
  break; // end delete_view

//////////////////////////////////////////////////////////////////////////////////////////////////////
// Add to view
//////////////////////////////////////////////////////////////////////////////////////////////////////
  case 'add_to_view':
  if( ! checkAccess( GangliaAcl::ALL_VIEWS, GangliaAcl::EDIT, $conf ) ) {
    api_return_error("您没有权限编辑视图.");
  } else {
    $view_exists = 0;
    // Check whether the view name already exists
    $available_views = get_available_views();

    foreach ( $available_views as $view_id => $view ) {
      if ( $view['view_name'] == $_GET['view_name'] ) {
        $view_exists = 1;
        break;
      }
    }

    if ( $view_exists == 0 ) {
      api_return_error("视图 ".$_GET['view_name']." 不存在. 这是不应该发生的.");
    } else {

      // Read in contents of an existing view
      $view_filename = $view['file_name'];
      // Delete the file_name index
      unset($view['file_name']);

      # Check if we are adding an aggregate graph
      if ( isset($_GET['aggregate']) ) {

	  foreach ( $_GET['mreg'] as $key => $value ) 
	    $metric_regex_array[] = array("regex" => $value);

	  foreach ( $_GET['hreg'] as $key => $value ) 
	    $host_regex_array[] = array("regex" => $value);

	  $item_array = array( "aggregate_graph" => "true", "metric_regex" => $metric_regex_array, 
	    "host_regex" => $host_regex_array, "graph_type" => $_GET['gtype'],
	    "vertical_label" => $_GET['vl'], "title" => $_GET['title']);

          if ( isset($_GET['x']) && is_numeric($_GET['x'])) {
            $item_array["upper_limit"] = $_GET['x'];
          }
          if ( isset($_GET['n']) && is_numeric($_GET['n'])) {
            $item_array["lower_limit"] = $_GET['n'];
          }

          $view['items'][] = $item_array;
          unset($item_array);

      } else {
	if ( $_GET['type'] == "metric" ) {
          $items = array( "hostname" => $_GET['host_name'], "metric" => $_GET['metric_name'] );
	  if (isset($_GET['vertical_label']))
              $items["vertical_label"] = $_GET['vertical_label'];
	  if (isset($_GET['title']))
              $items["title"] = $_GET['title'];
	  $view['items'][] = $items;
	} else
	  $view['items'][] = array( "hostname" => $_GET['host_name'], "graph" => $_GET['metric_name']);

      }

      $json = json_encode($view);

      if ( file_put_contents($view_filename, json_prettyprint($json)) === FALSE ) {
        api_return_error("不能写入文件 $view_filename. 也许权限是错误的.");
      } else {
        api_return_ok("视图已成功更新.");
      } // end of if ( file_put_contents($view_filename, $json) === FALSE ) 
    }  // end of if ( $view_exists == 1 )
  }
  break; // end add_to_view

} // end case action

?>
