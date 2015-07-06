<!-- Begin footer.tpl -->
</form> <!-- ganglia-form -->
</div> <!-- tabs-main -->

<div id="tabs-search">
  搜索匹配任何数量指标和主机的词汇. 比如输入web或者disk; 等待一秒钟, 下拉菜单会显示不同的选项.
  <!-- Uses LiveSearch from http://andreaslagerkvist.com/jquery/live-search/ -->
  <div id="metric-search">
    <form method="post" action="/search/">
      <p>
	<label>
	    <small>搜索输入的内容</small><br />
	    <input type="text" name="q" id="search-field-q" size="60" placeholder="搜索输入的内容" on />
	</label>
      </p>
    </form>
  </div>
</div> 

<div id="create-new-view-dialog" title="Create new view">
  <div id="create-new-view-layer">
    <form id="create_view_form">
      <input type="hidden" name="create_view" value="1">
      <fieldset>
	 <label for="name">视图名称</label>
	 <input type="text" name="view_name" id="view_name" class="text ui-widget-content ui-corner-all" />
         <center><button onclick="createView(); return false;">创建</button></center>
      </fieldset>
    </form>
  </div>
  <div id="create-new-view-confirmation-layer"></div>
</div>

<div id="tabs-mobile"></div>

<div id="tabs-autorotation">
调用自动循环系统. 自动循环系统将对在一个视图中指定的所有图表/指标（彼此之间需等待30秒）做循环. 只要打开该页面循环系统就会运行.
<p>
请选择想要循环的视图.</p>
  <div id="tabs-autorotation-chooser">
正在下载视图, 请稍等...<img src="img/spinner.gif" />
  </div>
</div>

<hr />
<div align="center">
<font size="-1" class="footer">
凝思系统监控软件 版本1.0.9({$webfrontend_version},{$webbackend_version},{$rrdtool_version})<br />
数据解析时间 {$parsetime}.<br />
北京凝思科技有限公司<br />
</font>
</div>
</div> <!-- div-tabs -->
</BODY>
<!-- End footer.tpl -->
</HTML>

