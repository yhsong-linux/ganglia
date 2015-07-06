<table cellpadding="1" border="0" width="100%">
<tr>
<td colspan=3 class="title">{$cluster} 集群 - 物理视图 |
 <font size="-1">列&nbsp;&nbsp;{$cols_menu}</font>
</td>

<tr>
<td align="center" valign="top">
   详细级别 (下列数值越低越紧凑):<br />
   {foreach $verbosity_levels verbosity checked}
   {$verbosity} <input type="radio" name="p" value="{$verbosity}" OnClick="ganglia_form.submit();" {$checked} />&nbsp;
   {/foreach}
</td>

<td align="left" valign="top" width="25%">
处理器总数: <b>{$CPUs}</b><br />
物理内存总量: <b>{$Memory}</b><br />
</td>

<td align="left" valign="top" width="25%">
磁盘总大小: <b>{$Disk}</b><br />
最完整磁盘: <b>{$most_full}</b><br />
</td>

</tr>
<tr>
<td align="left" colspan="3">

<table cellspacing="20">
<tr>
{foreach $racks rack}
   <td valign="top" align="center">
      <table cellspacing="5" border="0">
         {$rack.RackID}
         {$rack.nodes}
      </table>
   </td>
   {$rack.tr}
{/foreach}
</tr></table>

</td></tr>
</table>

<hr />


<table border="0">
<tr>
 <td align="left">
<font size="-1">
说明
</font>
 </td>
</tr>
<tr>
<td class="odd">
<table width="100%" cellpadding="1" cellspacing="0" border="0">
<tr>
 <td style="color: blue">节点名称&nbsp;<br /></td>
 <td align="right" valign="top">
  <table cellspacing=1 cellpadding=3 border="0">
  <tr>
  <td class="L1" align="right">
  <font size="-1">1分钟负载</font>
  </td>
  </tr>
 </table>
<tr>
<td colspan="2" style="color: rgb(70,70,70)">
<font size="-1">
<em>处理器: </em> 处理器时钟 (GHz) (处理器个数)<br />
<em>内存: </em> 内存总量 (GB)
</font>
</td>
</tr>
</table>

</td>
</tr>
</table>
