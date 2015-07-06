<table cellspacing=1 cellpadding=1 width="100%" border=0>
 <tr><td>处理器总数:</td><td align=left><B>{$cpu_num}</B></td></tr>
 <tr><td width="60%">正在运行主机数:</td><td align=left><B>{$num_nodes}</B></td></tr>
 <tr><td>已关闭主机数:</td><td align=left><B>{$num_dead_nodes}</B></td></tr>
 <tr><td>&nbsp;</td></tr>
 <tr><td colspan=2><font class="nobr">当前平均负载 (15, 5, 1分钟):</font><br>&nbsp;&nbsp;<b>{$cluster_load}</b></td></tr>
{if $range == "hour"}
 <tr><td colspan=2>平均利用率 (最近 1小时):<br>&nbsp;&nbsp;<b>{$cluster_util}</b></td></tr>
{/if}
{if $range == "2hr"}
 <tr><td colspan=2>平均利用率 (最近 2小时):<br>&nbsp;&nbsp;<b>{$cluster_util}</b></td></tr>
{/if}
{if $range == "4hr"}
 <tr><td colspan=2>平均利用率 (最近 4小时):<br>&nbsp;&nbsp;<b>{$cluster_util}</b></td></tr>
{/if}
{if $range == "day"}
 <tr><td colspan=2>平均利用率 (最近 1天):<br>&nbsp;&nbsp;<b>{$cluster_util}</b></td></tr>
{/if}
{if $range == "week"}
 <tr><td colspan=2>平均利用率 (最近 1周):<br>&nbsp;&nbsp;<b>{$cluster_util}</b></td></tr>
{/if}
{if $range == "month"}
 <tr><td colspan=2>平均利用率 (最近 1月):<br>&nbsp;&nbsp;<b>{$cluster_util}</b></td></tr>
{/if}
{if $range == "year"}
 <tr><td colspan=2>平均利用率 (最近 1年):<br>&nbsp;&nbsp;<b>{$cluster_util}</b></td></tr>
{/if}
 </table>
