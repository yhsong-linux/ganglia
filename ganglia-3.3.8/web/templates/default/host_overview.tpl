<br>
<table border="0" width="100%">

<tr>
 <td align="left" valign="TOP">

<img src="{$node_image}" class="noborder" height="60" width="30" title="{$host}"/>
{$node_msg}

<table border="0" width="100%">
<tr>
  <td colspan="2" class="title">时间和字符串指标</td>
</tr>

{foreach $s_metrics_data s_metric}
<tr>
{if $s_metric.name == "Last Boot Time"}
 <td class="footer" width="30%">启动时间</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Gexec Status"}
 <td class="footer" width="30%">运行代理状态</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Gmond Started"}
 <td class="footer" width="30%">代理守护进程启动时间</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "IP Address"}
 <td class="footer" width="30%">主机IP地址</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Last Reported"}
 <td class="footer" width="30%">最近一次报告</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Location"}
 <td class="footer" width="30%">主机所在地理坐标</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Machine Type"}
 <td class="footer" width="30%">主机类型</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Operating System"}
 <td class="footer" width="30%">操作系统</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Operating System Release"}
 <td class="footer" width="30%">操作系统发行版本</td><td>{$s_metric.value}</td>
</tr>
{/if}
{if $s_metric.name == "Uptime"}
 <td class="footer" width="30%">正常运行时间</td><td>{$s_metric.value}</td>
</tr>
{/if}
{/foreach}

<tr><td>&nbsp;</td></tr>

<tr>
  <td colspan="2" class="title">静态指标</td>
</tr>

{foreach $c_metrics_data c_metric}
<tr>
{if $c_metric.name == "CPU Count"}
 <td class="footer" width="30%">处理器计数</td><td>{$c_metric.value}</td>
</tr>
{/if}
{if $c_metric.name == "CPU Speed"}
 <td class="footer" width="30%">处理器速度</td><td>{$c_metric.value}</td>
</tr>
{/if}
{if $c_metric.name == "Memory Total"}
 <td class="footer" width="30%">物理内存总量</td><td>{$c_metric.value}</td>
</tr>
{/if}
{if $c_metric.name == "Swap Space Total"}
 <td class="footer" width="30%">交换分区总量</td><td>{$c_metric.value}</td>
</tr>
{/if}
{/foreach}
</table>

 <hr />
{if isset($extra)}
{include(file="$extra")}
{/if}
</td> 
</table>

