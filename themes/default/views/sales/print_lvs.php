<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $this->lang->line("invoice") . " " . $inv->reference_no; ?></title>
    <link href="<?php echo $assets ?>styles/theme.css" rel="stylesheet">
    <style type="text/css">

			* {
			margin: 0;
			padding:0;				  
			box-sizing: border-box; 
			}
            .padding0{
					  padding:0px;
				 }
			body {
			margin: 0; 
			font-weight: 500;
			-webkit-print-color-adjust: exact;
			font-family:Khmer OS Battambang;

			}
			.row-content{
				width:100%;
				float:left;
			}
			.foot{
			border-bottom:1px solid #fff !important;
			border-left:1px solid #fff !important;
			padding-right:20px;
			}
			@media screen,print
			{
			.wraper{
			width: 100%;
			float:left;
			}
			.bt{
			width:150px; 
			border:solid 2px;
			margin:0px;
			color:#AFAEAE !important;
			

			}
			.logo{
			width:100%;
			float:left;
			}
			.bg{
			background-color:orange !important;	 

			}
			.logo img{
			width:25%;
			height:auto;
			}
			.container-fluid{
			padding-left:30px;
			padding-right:10px;
			}
			.title h1{
			font-family:Khmer OS Muol Light;
			color:orange!important;
			text-decoration:underline;
			text-decoration-style:double;

			}
			.sub-title h2{
			font-family:Khmer OS Muol;
			font-size:25px;
			margin-bottom:20px;
			}
			.describe p{
			font-size:15px;
			}
			.invoice{
			width:100%;
			float:right;
			margin-top:45px;

			}
			input{
			text-align:center;
			}
			.content-invoice{
			width:100%;
			padding-top:20px;

			}
			table tr th{
			text-align:center;
			font-size:18px;
			
			}
             .pdT50{
				 padding-top:50px;
			 }
			
			 #btn{
			     width:10%;
                 background:#2B6EA5 url()			 
			 
			 }
    </style>
	
</head>

<body>
	<div class="wraper">  
			<div class="container-fluid pdT50">
				<div class="row-content">
					   <div class="col-md-12 padding0">
					   <div class="col-md-6 col-sm-6 col-xs-6">
							<img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
							alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
					   </div>
					   <div class="col-md-6 col-sm-6 col-xs-6">
						   <div class="pull-right title">
							 <h1>វិក័យប័ត្រ</h1>
						   </div>
					   </div>
					</div>
				</div>
				<div class="row-content">
					<div class="col-md-12 padding0">
						<div class="col-md-6 col-sm-8 col-xs-6">
							<div class="sub-title"><h2>សិប្បកម្មជាងួន</h2></div>
							<div class="describe"><p>ផលិតផលប្រហិតសាច់គោ ប្រហិតសាច់ជ្រូក</p></div>
							<table width="99%" border="0">
										  
										
								<tr>
									<td valign="top" width="90px">អាស័យដ្ឋាន :</td>
									<td>
										 <?php
										   echo $biller->address;'<br>'
										  ?>
									</td>
								</tr>
								<tr>
									<td>ទំនាក់ទ់ំនង​​ :</td>
									<td><?php echo $biller->phone;?></td>
								</tr>
								<tr>
									<td>អ៊ីម៉ែល​ :</td>
									<td><?php echo $biller->email;?></td>
								</tr>
								<tr>
									<td>ហ្វេសប៊ុក :</td>
									<td>បិតាប្រហិត888</td>
								</tr>
							</table>
						</div>
						<div class="col-md-6 col-sm-4 col-xs-6">
							<div class="invoice">
								<div class="pull-right">
								   <table  width="100%">
									  <tr>
										  <td width="115px"><?= lang("កាលបរិច្ឆទ"); ?>:</td>
										  <td style="text-align:center;border:solid 1px">
										   <?= $this->erp->hrld($inv->date); ?>
										  </td>
									  </tr>
									  <tr>	
										  <td>
											<?= lang("លេខវិក័យប័ត្រ"); ?>:
										  </td>
										  <td style="text-align:center;border:solid 1px">
										  ​​​	<?= $inv->reference_no; ?>
										  </td> 
									  </tr>
									  <tr class="bg">
										  <th colspan="2" height="35px;" style="text-align:left;border:solid 1px">អតិថិជន :</th>
										 
									  </tr>
									  <tr style="border:solid 1px">
										  <td colspan="2">
											   ក្រុមហ៊ុន/ហាង : <?=$customer->name?><br>
																															​​​​​​	អាស័យដ្ឋាន :<?php echo $customer->address;?>
																																	   <?php
											
											if($customer->phone !="-"){
												echo lang("<br>លេខទូរសព័្ទ") . ": " . $customer->phone;
											}
											?>
											
										  </td>
									  </tr>
									</table>
								
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row-content">
					<div class="col-md-12" class="he">
					  <table border="1px" width="100%" style="margin-top:35px;">
						<thead>
							  <tr class="bg" height="30px">
								<th width="30px"><?= lang("ល.រ"); ?></th>
								<th><?= lang("បរិយាយមុខទំនិញ"); ?></th>
								<th><?= lang("បិរមាណ"); ?></th>
								<th><?= lang("តំលៃរាយ"); ?></th>
								<th><?= lang("តំលៃសរុប"); ?></th>
			
							  </tr>
						</thead>
					<tbody>	
							<?php $r = 1;
								$total = 0;
								foreach ($rows as $row):
								$free = lang('free');
								$product_unit = '';
								if($row->variant){
									$product_unit = $row->variant;
								}else{
									$product_unit = $row->unit;
								}
								
								$product_name_setting;
								if($pos->show_product_code == 0) {
									$product_name_setting = ($row->promotion == 1 ? '<i class="fa fa-check-circle"></i> ' : '') . $row->product_name . ($row->variant ? ' (' . $row->variant . ')' : '');
								}else{
									$product_name_setting = ($row->promotion == 1 ? '<i class="fa fa-check-circle"></i> ' : '') . $row->product_name . " (" . $row->product_code . ")" . ($row->variant ? ' (' . $row->variant . ')' : '');
								}
							?>
					
						  <tr height="30px">
								<td align="center"><?php echo $r?></td>
								<td><?= $product_name_setting ?> <?= $row->details ? '<br>' . $row->details : ''; ?> </td>
								<td align="center"><?= $this->erp->formatQuantity($row->quantity); ?><?php echo $product_unit?></td>
								<td align="center"><?= $row->subtotal!=0?$this->erp->formatMoney($row->unit_price).'៛':$free; ?></td>
								<td align="center"><?php echo $this->erp->formatMoney($row->subtotal).'៛'?></td>
							
						  </tr>
						 
						  
						 <?php
							$r++;
						endforeach;
						?>
						<tr>
							<td>&nbsp;</td><td></td><td></td><td></td><td></td>
						</tr>
						<tr>
							<td>&nbsp;</td><td></td><td></td><td></td><td></td>
						</tr>
					</tbody>
					  <tfoot>
						  <tr height="30px"> 
							<td class="foot" colspan="4" border="0" align="right">សរុបទឺកប្រាក់​ </td>
							<td align="center">
							  <?= $this->erp->formatMoney($inv->grand_total).'៛';?>
							</td>
						  </tr>
					  </tfoot>
					  </table>
					  
				</div>
				   </div>
			</div>
				 <div class="container">
					   <div class="row-content">
						   <div class="col-md-12"style="padding-left:30px;margin-top:200px">
								   <div class="col-md-4 col-sm-4 col-xs-4">
									  <hr class="bt">
									 <p style="padding-left:45px;"> អ្នកទទួល</p>
								   </div>
								   <div class="col-md-4 col-sm-4 col-xs-4">
									  <hr class="bt">
									 <p style="padding-left:36px;"> អ្នកដឺកជញ្ជូន</p>
								   </div>
								   <div class="col-md-4 col-sm-4 col-xs-4">
									   <hr class="bt">
									 <p style="padding-left:49px;"> អ្នកលក់</p>
								   </div>
								   
						   </div>
					   </div>
					   <div class="row-content no-print">
							  
						  <div class="col-md-12" style="margin:50px 0px;">
										<button type="button" class="btn btn-primary btn-default     pull-left" onclick="window.print();">
											<i class="fa fa-print"></i> <?= lang('print'); ?>
										</button>&nbsp;&nbsp;
									​​​​    <!--
										<a href="<?=base_url()?>sales/invoice/<?=$sid?>" target="_blank"><button class="btn btn-primary " ><i class="fa fa-print"></i>&nbsp;<?= lang("LVS Invoice"); ?></button></a>&nbsp;&nbsp;
										
										<a href="<?=base_url()?>sales/tax_invoice/<?=$sid?>" target="_blank"><button class="btn btn-primary no-print" ><i class="fa fa-print"></i>&nbsp;<?= lang("print_tax_invoice"); ?></button>
										-->
										<a href="<?= site_url('sales'); ?>"><button class="btn btn-warning " ><i class="fa fa-heart"></i>&nbsp;<?= lang("back_to_sale"); ?></button></a>
							</div>
									  
								
					   </div>
					 
		 
		  </div>
				
	</div>
	<script type="text/javascript" src="<?= $assets ?>pos/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {
			$(window).load(function () {
				window.print();
			});
		});
	</script>
</body>
</html>