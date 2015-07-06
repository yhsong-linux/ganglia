<!-- Begin show_node.tpl -->
<table border="0" width="100%">
<tr>
  <td colspan="2" class=title>{$name} 信息</td>
</tr>
<tr><td colspan="1">&nbsp;</td></tr>
<tr>
<td align="center">

<table cellpadding="2" cellspacing="7" border="1">
<tr>
<td class="{$class}">
   <table cellpadding="1" cellspacing="10" border="0">
   <tr><td valign="top"><font size="+2"><b>{$name}</b></font><br />
   <i>{$ip}</i><br />
   <em>地理坐标:</em> {$location}<p>

   集群本地时间 {$clustertime}<br />
   最近一次收到心跳 {$age} ago.<br />
   正常运行时间 {$uptime}<br />

   </td>
   <td align="right" valign="top">
   <table cellspacing="4" cellpadding="3" border="0"><tr>
   <tr><td><i>负载:</i></td>
   <td class={$load1}><small>{$load_one}</small></td>
   <td class={$load5}><small>{$load_five}</small></td>
   <td class={$load15}><small>{$load_fifteen}</small></td>
   </tr><tr><td></td><td><em>1分钟</em></td><td><em>5分钟</em></td><td><em>15分钟</em></td></tr>
   </table><br />

   <table cellspacing="4" cellpadding="3" border="0"><tr>
   <td><i>处理器利用率:</i></td>
   <td class={$user}><small>{$cpu_user}</small></td>
   <td class={$sys}><small>{$cpu_system}</small></td>
   <td class={$idle}><small>{$cpu_idle}</small></td>
   </tr><tr><td></td><td><em>用户</em></td><td><em>系统</em></td><td><em>空闲</em></td></tr>
   </table>
   </td>
   </tr>
   <tr><td align="left" valign="top">

   <b>硬件</b><br />
   <em>处理器{$s}:</em> {$cpu}<br />
   <em>内存 (RAM):</em> {$mem}<br />
   <em>本地磁盘:</em> {$disk}<br />
   <em>最完整的磁盘分区:</em> {$part_max_used}
   </td>
   <td align="left" valign="top">

   <b>软件</b><br />
   <em>操作系统:</em> {$OS}<br />
   <em>启动时间:</em> {$booted}<br />
   <em>正常运行时间:</em> {$uptime}<br />
   <em>交换分区:</em> {$swap}<br />

   </td></tr></table>
</td>
</tr></table>

 </td>
</tr>
<tr>
<td align="center" valign="middle">
 <a href="{$physical_view}">物理视图</a> | <a href="{$self}">重新加载</a>
</td>
</tr>
<tr>
 <td>
{if isset($extra)}
{include(file="$extra")}
{/if} 
</td>
</tr>
</table>
<!-- End show_node.tpl -->
