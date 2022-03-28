# auto_pdc_gen
Cadence pstxref.dat pin information for libero .pdc genneration

./worklib/yellowbird/packaged/pstxref.dat 包含交叉标注信息。包含所有的逻辑－物理分配、网络名称和元件。


在设计过程中，可以使用Report栏指定 Package-XL 输出。
*  Output：指定打包创建的输出，缺省是 All。如果选择定制 Custom，从下列输出 
中选择：  
Netlist－创建以下文件：pstchip.dat：包含每个元件的物理信息。Pstxnet.dat：列出每个网络的物理网络名称和节点。Pstxprt.dat：将逻辑元件和物理参考位号和section指定联系起来。  
Change－创建 pxl.chg文件，记录两个打包之间的变更。  
Report－创建 pstrprt.dat，提供元件概要。  
Pinlist－创建 pstpin.dat，包含设计指定的管脚列表。  
Xref－创建 pstxref.dat，包含交叉标注信息。包含所有的逻辑－物理分配、网络名称和元件。
